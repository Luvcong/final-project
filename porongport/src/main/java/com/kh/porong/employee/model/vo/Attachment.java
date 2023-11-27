package com.kh.porong.employee.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Attachment {
	private int fileNo;
	private String originFileName;
	private String changeFileName;
	private String filePath;
	private Date uploadDate;
	private int refEmpNo;
}
