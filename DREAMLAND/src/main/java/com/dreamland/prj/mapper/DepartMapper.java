package com.dreamland.prj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;

@Mapper
public interface DepartMapper {
  
  List<DepartmentDto> getDepartList();              // 조직도 조회
   
  void deleteDepart(DepartmentDto departmentDto);   // 부서 삭제
  void deleteEmployee(EmployeeDto employeeDto);     // 직원 삭제
  int hasEmployees(int deptNo);
  
  DepartmentDto getDepartById(int deptNo);          // 노드 클릭 후 부서 조회
  EmployeeDto getEmployeeById(int empNo);           // 노드 클릭 후 직원 조회
  
  void updateDepart(DepartmentDto departmentDto);   // 부서 정보 수정
  void updateEmployee(EmployeeDto employeeDto);     // 직원 정보 수정
  
  void insertDepart(DepartmentDto departmentDto);   // 부서 추가
}
