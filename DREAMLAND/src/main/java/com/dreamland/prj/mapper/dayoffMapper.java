package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.AppleaveDto;

@Mapper
public interface dayoffMapper {
  
  List<AppleaveDto> getDayoffListByYear(Map<String, Object> params);
  String getEnterDate (int empNo);
  
}
