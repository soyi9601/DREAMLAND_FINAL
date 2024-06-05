package com.dreamland.prj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.service.MessageService;
import com.dreamland.prj.service.MessageServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MessageController {
  
  @Autowired
  private MessageService messageService;
  
  @GetMapping("/user/employeeList")
  public @ResponseBody Map<String, Object> getEmployeeList(@RequestParam Map<String, Object> param) {
    List<EmployeeDto> resultList = messageService.getEmployeeList(param);
    param.put("resultList", resultList);
    return param;
  }
  
  @PostMapping("/message/send.do")
  public String send(HttpServletRequest request) {
    messageService.insertMessage(request);
    return "redirect:/user/sendMessage";
  }
  
  @GetMapping("/message/receiveCount.do")
  public ResponseEntity<Integer> getReceiveCount(@RequestParam int empNo){
    int receiveCount = messageService.getReceiveCount(empNo);
    return ResponseEntity.ok(receiveCount);
  }
  
  @GetMapping(value="/message/getReceiveMessage.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> getReceiveMessage(@RequestParam int empNo, HttpServletRequest request){
    return messageService.getReceiveMessage(request);
  }
  
  
  @GetMapping("/message/sendCount.do")
  public ResponseEntity<Integer> getSendCount(@RequestParam int empNo){
    int sendCount = messageService.getSendCount(empNo);
    return ResponseEntity.ok(sendCount);
  }
  
  @GetMapping(value="/message/getSendMessage.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> getSendMessage(@RequestParam int empNo, HttpServletRequest request){
    return messageService.getSendMessage(request);
  }


}
