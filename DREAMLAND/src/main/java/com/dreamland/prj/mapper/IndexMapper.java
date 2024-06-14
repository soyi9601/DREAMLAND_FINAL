package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.NoticeBoardDto;
import com.dreamland.prj.dto.WorkDto;

@Mapper
public interface IndexMapper {

  EmployeeDto getUser(String email);    // 직원조회
  
  void insertWork(WorkDto work);                  // 출근
  int updateWorkOut(Map<String, Object> map);     // 퇴근
  
  int hasCheckedWorkIn(int empNo);                // 출근 시간 체크
  int hasCheckedWorkOut(int empNo);               // 퇴근 시간 체크
  void updateCheckedWorkOut();                    // 퇴근 스케쥴러
  
  List<NoticeBoardDto> getNoticeList(Map<String, Object> map);    // 공지사항 리스트
  
  int getMessageCountByReceiver(int empNo);    // 안읽은 쪽지 건수 확인
  
  int getWaitCount(int empNo);        // 승인 해야 할 대기 전자문서
  int getMyApvCount(int empNo);       // 진행중인 나의 전자문서
  
}
