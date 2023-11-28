package com.kh.porong.calendar.model.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class MeetingRoomVO {
	private int meetNo;				//MEET_NO	NUMBER
	private int empNo;				//EMP_NO	NUMBER
	private String meetTitle;		//MEET_TITLE	VARCHAR2(50 BYTE)
	private String meetContent;		//MEET_CONTENT	VARCHAR2(100 BYTE)
	private int meetPnum;			//MEET_PNUM	NUMBER
	private String meetStart;		//MEET_START	DATE
	private String meetEnd;			//MEET_END	DATE
	private String meetStatus;		//MEET_STATUS	VARCHAR2(1 BYTE)
	private String meetApproval;	//MEET_APPROVAL VARCHAR2(1 BYTE)
	
	private String meetStartDay;
	private String meetStartTime;
	private String meetEndDay;
	private String meetEndTime;
	
	private String deptName;
	private String empName;
	private String jobName;
	
}
