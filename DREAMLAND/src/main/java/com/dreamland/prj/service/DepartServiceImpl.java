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
      deptData.put("id", depart.getDeptNo());
      deptData.put("name", depart.getDeptName());
      
      // 대표이사인 경우 parentId를 null로 설정하여 최상위 부서로 간주합니다.
      String parentId = (depart.getParentId() == null || depart.getParentId().isEmpty()) ? null : depart.getParentId();
      deptData.put("parentId", parentId);
      
      deptData.put("depth", depart.getDepth());
      deptData.put("treeText", depart.getTreeText());
      if (depart.getEmployee() != null) {
          deptData.put("employeeId", depart.getEmployee().getEmpNo());
          deptData.put("employeeName", depart.getEmployee().getEmpName());
          deptData.put("employeeEmail", depart.getEmployee().getEmail());
      }
      departMap.put(depart.getDeptNo(), deptData);
  }
    
    List<Map<String, Object>> topDepart = new ArrayList<>();
    
    for(Map<String, Object> deptData : departMap.values()) {
      String parentId = (String) deptData.get("parentId");
      if(parentId == null || parentId.isEmpty() || parentId.equals("#")) {
        topDepart.add(deptData);
      } else {
        int parentDeptNo = Integer.parseInt(parentId);
        Map<String, Object> parentDept = departMap.get(parentDeptNo);
        if(parentDept != null) {
          List<Map<String, Object>> children = (List<Map<String, Object>>) parentDept.getOrDefault("children", new ArrayList<>());
          children.add(deptData);
          parentDept.put("children", children);
        }
      }
    }
    
    return topDepart;
  }

}
