package com.dreamland.prj.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class AppleaveDto {
	
	private int leaveNo, apvNo, empNo;
	private String leaveClassify, detail, leaveStatus, halfday, leaveStart, leaveEnd;;

}
