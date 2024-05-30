package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.RefreshDto;

@Mapper
public interface RefreshMapper {
  int insertRefresh(RefreshDto user);
  int getRefreshByRefreshToken(String refreshToken);
  int removeRefresh(String refToken);
  int removeRefreshByDate();

}
