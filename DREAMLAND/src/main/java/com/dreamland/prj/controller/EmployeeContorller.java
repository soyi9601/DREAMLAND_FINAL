package com.dreamland.prj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.EmployeeServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class EmployeeContorller {
  
  @Autowired
  private EmployeeServiceImpl employeeService;

  @GetMapping("/user")
  public @ResponseBody String user() {

    return "유저 페이지입니다.";
  }

  @GetMapping("/admin")
  public @ResponseBody String admin() {
    return "어드민 페이지입니다.";
  }
  
  @GetMapping("/auth/login")
  public String login(@RequestParam(value="error", required=false) String error
                    , @RequestParam(value="exception", required=false) String exception
                    , Model model) {
    model.addAttribute("error", error);
    model.addAttribute("exception", exception);
    return "login/loginPage";
  }
  
  @PostMapping("/employee/add.do")
  public String addEmployee(@RequestParam("profilePath") MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response) {
    employeeService.addEmployee(profilePath, request, response);
    return "redirect:/employee/add";
  }
  
  @PostMapping("/user/modify.do")
  public String modifyUserInfo(@RequestParam("profilePath") MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response) {
    employeeService.modifyUserInfo(profilePath, request, response);
    return "redirect:/user/mypage";
  }

    
}