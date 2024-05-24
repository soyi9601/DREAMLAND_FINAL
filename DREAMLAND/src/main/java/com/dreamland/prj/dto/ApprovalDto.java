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

public class ApprovalDto {
	
	private int apvNo, empNo, apvCheck;
	private String apvKinds, apvTitle;
	private Date apvWriteDate;

}
