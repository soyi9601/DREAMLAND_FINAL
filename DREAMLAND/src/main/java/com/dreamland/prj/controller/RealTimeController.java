package com.dreamland.prj.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

@Component
@Controller
public class RealTimeController {

  private final SimpMessagingTemplate simpMessagingTemplate;

  public RealTimeController(SimpMessagingTemplate simpMessagingTemplate) {
    super();
    this.simpMessagingTemplate = simpMessagingTemplate;
  }
  
  @MessageMapping("/post")
  public void sendNotice(String message) {
    simpMessagingTemplate.convertAndSend("/topic/feed", message);
  }
}
