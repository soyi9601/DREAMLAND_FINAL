package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.JsTreeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface DepartService {

  List<JsTreeDto> getDepartList();                  // 조직도 조회
  void removeDepart(DepartmentDto departmentDto);   // 부서 삭제
  void removeEmployee(EmployeeDto employeetDto);    // 직원 삭제
  boolean hasEmployee(int deptNo);
  
  DepartmentDto getDepartById(int deptNo);          // 노드 클릭 후 부서 조회
  EmployeeDto getEmployeeById(int empNo);           // 노드 클릭 후 직원 조회

  void updateDepart(DepartmentDto departmentDto);   // 부서 정보 수정
  void updateEmployee(EmployeeDto employeeDto);     // 직원 정보 수정
  
  List<DepartmentDto> getAllDepart();               // 모든 부서 조회
  
  void addDepartment(HttpServletRequest request, HttpServletResponse response);         // 부서 추가
  List<DepartmentDto> getDeptTitleList();                                               // 부서 등록 시 부서 번호 조회  
  ResponseEntity<Map<String, Object>> getDeptDetailList(HttpServletRequest request);    // 부서 등록 시 부서 번호 조회
  boolean checkDeptNo(int deptNo);      // 부서 등록 시 부서 번호 중복체크
  
  List<Map<String, Object>> getOrgChartData();      // 유저 조직도 조회
  
  
}
