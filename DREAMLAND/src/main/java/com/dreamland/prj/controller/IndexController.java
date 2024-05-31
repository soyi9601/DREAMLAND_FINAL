package com.dreamland.prj.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.IndexService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IndexController {

  private final IndexService indexService;
  
  @GetMapping("/")
  public String index(Model model, Authentication authentication) {
    String email = authentication.getName();
    EmployeeDto emp = indexService.loadUser(email);
    model.addAttribute("emp", emp);
    return "index";
  }
  
}
