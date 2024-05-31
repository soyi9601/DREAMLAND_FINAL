package com.dreamland.prj.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.mapper.WorkMapper;

@Service
public class WorkServiceImpl implements WorkService {
  
  private WorkMapper workMapper;

  public WorkServiceImpl(WorkMapper workMapper) {
    super();
    this.workMapper = workMapper;
  }
  
  @Override
  @Transactional
  public void checkLate() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    workMapper.updateLates(today);
    
  }
  
  @Override
  @Transactional
  public void checkAbsence() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    workMapper.updateAbsencees(today);
    
  }

}
