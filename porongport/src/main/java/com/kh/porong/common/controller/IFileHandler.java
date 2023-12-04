package com.kh.porong.common.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public interface IFileHandler {
	
	public default String saveFile(MultipartFile upfile, HttpSession session, String path) {
		
		// System.out.println(path);
//		if(upfile.getOriginalFilename().length() == 0) {
//			return "";
//		}
		
		String originName = upfile.getOriginalFilename();
		// System.out.println(originName);
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
		
		// 임의의 난수(5자리 랜덤값)
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		// System.out.println(changeName);
		
		// Path savePaths= Paths.get(session.getServletContext().getRealPath("/resources"), "uploadFiles", path, changeName);
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		// 빌더 써서 합치기?
		// System.out.println("savePaths : " + savePaths);
		// System.out.println("savePath : " + savePath);
		
		try {
			// "resources/uploadFiles/" + changeName
			// upfile.transferTo(new File(savePath + changeName));
			upfile.transferTo(new File(savePath + path + changeName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// return savePaths.toString();
		// return "resources/uploadFiles/" + changeName;
		return "resources/uploadFiles/" + path + changeName;
	}

	
}	// end class
