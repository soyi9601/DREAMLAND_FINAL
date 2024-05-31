package com.dreamland.prj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.dto.RefreshDto;
import com.dreamland.prj.mapper.RefreshMapper;

@Transactional
@Service
public class RefreshServiceImpl implements RefreshService {

  @Autowired
  private RefreshMapper refreshMapper;
  
  
  @Override
  public void addRefreshToken(String username, String refreshToken, String expiration) {
    RefreshDto refresh = RefreshDto.builder()
                          .username(username)
                          .refToken(refreshToken)
                          .expiration(expiration)
                          .build();
    refreshMapper.insertRefresh(refresh);
    
  }
  
  @Override
  public void deleteByRefresh(String refresh) {
    refreshMapper.removeRefresh(refresh);
    
  }

  @Transactional(readOnly=true)
  @Override
  public int searchRefreshToken(String refresh) {

    return refreshMapper.getRefreshByRefreshToken(refresh);
  }

}
