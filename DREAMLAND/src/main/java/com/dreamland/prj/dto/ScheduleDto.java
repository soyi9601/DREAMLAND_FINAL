package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ScheduleDto {
	
  private int skdNo;
  private String skdStart, skdEnd, skdCategory, skdTitle, skdContents, skdColor;
  private EmployeeDto employee;
  
}
