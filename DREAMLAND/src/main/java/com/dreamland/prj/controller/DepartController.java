package com.dreamland.prj.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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
  
  @GetMapping(value="/depart_admin.do", produces="application/json")
  public ResponseEntity<List<DepartmentDto>> departAdmin() {
    List<DepartmentDto> departmentDto = departService.getDepartList();
    if (departmentDto != null && !departmentDto.isEmpty()) {
        return new ResponseEntity<>(departmentDto, HttpStatus.OK);
    } else {
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
  }
  
  @PostMapping("/updateNode")
  public ResponseEntity<?> updateDepart(@RequestBody DepartmentDto departmentDto) {
    departService.updateDepart(departmentDto);
    return ResponseEntity.ok().build();
  }
  
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
  
  @GetMapping("/editEmployee")
  public String editEmployee(@RequestParam("empNo") int empNo, Model model, Authentication authentication) {
    String email = authentication.getName();
    
    EmployeeDto emp = departService.getEmployeeById(email);
    model.addAttribute("emp", emp);
    return "employee/editEmployee";
  }
  
  @PostMapping("/updateEmployee.do")
  public String updateEmployee(HttpServletRequest request) {
    departService.updateEmployee(request);
    return "redirect:/depart/depart_admin";
  }
  
  
  
}
