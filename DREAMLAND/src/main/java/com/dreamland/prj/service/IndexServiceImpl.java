package com.dreamland.prj.service;

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


@Service
public class IndexServiceImpl implements IndexService {

  private final IndexMapper indexMapper;
  
  public IndexServiceImpl(IndexMapper indexMapper) {
    super();
    this.indexMapper = indexMapper;
  }

  
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
  public void workOut(int empNo) {
    WorkDto work = WorkDto.builder()
                       .empNo(empNo)
                     .build();
    indexMapper.updateWorkOut(work);    
  }
  
  
  @Override
  public ResponseEntity<Map<String, Object>> getNoticeList(HttpServletRequest request) {
    Map<String, Object> map = new HashMap<>();
    List<NoticeBoardDto> noticeList = indexMapper.getNoticeList(map);
    map.put("noticeList", noticeList);
    return new ResponseEntity<>(map, HttpStatus.OK);
  }

}
