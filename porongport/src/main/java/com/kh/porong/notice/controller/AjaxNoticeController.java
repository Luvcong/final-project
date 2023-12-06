package com.kh.porong.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import com.google.gson.Gson;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.notice.model.service.NoticeService;
import com.kh.porong.notice.model.vo.NoticeAttachment;
import com.kh.porong.reply.model.vo.Reply;


@Controller
public class AjaxNoticeController {
	
	public static final int BUFFER_SIZE = 4 * 1024;
	
	
	@Autowired
	private NoticeService noticeService;
	
	
	/**
	 * 공지사항 작성시 이미지 첨부하는 경우 filePath를 읽어들인 후 에디터 안에 미리보기
	 * @param name : uploadFile Method의 file name명
	 * @param request
	 * @param response
	 * @author JH
	 * @throws IOException 
	 * @Date : 2023. 11. 27
	 */
	@GetMapping("fileView")
	public void viewFile(String name, HttpServletRequest request, HttpServletResponse response) {
		if(name == null || name.equals(""))
			return;
		
        // 파일 크기 설정 4K
        byte[] buf   = new byte[BUFFER_SIZE];
        int readByte = 0;
        
        FileInputStream inputStream   = null;		// fis, fin
        ServletOutputStream outStream = null;		// sos, sout
        
        Path fullPath = Paths.get(request.getSession()
        							.getServletContext()
        							.getRealPath("/resources/uploadFiles/notice")
        							, name);
        
        if(!Files.exists(fullPath))
        	return;
        
        try{
        	inputStream = new FileInputStream(fullPath.toString());
            outStream = response.getOutputStream();
            
            while((readByte = inputStream.read(buf)) != -1){
            	outStream.write(buf, 0, readByte);
            }
            
            inputStream.close();
            outStream.close();
        }
        catch(IOException e){
        	e.fillInStackTrace(); 
        }
    }	// fileView
	
	
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
	
	
	/**
	 * 좋아요 설정 및 취소 처리
	 * getLike : true인경우 좋아요 Delete 수행
	 * getLike : false인경우 좋아요 insert 수행
	 * @param messageNo
	 * @param getLike
	 * @return 공지사항 게시글 좋아요 여부
	 * @author JH
	 * @Date : 2023. 11. 29
	 */
	@ResponseBody
	@GetMapping("likeCheck")
	public boolean likeCheck(@RequestParam(value="notice_no") int noticeNo,
							 @RequestParam(value="get_like") boolean getLike,
							 @SessionAttribute(name="loginUser", required=false) Employee loginUser) {
		
		int empNo = loginUser.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("noticeNo", noticeNo);
		map.put("getLike", getLike ? "Y" : "N");
		// Y인경우 좋아요 상태 - delete 수행
		// N인경우 좋아요x 상태 - insert 수행
		// System.out.println("map.get(\"getLike\") : " + map.get("getLike"));
		
		if(map.get("getLike").equals("Y")) {
			noticeService.deleteNoticeLike(map);
		} else {
			noticeService.insertNoticeLike(map);
		}
		// System.out.println("!getLike : " + !getLike);	// 좋아요 한 경우 false값 전달
		
		return !getLike;
	}	// likeCheck
	
	
	/**
	 * 공지사항 게시글 댓글 조회
	 * @param noticeNo : 공지사항 게시글 번호
	 * @return 공지사항 게시글 번호에 해당하는 댓글 리스트 반환
	 * @author JH
	 * @Date : 2023. 12. 2
	 */
	@ResponseBody
	@PostMapping(value="noticeReplyList", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int noticeNo) {
		return new Gson().toJson(noticeService.selectReplyList(noticeNo));
	}	// ajaxSelectReplyList
	
	
	/**
	 * 공지사항 게시글 댓글 작성
	 * @param r : reply VO 객체
	 * @return 공지사항 댓글 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 12. 2
	 */
	@ResponseBody
	@PostMapping("addReply")
	public String ajaxInsertReply(Reply r) {
		return noticeService.insertReply(r) > 0 ? "success" : "fail";
	}	// ajaxInsertReply
	
	
	/**
	 * 공지사항 게시글 댓글 삭제
	 * @param replyNo : 삭제하려는 댓글 SEQ번호
	 * @return 공지사항 댓글 삭제 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 12. 3
	 */
	@ResponseBody
	@PostMapping("deleteReply")
	public String deleteReply(int replyNo) {
		return noticeService.deleteReply(replyNo) > 0 ? "success" : "fail";
	}	// deleteReply
	
	
	/**
	 * 공지사항 게시글 수정시 파일 삭제
	 * @param changeFileName : 삭제하려는 파일 이름
	 * @return 파일 삭제 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 12. 4
	 */
	@ResponseBody
	@PostMapping("deleteFile")
	public String deleteFile(int noticeNo, int noticeFileNo) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("noticeNo", noticeNo);
		map.put("noticeFileNo", noticeFileNo);
		
		return noticeService.deleteNoticeAttach(map) > 0 ? "success" : "fail";
	}	// deleteFile
	
	
	
	}	// end class
