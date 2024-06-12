package com.dreamland.prj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
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
  
  // 자동완성 위한 직원 리스트 가져오기
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
    String referer = request.getHeader("referer");
    if(referer != null) {
      return "redirect:"+referer;
    }else {
      return "redirect:/user/sendMessage";
    }
  }
  
  // 받은 쪽지함 개수
  @GetMapping("/message/receiveCount.do")
  public ResponseEntity<Map<String, Object>> getReceiveCount(@RequestParam int empNo){
    Map<String, Object> total = messageService.getReceiveCount(empNo);
    return ResponseEntity.ok(total);
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
  
  // 받은쪽지함 중요보관함 저장하기
  @PostMapping("/user/saveRecMsg.do")
  public String msgRecSave(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    messageService.saveRecMessage(request);
    String referer = request.getHeader("referer");
    if(referer.contains("empNo")) {
      return "redirect:"+referer;
    }else {
      return "redirect:/user/receiveBox?empNo=" + empNo;
    }
  }
  
  // 보낸쪽지함 중요보관함 저장하기
  @PostMapping("/user/saveSendMsg.do")
  public String msgSendSave(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    messageService.saveSendMessage(request);
    String referer = request.getHeader("referer");
    messageService.saveRecMessage(request);
    if(referer.contains("empNo")) {
      return "redirect:"+referer;
    }else {
      return "redirect:/user/sendBox?empNo=" + empNo;
    }
  }
  
  // 중요보관함 리스트
  @GetMapping("/user/saveBox")
  public String saveList(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getStarMessage(model);
    return "message/saveBox";
  }
  
  // 중요 쪽지 개수
  @GetMapping("/message/starCount.do")
  public ResponseEntity<Map<String, Object>> getStarCount(@RequestParam int empNo){
    Map<String, Object> total = messageService.getStarCount(empNo);
    return ResponseEntity.ok(total);
  }
  
  // 받은쪽지함에서 휴지통 이동하기
  @PostMapping("/user/deleteRecMsg.do")
  public String recMsgRemove(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    messageService.deleteRecMessage(request);
    return "redirect:/user/receiveBox?empNo=" + empNo;
  }
  
  // 보낸쪽지함에서 휴지통 이동하기
  @PostMapping("/user/deleteSendMsg.do")
  public String sendMsgRemove(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    messageService.deleteSendMessage(request);
    return "redirect:/user/sendBox?empNo=" + empNo;
  }
  
  // 중요쪽지함에서 휴지통 이동하기
  @PostMapping("/user/deleteSaveMsg.do")
  public String saveMsgRemove(HttpServletRequest request) {
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    messageService.deleteRecMessage(request);
    return "redirect:/user/saveBox?empNo=" + empNo;
  }
  
  // 삭제 리스트
  @GetMapping("/user/removeBox")
  public String deleteList(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.getDeleteMessage(model);
    return "message/removeBox";
  }
  
  // 삭제 쪽지 개수
  @GetMapping("/message/deleteCount.do")
  public ResponseEntity<Map<String, Object>> getRemoveCount(@RequestParam int empNo){
    Map<String, Object> total = messageService.getDeleteCount(empNo);
    return ResponseEntity.ok(total);
  }
  
  // 답장 보내기 페이지
  @GetMapping("/user/replyMessage")
  public String replyMessage(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    messageService.setReply(model);
    return "message/replyMessage";
  }
  
}
