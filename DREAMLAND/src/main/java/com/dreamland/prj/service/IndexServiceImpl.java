package com.dreamland.prj.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.NoticeBoardDto;
import com.dreamland.prj.dto.WorkDto;
import com.dreamland.prj.mapper.IndexMapper;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class IndexServiceImpl implements IndexService {

  private final IndexMapper indexMapper;
  
  
  //부서 + 직원 전체 리스트 조회
  @Override
  public EmployeeDto loadUser(String email) {
    return indexMapper.getUser(email);
  }
  
  
  // 근태관리
  @Override
  public void workIn(int empNo) {
    WorkDto work = WorkDto.builder()
                       .empNo(empNo)
                     .build();
    indexMapper.insertWork(work);
  }  
  
  @Override
  public Map<String, Object> workOut(int empNo) {
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    
    Map<String, Object> map = new HashMap<>();
    map.put("today", today);
    map.put("empNo", empNo);
    indexMapper.updateWorkOut(map);
    return map;    
  }
  
  @Override
  public boolean hasCheckedWorkIn(int empNo) {
    return indexMapper.hasCheckedWorkIn(empNo) > 0;
  }
  
  @Override
  public void updateCheckedWorkOut() {
    indexMapper.updateCheckedWorkOut();    
  }
  
  
  // 공지사항 조회
  @Override
  public ResponseEntity<Map<String, Object>> getNoticeList(HttpServletRequest request) {
    Map<String, Object> map = new HashMap<>();
    List<NoticeBoardDto> noticeList = indexMapper.getNoticeList(map);
    map.put("noticeList", noticeList);
    return new ResponseEntity<>(map, HttpStatus.OK);
  }
  
  
  // 쪽지 건수 확인
  @Override
  public int getReceiveCount(int empNo) {
    return indexMapper.getMessageCountByReceiver(empNo);
  }
  
  
  // 결재 대기문서
  @Override
  public int getWaitCount(int empNo) {
    return indexMapper.getWaitCount(empNo);
  }
  
  // 결재 진행문서
  @Override
  public int getMyApvCount(int empNo) {
    return indexMapper.getMyApvCount(empNo);
  }

}
