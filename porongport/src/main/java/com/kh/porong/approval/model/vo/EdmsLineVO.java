package com.kh.porong.approval.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class EdmsLineVO {
	
	private int edmsNo;
	private int empNo;
	private Date approvalDate;
	private Date acceptanceDate;
	private String paymentStatus;
	private int demsRownum;

}
