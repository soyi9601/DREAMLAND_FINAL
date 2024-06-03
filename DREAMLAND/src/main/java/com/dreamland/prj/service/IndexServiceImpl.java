package com.dreamland.prj.service;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.WorkDto;
import com.dreamland.prj.mapper.IndexMapper;


@Service
public class IndexServiceImpl implements IndexService {

  private final IndexMapper indexMapper;
  
  public IndexServiceImpl(IndexMapper indexMapper) {
    super();
    this.indexMapper = indexMapper;
  }

  @Override
  public EmployeeDto loadUser(String email) {
    return indexMapper.getUser(email);
  }
  
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

}
