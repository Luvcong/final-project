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
	private String edmsTitle;
	private Date edmsDate;
	private String edmsCategory;
	private String edmsReason;

}
