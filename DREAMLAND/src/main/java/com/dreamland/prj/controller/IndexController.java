package com.dreamland.prj.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.IndexService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IndexController {

  private final IndexService indexService;
  
  // 직원 조회
  @GetMapping("/")
  public String index(Model model, Authentication authentication) {
    String email = authentication.getName();
    EmployeeDto emp = indexService.loadUser(email);
    model.addAttribute("emp", emp);
    return "index";
  }
  
  
  // 근태관리
  @PostMapping(value="/workIn", produces="application/json")
  public ResponseEntity<Map<String, Object>> workIn(@RequestParam int empNo) {
    indexService.workIn(empNo);
    Map<String, Object> response = new HashMap<>();
    response.put("message", "출근 완료했습니다");
    return ResponseEntity.ok(response);
  }  
  
  @PostMapping(value="/workOut", produces="application/json")
  public ResponseEntity<Map<String, Object>> workOut(@RequestParam int empNo) {
    indexService.workOut(empNo);
    Map<String, Object> response = new HashMap<>();
    response.put("message", "퇴근 완료했습니다");
    return ResponseEntity.ok(response);
  }
  
}
