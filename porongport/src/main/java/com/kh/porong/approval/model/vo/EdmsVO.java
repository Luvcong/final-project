package com.kh.porong.approval.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class EdmsVO {
	
	private int edmsNo;
	private int empNo;
	private String edmsReception;
	private String edmsTitle;
	private Date edmsDate;
	private int edmsCategory;
	private String edmsReason;

}
