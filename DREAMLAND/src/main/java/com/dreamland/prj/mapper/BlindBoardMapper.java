package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.BlindBoardDto;
import com.dreamland.prj.dto.BlindCommentDto;
import com.dreamland.prj.dto.BlindImageDto;

@Mapper
public interface BlindBoardMapper {
	int insertBlindBoard(BlindBoardDto blind);
	int insertBlindImage(BlindImageDto blindImage);
	int getBlindCount();
	List<BlindBoardDto> getBlindList(Map<String, Object> map);
	
	BlindBoardDto getBlindByNo(int blindNo);
	int updateBlind(BlindBoardDto blind);
	List<BlindImageDto> getBlindImageList(int blindNo);
	int deleteBlindImage(String filesystemName);
	int deleteBlindImageList(int blindNo);
	int deleteBlind(int blindNo);
	//
	String getPasswordByBlindNo(int blindNo);
	
	// 조회수
	int updateHit(int blindNo);
	
	//댓글
	int insertComment(BlindCommentDto comment);
	int getCommentCount(int blindNo);
	List<BlindCommentDto> getCommentList(Map<String, Object> map);
	int insertReply(BlindCommentDto comment);
	int deleteComment(int commentNo);
	int updateComment(Map<String, Object> map);
	
	
	//비밀번호
	String getPasswordByCommentNo(int commentNo);
}
