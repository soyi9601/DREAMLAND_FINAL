package com.dreamland.prj.schedule;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dreamland.prj.service.WorkService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class WorkCheckScheduler {

  private final WorkService workService;
  
  // 평일 오전 9시 1분에 checkLate 서비스 동작
  @Scheduled(cron="0 1 9 ? * MON-FRI *")
  public void execute() {
    workService.checkLate();
  }
  
  // 평일 오후 6시 1분에 checkAbsence 서비스 동작 
  @Scheduled(cron = "0 1 18 ? * MON-FRI") 
  public void checkAbsenteeism() {
      workService.checkAbsence();
  }
  
  
}
