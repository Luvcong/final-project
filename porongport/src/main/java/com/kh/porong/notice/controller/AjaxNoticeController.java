package com.kh.porong.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
	
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;


@Controller
public class AjaxNoticeController {
	
	
	/**
	 * 공지사항 작성시 이미지 첨부하는 경우 filePath를 읽어들인 후 에디터 안에 미리보기
	 * @param name : uploadFile Method의 file name명
	 * @param request
	 * @param response
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	@GetMapping("fileView")
	public void viewFile(String name, HttpServletRequest request, HttpServletResponse response) {
		// 서버에 저장된 이미지 경로
        Path fullPath = Paths.get(request.getSession().getServletContext().getRealPath("/resources/uploadFiles/notice"), name);
        
        // 사진 이미지를 찾지 못하는 경우 예외처리 > 빈 이미지 파일을 설정
        File file = fullPath.toFile();
        if(file.isFile() == false)
        	return;
        
        // 파일 크기 설정 4K
        byte[] buf = new byte[4*1024];
        int readByte = 0;
        
        FileInputStream inputStream = null;			// fis, fin
        ServletOutputStream outStream = null;		// sos, sout
        
        try{
            inputStream = new FileInputStream(file);
            outStream = response.getOutputStream();
            
            while((readByte = inputStream.read(buf)) != -1){
            	outStream.write(buf, 0, readByte);
            }
            
            inputStream.close();
            outStream.close();
        }
        catch(IOException e){
        }
    }	// viewFile
	
	
	/**
	 * 공지사항 작성시 이미지 첨부 > base64를 설정한 url로 변경처리
	 * @param request
	 * @param response
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	@PostMapping(value="fileUpload", produces="application/json; charset=UTF-8")
	public void uploadFile(HttpServletRequest request, HttpServletResponse response) {		
		DefaultMultipartHttpServletRequest multiFile = (DefaultMultipartHttpServletRequest) request;
		
		// 파일명 : 파일데이터
		Map<String, MultipartFile> map = multiFile.getFileMap();
		for (MultipartFile file : map.values()) {
			
			String name = file.getOriginalFilename();
			
			// 현재 시간
			String currentTime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());

			// 임의의 난수(5자리 랜덤값)
			int ranNum = (int) (Math.random() * 90000 + 10000);

			// 확장자
			String ext = name.substring(name.lastIndexOf("."));
			
			String changeName = currentTime + ranNum + ext;

			// 디렉토리 포함한 파일의 풀경로
			Path fullPath = Paths.get(request.getSession().getServletContext().getRealPath("/resources/uploadFiles/notice"), changeName);
			
			// 파일 null check
			try {
				if(!Files.exists(fullPath.getParent()))				// 디렉토리를 제외한 파일명만 구하기
					Files.createDirectories(fullPath.getParent());	// 해당 파일명이 없는 경우 파일 생성
				
				file.transferTo(fullPath);
				
				// ckeditor 이미지 업로드시 json사용하여 진행 필수 **
				JSONObject json = new JSONObject();
				json.put("uploaded", true);		// uploaded가 true라면
				json.put("url", "fileView?name=" + fullPath.getFileName());	// 생성해놓은 파일명 경로로 ck너가 url 변환해서 미리보기 띄워줘~
				
				response.getWriter().print(json.toString());
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}	// uploadFile
	
	}	// end class