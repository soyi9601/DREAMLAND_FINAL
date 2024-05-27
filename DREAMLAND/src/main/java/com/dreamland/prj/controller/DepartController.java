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
  
  @GetMapping("/depart_admin.page")
  public String depart() {
    return "depart/depart_admin";
  }
  
  @GetMapping("/addDepart.page")
  public String addDepart() {
    return "depart/addDepart";
  }
  
  @GetMapping(value="/depart_admin.do", produces="application/json")
  public ResponseEntity<List<DepartmentDto>> departAdmin() {
    List<DepartmentDto> departmentDto = departService.getDepartList();
    if (departmentDto != null && !departmentDto.isEmpty()) {
        return new ResponseEntity<>(departmentDto, HttpStatus.OK);
    } else {
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
  }
  
  // 부서명 수정
  @PostMapping("/updateNode")
  public ResponseEntity<?> updateDepart(@RequestBody DepartmentDto departmentDto) {
    departService.updateDepart(departmentDto);
    return ResponseEntity.ok().build();
  }
  
  // 부서 및 직원 삭제
  @PostMapping("/deleteDepart")
  public ResponseEntity<?> deleteDepart(@RequestBody DepartmentDto departmentDto) {
    departService.deleteDepart(departmentDto);
    return ResponseEntity.ok().body("{\"message\": \"부서가 삭제되었습니다.\"}");
  }
  
  @PostMapping("/deleteEmployee")
  public ResponseEntity<?> deleteEmployee(@RequestBody EmployeeDto employeeDto) {
    departService.deleteEmployee(employeeDto);
    return ResponseEntity.ok().body("{\"message\": \"직원이 삭제되었습니다.\"}");
  }
  
  // 직원 정보 수정 페이지 이동
  @GetMapping("/editEmployee")
  public String editEmployee(@RequestParam("empNo") int empNo, Model model) {
    EmployeeDto emp = departService.getEmployeeById(empNo);
    model.addAttribute("emp", emp);
    return "employee/editEmployee";
  }
  
  // 직원 정보 수정
  @PostMapping("/updateEmployee.do")
  public String updateEmployee(HttpServletRequest request) {
    departService.updateEmployee(request);
    return "employee/editEmployee";
  }
  
  // 부서 등록
  @PostMapping("/addDepart.do")
  public String registerDepart(HttpServletRequest request, HttpServletResponse response) {
    departService.addDepartment(request, response);
    return "depart/addDepart";
  }
  
}
