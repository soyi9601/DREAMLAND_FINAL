package com.dreamland.prj.service;

import org.springframework.stereotype.Service;

import com.dreamland.prj.mapper.dayoffMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class dayoffServiceImpl implements dayoffService {

  private final dayoffMapper dayoffMapper;
  
}
