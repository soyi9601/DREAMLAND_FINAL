package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WorkMapper {
  
  void updateLates(String workDate);
  void updateAbsencees(String workDate);
  
}
