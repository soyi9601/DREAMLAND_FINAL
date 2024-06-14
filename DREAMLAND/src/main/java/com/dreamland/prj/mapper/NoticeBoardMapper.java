package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.NoticeAttachDto;
import com.dreamland.prj.dto.NoticeBoardDto;


import jakarta.servlet.http.HttpServletRequest;

@Mapper
public interface NoticeBoardMapper {
  int insertNoticeBoard(NoticeBoardDto notice);
  int insertNoticeAttach(NoticeAttachDto attach);
  int getNoticeCount();
  List<NoticeBoardDto> getNoticeList(Map<String, Object> map);
  NoticeBoardDto getNoticeByNo(int noticeNo);
  List<NoticeAttachDto> getAttachList(int noticeNo);
  NoticeAttachDto getAttachByNo(int attachNo);
  int updateNotice(NoticeBoardDto notice);
  int deleteAttach(int attachNo);
  int deleteNotice(int noticeNo);
  int updateHit(int noticeNo);
}
