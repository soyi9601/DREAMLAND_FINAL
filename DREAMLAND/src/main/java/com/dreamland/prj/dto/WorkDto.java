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

public class WorkDto {
	
  private int workNo, workTotalTime, empNo;
  private Date workDate, workIn, workOut;
  private String workState, lateYn;
  
}
