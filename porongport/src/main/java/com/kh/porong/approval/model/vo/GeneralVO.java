package com.kh.porong.approval.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class GeneralVO {
	
	private int genNo;
	private int edmsCategory;
	private String genTitle;
	private String genContent;

}
