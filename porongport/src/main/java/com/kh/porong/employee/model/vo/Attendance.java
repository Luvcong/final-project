package com.kh.porong.employee.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Attendance {
	private String workDate;
	private int empNo;
	private String workStart;
	private String workEnd;
	
}
