package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.FaqBoardDto;

@Mapper
public interface ApprovalMapper {
	int getEmployee(String unerNo);
	int registerApproval(ApprovalDto appvdto);

}
