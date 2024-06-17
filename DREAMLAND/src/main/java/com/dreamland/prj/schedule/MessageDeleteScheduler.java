package com.dreamland.prj.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.mapper.MessageMapper;
import com.dreamland.prj.service.MessageService;
/******************************************
 * 
 * - 쪽지삭제 스케줄러
 *   ㄴ 매일 0시 0분 0초에 실행됨
 * 작성자 : 고은정
 * 
 * ****************************************/
@Component
public class MessageDeleteScheduler {
  
  @Autowired
  private MessageService messageService;
  
  @Scheduled(cron = "0 0 0 * * ?")
  public void cleanupOldMessages() {
    messageService.realDeleteMessage();
    
  }

}
