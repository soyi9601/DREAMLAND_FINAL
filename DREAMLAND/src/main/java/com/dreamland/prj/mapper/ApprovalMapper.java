package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.AppletterDto;
import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.ApvRefDto;
import com.dreamland.prj.dto.ApvWriterDto;
import com.dreamland.prj.dto.FaqBoardDto;

@Mapper
public interface ApprovalMapper {
	int getApvNo();
	int insertAproval(ApprovalDto appdto);
	int insertApvLetter(AppletterDto appLetterdto );
	int insertApvLeave(AppleaveDto appLeaveto );
	int insertaApvWriter(ApvWriterDto appwridto);
	int insertApvRef(ApvRefDto apprefdto);
}
