package com.dreamland.prj.dto;

import java.util.List;

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
  private List<SkdShrEmpDto> shrEmp;
  private List<SkdShrDeptDto> shrDept;
  private List<String> sharedItems; // 사원 및 부서 공유 항목을 저장하는 필드
  
}
