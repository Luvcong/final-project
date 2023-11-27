package com.kh.porong.calendar.model.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class ScheduleVO {
	private int schNo;			//SCH_NO		NUMBER
	private int empNo;			//EMP_NO		NUMBER
	private String schTitle;	//SCH_TITLE		VARCHAR2(50 BYTE)
	private String schContent;	//SCH_CONTENT	VARCHAR2(100 BYTE)
	private String schStart;	//SCH_START		DATE
	private String schEnd;		//SCH_END		DATE
	private String schStatus;	//SCH_STATUS	VARCHAR2(1 BYTE)
	private String schShare;	//SCH_SHARE		VARCHAR2(1 BYTE)
	private String correctionDate;
	
	private String startDate;
	private String startTime;
	private String endDate;
	private String endTime;
	
	private String deptName;	//DEPT_NAME VARCHAR2(20 BYTE)
	private String deptCode;
	private String empName;	//EMP_NAME
	
	
}
