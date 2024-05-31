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
	String getEmployeeNo(String empName);
	String getEmployeeName(String empNo);
	List<String> getApprover(int apvNo);
	int insertApproval(ApprovalDto appdto);
	int insertApvLetter(AppletterDto appLetterdto );
	int insertApvLeave(AppleaveDto appLeaveto );
	int insertApvWriter(ApvWriterDto appwridto);
	int insertApvRef(ApvRefDto apprefdto);
	int getApvCount(String empNo);
	int getWaitApvCount(String empNo);
	int getConfirmApvCount(String empNo);
	int getCompleteApvCount(String empNo);
	 List<ApprovalDto> getApvList(Map<String, Object> map);
	 List<ApprovalDto> getWaitApvList(Map<String, Object> map);
	 List<ApprovalDto> getConfirmApvList(Map<String, Object> map);
	 List<ApprovalDto> getCompleteApvList(Map<String, Object> map);
	 ApprovalDto getApvDetailByNo(int apvNo);
	 AppleaveDto getApvLeaveDetailByNo(int apvNo);
	 AppletterDto getApvAppDetailByNo(int apvNo);
	 int updateApprover(int apvNo, String empNo);
	 int updateApproval(int apvNo);
	 List<String> getApprovers(int apvNo);
}
