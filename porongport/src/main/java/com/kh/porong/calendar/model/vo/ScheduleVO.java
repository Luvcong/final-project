package com.kh.porong.calendar.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class ScheduleVO {
	private int schNo;			//SCH_NO	NUMBER
	private int empNo;			//EMP_NO	NUMBER
	private String schTitle;	//SCH_TITLE	VARCHAR2(50 BYTE)
	private String schContent;	//SCH_CONTENT	VARCHAR2(100 BYTE)
	private Date schStart;		//SCH_START	DATE
	private Date schEnd;		//SCH_END	DATE
	private String schStatus;	//SCH_STATUS	VARCHAR2(1 BYTE)
	private String branch;
}
