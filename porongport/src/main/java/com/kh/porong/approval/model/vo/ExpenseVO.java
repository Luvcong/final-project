package com.kh.porong.approval.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @Getter @Setter @ToString
public class ExpenseVO {
	
	private int fixNo;
	private int edmsCategory;
	private String fixCategory;
	private String fixDetailCategory;
	private int fixPrice;

}
