package com.dreamland.prj.service;

import java.util.List;

import com.dreamland.prj.dto.DepartmentDto;

public interface DepartService {

  public List<DepartmentDto> getDepartList();
  void updateNode(DepartmentDto departmentDto);
  void deleteNode(DepartmentDto departmentDto);
  
}
