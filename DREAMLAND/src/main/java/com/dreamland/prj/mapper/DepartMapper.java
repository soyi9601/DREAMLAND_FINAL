package com.dreamland.prj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface DepartMapper {
  
  List<DepartmentDto> getDepartList();
  void updateDepart(DepartmentDto departmentDto);  
  void deleteDepart(DepartmentDto departmentDto);
  void deleteEmployee(EmployeeDto employeeDto);
  
  EmployeeDto getEmployeeById(String email); // 조직도 내에서 직원 수정
  void updateEmployee(EmployeeDto employeeDto);
}
