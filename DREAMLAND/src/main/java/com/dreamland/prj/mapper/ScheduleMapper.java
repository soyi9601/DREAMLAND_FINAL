package com.dreamland.prj.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.ScheduleDto;

@Mapper
public interface ScheduleMapper {
  int skdAdd(ScheduleDto schedule);
  
}
