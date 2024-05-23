package com.dreamland.prj.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.DepartService;

import lombok.RequiredArgsConstructor;


@RequestMapping("/depart")
@RequiredArgsConstructor
@Controller
public class DepartController {

  private final DepartService departService;
  
  @GetMapping("depart_admin.page")
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
  
}
