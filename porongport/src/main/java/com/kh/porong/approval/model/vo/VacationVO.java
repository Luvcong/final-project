package com.kh.porong.approval.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class VacationVO {
	
	private int vctNo;
	private int edmsCategory;
	private String vctKind;
	private Date vctStart;
	private Date vctEnd;
	private String vctReason;
	private int empNo;
	
	private String deptCode;
	private String deptName;
	private String jobCode;
	private String jobName;
	private String empName;

}
