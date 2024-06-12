package com.dreamland.prj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.service.EmployeeServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class EmployeeContorller {
  
  @Autowired
  private EmployeeServiceImpl employeeService;
  
  @GetMapping("/employee/add")
  public String add(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    employeeService.getDeptAndPos(model);
    return "employee/addEmployee";
    
  }
  
  // 직원 등록
  @PostMapping("/employee/add.do")
  public String addEmployee(@RequestParam("profilePath") MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response) {
    employeeService.addEmployee(profilePath, request, response);
    return "redirect:/employee/add";
  }
  

    
}