package com.dreamland.prj.service;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.DepartMapper;

import jakarta.servlet.http.HttpServletRequest;


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
  
  // 부서명 변경
  @Override
  public void updateDepart(DepartmentDto departmentDto)  {
    departMapper.updateDepart(departmentDto);
  }
  
  // 부서 + 직원 삭제
  @Override
  public void deleteDepart(DepartmentDto departmentDto) {
    departMapper.deleteDepart(departmentDto); 
  }  
  @Override
  public void deleteEmployee(EmployeeDto employeeDto) {
    departMapper.deleteEmployee(employeeDto); 
  }
  
  // 직원 정보 수정
  @Override
  public EmployeeDto getEmployeeById(String email) {
    return departMapper.getEmployeeById(email);
  }
  
  @Override
  public void updateEmployee(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    String empName = request.getParameter("empName");
    Date birth = Date.valueOf(request.getParameter("birth"));
    Date enterDate = Date.valueOf(request.getParameter("enterDate"));
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String role = request.getParameter("role");
    int deptNo = Integer.parseInt(request.getParameter("deptNo"));
    int posNo = Integer.parseInt(request.getParameter("posNo"));
    
    EmployeeDto employeeDto = EmployeeDto.builder()
                                .empNo(empNo)
                                .empName(empName)
                                .email(email)
                                .birth(birth)
                                .enterDate(enterDate)
                                .mobile(mobile)
                                .role(role)
                                .deptNo(deptNo)
                                .posNo(posNo)
                              .build();
    departMapper.updateEmployee(employeeDto);    
  }
  

}
