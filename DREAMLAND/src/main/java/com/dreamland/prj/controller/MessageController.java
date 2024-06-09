package com.dreamland.prj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
  
  // 쪽지 보내기
  @PostMapping("/message/send.do")
  public String send(HttpServletRequest request) {
    messageService.insertMessage(request);
    return "redirect:/user/sendMessage";
  }
  
  // 받은 쪽지함 개수
  @GetMapping("/message/receiveCount.do")
  public ResponseEntity<Integer> getReceiveCount(@RequestParam int empNo){
    int receiveCount = messageService.getReceiveCount(empNo);
    return ResponseEntity.ok(receiveCount);
  }
  
  // 받은 쪽지함 리스트
  @GetMapping("/user/receiveBox")
  public String receiveList(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getReceiveMessage(model);
    return "message/receiveBox";
  }
  
  // 보낸 쪽지 개수
  @GetMapping("/message/sendCount.do")
  public ResponseEntity<Integer> getSendCount(@RequestParam int empNo){
    int sendCount = messageService.getSendCount(empNo);
    return ResponseEntity.ok(sendCount);
  }
  
  // 보낸쪽지함 리스트
  @GetMapping("/user/sendBox")
  public String sendList(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getSendMessage(model);
    return "message/sendBox";
  }

  // 받은쪽지함에서 상세보기
  @GetMapping("/user/msgRecDetail")
  public String msgRecDetail(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getMessageDetailByReceive(model);
    return "message/msgRecDetail";
  }

  // 보낸쪽지함에서 상세보기
  @GetMapping("/user/msgSendDetail")
  public String msgSendDetail(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getMessageDetailBySend(model);
    return "message/msgSendDetail";
  }
  
  // 중요보관함 저장하기
  @PostMapping("/user/saveMsg.do")
  public String msgSave(HttpServletRequest request) {
    messageService.saveMessage(request);
    return "redirect:/user/receiveBox";
  }
  
  // 중요보관함 리스트
  @GetMapping("/user/saveBox")
  public String saveList(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getStarMessage(model);
    return "message/saveBox";
  }


}
