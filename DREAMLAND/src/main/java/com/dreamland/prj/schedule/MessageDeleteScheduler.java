package com.dreamland.prj.schedule;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.mapper.MessageMapper;

@Component
public class MessageDeleteScheduler {
  
  @Autowired
  private MessageMapper messageMapper;
  
  @Transactional
  @Scheduled(cron = "0 0 0 * * ?")
  public void cleanupOldMessages() {
    LocalDateTime cutoffDate = LocalDateTime.now().minusDays(30);
    messageMapper.deleteOldMessages();
    
  }

}
