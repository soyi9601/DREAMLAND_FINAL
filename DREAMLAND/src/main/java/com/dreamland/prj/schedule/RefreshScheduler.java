package com.dreamland.prj.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dreamland.prj.mapper.RefreshMapper;

@Component
public class RefreshScheduler {
  
  @Autowired
  private RefreshMapper refreshMapper;
  
  @Scheduled(cron = "0 0 * * * *")
  public void deleteRefreshTokensBetweenDates() {
    
    refreshMapper.removeRefreshByDate();
    
  }

}
