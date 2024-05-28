package com.dreamland.prj.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.DepartMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@Service
public class DepartServiceImpl implements DepartService {

  private final DepartMapper departMapper;
  
  public DepartServiceImpl(DepartMapper departMapper) {
    super();
    this.departMapper = departMapper;
  }
  
  
  // 부서 + 직원 전체 리스트 조회
  @Override
  public List<DepartmentDto> getDepartList() {
    return departMapper.getDepartList();
  }  
  
  // 부서 및 직원 삭제
  @Override
  public void removeDepart(DepartmentDto departmentDto) {
    departMapper.deleteDepart(departmentDto); 
  }  
  @Override
  public void removeEmployee(EmployeeDto employeeDto) {
    departMapper.deleteEmployee(employeeDto); 
  }  
  
  // 부서 및 직원 정보 조회
  @Override
  public DepartmentDto getDepartById(int deptNo) {
    return departMapper.getDepartById(deptNo);
  }
  @Override
  public EmployeeDto getEmployeeById(int empNo) {
    return departMapper.getEmployeeById(empNo);
  }  
  
  // 부서 및 직원 정보 수정
  @Override
  public void updateDepart(DepartmentDto departmentDto)  {
    departMapper.updateDepart(departmentDto);
  }
  @Override
  public void updateEmployee(EmployeeDto employeeDto) {
    departMapper.updateEmployee(employeeDto);
  }
  
  // 부서 추가
  @Override
  public void addDepartment(HttpServletRequest request, HttpServletResponse response) {
    String deptName = request.getParameter("deptName");
    int deptNo = Integer.parseInt(request.getParameter("deptNo"));
    String parentId = request.getParameter("parentId");
    
    DepartmentDto depart = DepartmentDto.builder()
                              .deptName(deptName)
                              .deptNo(deptNo)
                              .parentId(parentId)
                            .build();
    departMapper.insertDepart(depart);
    
  }
  

}
