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

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IndexController {

  private final IndexService indexService;
  
  // 직원 조회
  @GetMapping("/")
  public String index(Model model, Authentication authentication) {
    String email = authentication.getName();          // 로그인 한 직원의 정보 가져오기
    EmployeeDto emp = indexService.loadUser(email);   // 이메일을 이용하여 직원 정보 조회
    boolean hasCheckedWorkIn = indexService.hasCheckedWorkIn(emp.getEmpNo());     // 해당 직원의 출근 기록 확인
    boolean hasCheckedWorkOut = indexService.hasCheckedWorkOut(emp.getEmpNo());   // 해당 직원의 퇴근 기록 확인
    
    model.addAttribute("emp", emp);
    model.addAttribute("hasCheckedWorkIn", hasCheckedWorkIn);
    model.addAttribute("hasCheckedWorkOut", hasCheckedWorkOut);
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
  
  
  // 공지사항
  @GetMapping(value="/notice", produces="application/json")
  public ResponseEntity<Map<String, Object>> getNoticeList(HttpServletRequest request) {
    return indexService.getNoticeList(request);
  }
  
  
  // 쪽지카운트
  @GetMapping(value="/receiveCount", produces="application/json")
  public ResponseEntity<Integer> getReceiveCount(@RequestParam int empNo){
    int receiveCount = indexService.getReceiveCount(empNo);
    return ResponseEntity.ok(receiveCount);
  }
  
  
  // 전자결재 대기문서(내가 결재해야 할 것)
  @GetMapping(value="/waitCount", produces="application/json")
  public ResponseEntity<Integer> getWaitCount(@RequestParam int empNo) {
    int waitCount = indexService.getWaitCount(empNo);
    return ResponseEntity.ok(waitCount);
  }
  
  // 전자결재 진행문서(내가 결재 올린 것)
  @GetMapping(value="/waitMyApvCount", produces="application/json")
  public ResponseEntity<Integer> getMyApvCount(@RequestParam int empNo) {
    int myApvCount = indexService.getMyApvCount(empNo);
    return ResponseEntity.ok(myApvCount);
  }
  
  
  // 일정 조회
  /*
  @GetMapping(value="/calendar", produces="application/json")
  public List<ScheduleDto> getCalendarList(HttpServletRequest request, Authentication authentication) {
    String email = authentication.getName();
    EmployeeDto emp = indexService.loadUser(email);
    System.out.println("emp 정보:" + emp);
    return indexService.loadSkdList(emp);
  }
  */
  
  
}
