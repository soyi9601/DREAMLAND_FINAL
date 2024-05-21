package com.dreamland.prj.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.service.DepartService;

import jakarta.servlet.http.HttpServletRequest;
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
  public ResponseEntity<List<DepartmentDto>> departAdmin(HttpServletRequest request) {
    List<DepartmentDto> departmentDto = departService.getDepartList();
    return new ResponseEntity<>(departmentDto, HttpStatus.OK);
  }
  
  
}
