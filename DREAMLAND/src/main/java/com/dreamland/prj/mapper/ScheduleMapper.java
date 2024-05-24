package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.ScheduleDto;

@Mapper
public interface ScheduleMapper {
  int skdAdd(ScheduleDto schedule);
  List<ScheduleDto> getSkdList(Map<String, Object> map);
  
}
