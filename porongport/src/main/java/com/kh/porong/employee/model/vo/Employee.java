package com.kh.porong.employee.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Employee {

	private int empNo;
	private String empName;
	private String empPwd;
	private String empPhone;
	private String empAddress;
	private String empAddressCode;
	private String empStatus;
	private String empAdmin;
	private String empEmail;
	private String deptCode;
	private String deptName;
	private String jobCode;
	private String jobName;
	private Date createDate;
	private Date modifyDate;
	//private int fileNo;
	private String empAnnual;
	private String empCount;
	private String firstLogin;
}
