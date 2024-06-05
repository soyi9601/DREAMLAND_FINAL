package com.dreamland.prj.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.JsTreetDto;
import com.dreamland.prj.dto.OrgChartDto;
import com.dreamland.prj.mapper.DepartMapper;

import io.jsonwebtoken.lang.Arrays;
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
  public List<JsTreetDto> getDepartList() {
    List<JsTreetDto> allDepart = departMapper.getDepartList();
    
    List<JsTreetDto> notNullDepart = new ArrayList<>();
    for(JsTreetDto depart : allDepart) {
      if(depart.getEmployee() != null && !depart.getEmployee().isEmpty()) {
        notNullDepart.add(depart);
      }
    }
    
    return notNullDepart;
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
    List<OrgChartDto> allDepart = departMapper.getDepartListUser();
    System.out.println("allDepart=>"+allDepart.size());
    for(Object o : allDepart)
         System.out.println(o);
    
    // deptData 에 부서 데이터 추가
    Map<Integer, Map<String, Object>> departMap = new HashMap<>();
    
    for(OrgChartDto depart : allDepart) {
      Map<String, Object> deptData = new HashMap<>();
      deptData.put("id", depart.getDeptNo());
      deptData.put("name", depart.getDeptName());
      Integer pid = depart.getParentId() == null || depart.getParentId().isEmpty() || "#".equals(depart.getParentId()) ? null : Integer.parseInt(depart.getParentId());
      deptData.put("pid", pid);
      departMap.put(depart.getDeptNo(), deptData);
    }
    
    // employeeList 에 직원 데이터 추가
    List<Map<String, Object>> employeeList = new ArrayList<>();
    
    for(OrgChartDto depart : allDepart) {
      if(depart.getEmpNo() != 0) {
//      if(depart.getEmployee() !=null) {
        Map<String, Object> employeeData = new HashMap<>();
        employeeData.put("id", depart.getEmpNo());
        employeeData.put("name", depart.getEmpName());
        employeeData.put("email", depart.getEmail());
        employeeData.put("pid", depart.getDeptNo());
        employeeData.put("tags", Arrays.asList(new String[]{"employees"})); // 직원 데이터에 tags 추가
//        employeeData.put("id", depart.getEmployee().getEmpNo());
//        employeeData.put("name", depart.getEmployee().getEmpName());
//        employeeData.put("email", depart.getEmployee().getEmail());
//        employeeData.put("pid", depart.getDeptNo());

        employeeList.add(employeeData);        
      }
    }
    
    // 부서 데이터를 id 기준으로 정렬
    List<Map<String, Object>> deptList = new ArrayList<>(departMap.values());
    deptList.sort(Comparator.comparingInt(dept -> (Integer) dept.get("id")));
    /*
    System.out.println("deptList=>"+deptList.size());
    for(Object o : deptList)
         System.out.println(o);
    
    System.out.println("employeeList=>"+employeeList.size());
    for(Object o : employeeList)
         System.out.println(o);
    */
    // 직원 데이터를 id 기준으로 정렬
    employeeList.sort(Comparator.comparingInt(emp -> (Integer) emp.get("id")));
    
    List<Map<String, Object>> orgChartData = new ArrayList<>();
        
    /*
    for(Map<String, Object> deptData : departMap.values()) {
      orgChartData.add(deptData);
    }
    */
    
    orgChartData.addAll(deptList);      // orgChartData에 deptData 추가
    orgChartData.addAll(employeeList);  // orgChartData에 employeeList 추가
        
    return orgChartData;
  }

}
