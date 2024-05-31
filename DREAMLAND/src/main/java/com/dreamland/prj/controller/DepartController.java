package com.dreamland.prj.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.DepartService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;


@RequestMapping("/depart")
@RequiredArgsConstructor
@Controller
public class DepartController {

  private final DepartService departService;
  
  // 관리자 - 조직도 페이지 이동
  @GetMapping("/departAdmin.page")
  public String depart() {
    return "depart/departAdmin";
  }
  
  // 관리자 - 조직도 조회
  @GetMapping(value="/departAdmin.do", produces="application/json")
  public ResponseEntity<List<DepartmentDto>> departAdmin() {
    List<DepartmentDto> departmentDto = departService.getDepartList();
    if (departmentDto != null && !departmentDto.isEmpty()) {
        return new ResponseEntity<>(departmentDto, HttpStatus.OK);
    } else {
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
  }
    
  // 부서 및 직원 삭제
  @PostMapping("/removeDepart")
  public ResponseEntity<?> deleteDepart(@RequestBody DepartmentDto departmentDto) {
    int deptNo = departmentDto.getDeptNo();
    if (departService.hasEmployee(deptNo)) {
      return ResponseEntity.ok().body("{\"message\": \"부서에 직원이 있습니다. 다시 확인 부탁드립니다.\"}");
    }
    departService.removeDepart(departmentDto);
    return ResponseEntity.ok().body("{\"message\": \"부서가 삭제되었습니다.\"}");
  }  
  @PostMapping("/removeEmployee")
  public ResponseEntity<?> deleteEmployee(@RequestBody EmployeeDto employeeDto) {
    departService.removeEmployee(employeeDto);
    return ResponseEntity.ok().body("{\"message\": \"직원이 삭제되었습니다.\"}");
  }
  
  // 노드 클릭 후 부서 및 직원 조회
  @GetMapping("/getDepartInfo")
  public ResponseEntity<DepartmentDto> getDepartInfo(@RequestParam("deptNo") int deptNo) {
    DepartmentDto department = departService.getDepartById(deptNo);
    return ResponseEntity.ok().body(department);
  }  
  @GetMapping("/getEmployeeInfo")
  public ResponseEntity<EmployeeDto> getEmployeeInfo(@RequestParam("empNo") int empNo) {
    EmployeeDto employee = departService.getEmployeeById(empNo);
    return ResponseEntity.ok().body(employee);
  }  

  // 부서 및 직원 정보 수정
  @PostMapping(value="/editDepart.do", produces="application/json")
  public ResponseEntity<?> updateDepart(@RequestBody DepartmentDto departmentDto) {
    departService.updateDepart(departmentDto);
    return ResponseEntity.ok().body("{\"message\": \"부서정보가 수정되었습니다.\"}");
  }      
  @PostMapping(value="/editEmployee.do", produces="application/json")
  public ResponseEntity<?> updateEmployee(@RequestBody EmployeeDto employeeDto) {
    departService.updateEmployee(employeeDto);
    return ResponseEntity.ok().body("{\"message\": \"직원정보가 수정되었습니다.\"}");
  }   
    
  // 부서 등록 페이지 이동
  @GetMapping("/addDepart.page")
  public String addDepart() {
    return "depart/addDepart";
  }
  
  // 부서 등록
  @PostMapping("/addDepart.do")
  public String registerDepart(HttpServletRequest request, HttpServletResponse response) {
    departService.addDepartment(request, response);
    return "depart/addDepart";
  }
  
  
  // 유저 - 조직도 페이지 이동
  @GetMapping("/depart.page")
  public String departUser(Model model) {
    return "depart/departUser";
  }
  
  
}
