package com.dreamland.prj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.EmployeeServiceImpl;
import com.dreamland.prj.service.LoginServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
  
  @Autowired
  private LoginServiceImpl loginService;
  
  // 로그인 실패 출력
  @GetMapping("/auth/login")
  public String login(@RequestParam(value="error", required=false) String error
                    , @RequestParam(value="exception", required=false) String exception
                    , Model model) {
    model.addAttribute("error", error);
    model.addAttribute("exception", exception);
    return "login/loginPage";
  }
  
  // 마이페이지 수정
  @PostMapping("/user/modify.do")
  public String modifyUserInfo(@RequestParam("profilePath") MultipartFile profilePath
                             , @RequestParam("signPath") MultipartFile signPath,
                             HttpServletRequest request, HttpServletResponse response) {
    loginService.modifyUserInfo(profilePath, signPath, request, response);
    EmployeeDto employee = loginService.getEmployeeByEmail(request.getParameter("email"));
    
    return "redirect:/user/mypage";
  }
  


    
}