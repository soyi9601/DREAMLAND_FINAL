package com.dreamland.prj.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
  @Override
  public boolean hasEmployee(int deptNo) {
    return departMapper.hasEmployee(deptNo) > 0;
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
  
  // 유저 - 조직도
  @Override
  public List<Map<String, Object>> getOrgChartData() {
    // 전체 부서와 사원 조회
    List<DepartmentDto> allDepart = departMapper.getDepartList();
    
    Map<Integer, Map<String, Object>> departMap = new HashMap<>();
    
    for (DepartmentDto depart : allDepart) {
      Map<String, Object> deptData = new HashMap<>();
      deptData.put("id", Integer.toString(depart.getDeptNo()));
      deptData.put("name", depart.getDeptName());
      
      // 대표이사인 경우 parentId를 null로 설정하여 최상위 부서로 간주합니다.
      String pid = (depart.getParentId() == null || depart.getParentId().isEmpty() || "#".equals(depart.getParentId())) ? null : depart.getParentId();
      deptData.put("pid", pid);
      deptData.put("children", new ArrayList<Map<String, Object>>());
      deptData.put("employees", new ArrayList<Map<String, Object>>());
      
      departMap.put(depart.getDeptNo(), deptData);
    }
    
    for(DepartmentDto depart : allDepart) {
      if(depart.getEmployee() != null) {
        Map<String, Object> employeeData = new HashMap<>();
        employeeData.put("pid", Integer.toString(depart.getDeptNo()));
        employeeData.put("id", depart.getEmployee().getEmpNo());
        employeeData.put("name", depart.getEmployee().getEmpName() + depart.getEmployee().getPosName());
        employeeData.put("email", depart.getEmployee().getEmail());
        
        Map<String, Object> deptData = departMap.get(depart.getDeptNo());
        List<Map<String, Object>> employees = (List<Map<String, Object>>) deptData.get("employees");
        employees.add(employeeData);
      }
    }
    
    List<Map<String, Object>> topDepart = new ArrayList<>();
    
    for(Map<String, Object> deptData : departMap.values()) {
      String pid = (String) deptData.get("pid");
      if(pid == null) {
        topDepart.add(deptData);
      } else {
        Integer parentDeptNo = Integer.parseInt(pid);
        Map<String, Object> parentDept = departMap.get(parentDeptNo);
        if(parentDept != null) {
          List<Map<String, Object>> children = (List<Map<String, Object>>) parentDept.getOrDefault("children", new ArrayList<>());
          children.add(deptData);
        }
      }
    }
    
    return topDepart;
  }

}
