package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class DepartmentDto {
	
  private int deptNo, depth;
  private String deptName, parentId, treeText;

  
}
