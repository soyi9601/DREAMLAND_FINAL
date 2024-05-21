package com.dreamland.prj.service;

import org.springframework.stereotype.Service;

import com.dreamland.prj.mapper.SchduleMapper;

@Service
public class SchduleServiceImpl implements SchduleService {

  private final SchduleMapper schduleMapper;

  public SchduleServiceImpl(SchduleMapper schduleMapper) {
    super();
    this.schduleMapper = schduleMapper;
  }
  
  
}
