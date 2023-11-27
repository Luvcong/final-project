package com.kh.porong.common.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public abstract class FileControllerBase {
	
	public String saveFile(MultipartFile upfile, HttpSession session, String path) {
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
		
		// 임의의 난수(5자리 랜덤값)
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		Path savePath = Paths.get(session.getServletContext().getRealPath("/resources"), "uploadFiles", path, changeName);
		
		try {
			upfile.transferTo(savePath);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return savePath.toString();
	}

}	// end class
