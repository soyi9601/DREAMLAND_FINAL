package com.dreamland.prj.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class JsTreeDto {
	
  private int deptNo, depth;
  private String deptName, parentId, treeText;
  
  @Builder.Default
  private List<EmployeeDto> employee = new ArrayList<>();
}
