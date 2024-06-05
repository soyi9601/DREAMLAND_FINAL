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

public class OrgChartDto {
	
  private int deptNo, depth;
  private String deptName, parentId, treeText;
  private EmployeeDto employee;
  
  private int empNo, dayOff,  posNo;
  private String empName, email, address, detailAddress, password, profilePath, signPath, mobile, role, postcode,  posName;
  private Date birth, enterDate, resignDate;
}
