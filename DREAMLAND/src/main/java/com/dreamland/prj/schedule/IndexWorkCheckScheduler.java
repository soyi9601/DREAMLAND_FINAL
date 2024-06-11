package com.dreamland.prj.schedule;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dreamland.prj.service.IndexService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@EnableScheduling
@Slf4j
public class IndexWorkCheckScheduler {

  private final IndexService indexService;
  
  // 평일 오후 6시 1분에 checkLate 서비스 동작
  @Scheduled(cron="59 59 9 * * MON-FRI")
  public void checkedkWorkOut() {
    log.info("========= 퇴근체크 =========");
    indexService.updateCheckedWorkOut();
  }
  
  
}


