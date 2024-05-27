package com.dreamland.prj.service;

import java.util.List;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface DepartService {

  public List<DepartmentDto> getDepartList();
  void updateDepart(DepartmentDto departmentDto);
  void deleteDepart(DepartmentDto departmentDto);
  void deleteEmployee(EmployeeDto employeetDto);
  
  // 조직도 내에서 수정
  EmployeeDto getEmployeeById(int empNo);
  void updateEmployee(HttpServletRequest request);
  
  // 부서 추가
  void addDepartment(HttpServletRequest request, HttpServletResponse response);
  
}
