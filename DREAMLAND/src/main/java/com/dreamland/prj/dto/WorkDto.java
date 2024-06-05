package com.dreamland.prj.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class WorkDto {
	
  private int workNo, workTotalTime;
  private Date workDate; 
  private Timestamp  workIn, workOut;
  private String workState, lateYn;
  private EmployeeDto employee;
  
}
