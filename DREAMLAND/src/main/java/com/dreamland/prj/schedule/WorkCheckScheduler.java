package com.dreamland.prj.schedule;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dreamland.prj.service.WorkService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@EnableScheduling
@Slf4j
public class WorkCheckScheduler {

  private final WorkService workService;
  
  // 평일 오전 9시 1분에 checkLate 서비스 동작
  //@Scheduled(cron = "0 * * * * ?")
  //@Scheduled(cron="0 1 9 ? * MON-FRI *")
  public void checkLate() {
    log.info("========= 지각체크 =========");
    try {
      workService.checkLate();
      log.info("지각체크 성공");
    } catch (Exception e) {
      log.error("지각체크 실패", e);
    }
  }
  
  //평일 오전 9시 1분에 checkdayoffStatus 서비스 동작
  //@Scheduled(cron = "0 * * * * ?")
  //@Scheduled(cron="0 1 9 ? * MON-FRI *")
  public void checkDayoff() {
    log.info("========= 연차 체크 =========");
    try {
      workService.checkDayoff();
      log.info("연차 체크 성공");
    } catch (Exception e) {
      log.error("연차 체크 실패", e);
    }
  }
  
  //평일 오후 6시 1분에 checkHafDayoff 서비스 동작
  //@Scheduled(cron = "0 * * * * ?")
  //@Scheduled(cron="0 1 18  ? * MON-FRI *")
  public void checkHafDayoff() {
    log.info("========= 반차 체크 =========");
    try {
      workService.checkHafDayoff();
      log.info("반차 체크 성공");
    } catch (Exception e) {
      log.error("반차 체크 실패", e);
    }
  }
  
  // 평일 오후 6시 1분에 checkAbsence 서비스 동작 
  //@Scheduled(cron = "0 * * * * ?")
  //@Scheduled(cron = "0 1 18 ? * MON-FRI")
  public void checkAbsence() {
    log.info("========= 결근체크 =========");
    try {
      workService.checkAbsence();
      log.info("결근체크 성공");
    } catch (Exception e) {
      log.error("결근체크 실패", e);
    }
  }
  
}


