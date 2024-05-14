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

public class ApvWriterDto {
	
	private int apvNo, apvState, writerList, empNo;
	private String returnReason;
	private Date apvEmpTime;

}
