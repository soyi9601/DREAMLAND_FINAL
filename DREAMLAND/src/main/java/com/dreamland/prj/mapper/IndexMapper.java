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
  
  void insertWork(WorkDto work);        // 출근
  int updateWorkOut(Map<String, Object> map);     // 퇴근
  
  List<NoticeBoardDto> getNoticeList(Map<String, Object> map);
  
  int getMessageCountByReceiver(int empNo);
  
  int getWaitCount(int empNo);
  int getMyApvCount(int empNo);
  
  int hasCheckedWorkIn(int empNo);
  void updateCheckedWorkOut();
}
