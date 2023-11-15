package com.kh.porong.calendar.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class MeetingRoomVO {
	private int meetNo;				//MEET_NO	NUMBER
	private int empNo;				//EMP_NO	NUMBER
	private String meetTutle;		//MEET_TITLE	VARCHAR2(50 BYTE)
	private String meetContent;		//MEET_CONTENT	VARCHAR2(100 BYTE)
	private int meetPnum;			//MEET_PNUM	NUMBER
	private Date meetStart;			//MEET_START	DATE
	private Date meetEnd;			//MEET_END	DATE
	private String meetStatus;		//MEET_STATUS	VARCHAR2(1 BYTE)
	private String meetApproval;	//MEET_APPROVAL VARCHAR2(1 BYTE)
	
}
