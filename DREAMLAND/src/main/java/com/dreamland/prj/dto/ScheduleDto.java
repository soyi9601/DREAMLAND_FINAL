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

public class ScheduleDto {
	
  private int skdNo, deptCode, empNo;
  private Date skdStart, skdEnd;
  private String skdCategory, skdTitle, skdContents;
  
}
