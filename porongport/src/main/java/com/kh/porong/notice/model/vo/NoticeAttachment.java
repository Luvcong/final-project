package com.kh.porong.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class NoticeAttachment {

	private int noticeFileNo;
	private String noticeOriginFileName;
	private String noticeChangeFileName;
	private String filePath;
	private String uploadDate;
	private int noticeNo;
}	// end class
