package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.FaqBoardDto;

@Mapper
public interface FaqBoardMapper {
	int insertFaqBoard(FaqBoardDto faqBoardDto);
	int getFaqBoardCount();
	List<FaqBoardDto> getFaqBoardList(Map<String, Object> map);
	FaqBoardDto getFaqBoarByNo(int faqNo);
	int updateFaqBoard(FaqBoardDto faqBoardDto);
	int deleteFaqBoard(int faqNo); 
}
