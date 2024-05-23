package com.dreamland.prj.service;

import java.util.List;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;

public interface DepartService {

  public List<DepartmentDto> getDepartList();
  void updateDepart(DepartmentDto departmentDto);
  void deleteDepart(DepartmentDto departmentDto);
  void deleteEmployee(EmployeeDto employeetDto);
  
}
