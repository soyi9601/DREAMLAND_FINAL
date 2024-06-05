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
  void updateWorkOut(WorkDto work);     // 퇴근
  
  List<NoticeBoardDto> getNoticeList(Map<String, Object> map);
}
