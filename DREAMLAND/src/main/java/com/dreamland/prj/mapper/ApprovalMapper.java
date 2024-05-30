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
	 int insertApvRef(String empNo, int apvNo);
	
	 int getApvCount(String empNo);
	 int getWaitApvCount(String empNo);
	 int getConfirmApvCount(String empNo);
	 int getCompleteApvCount(String empNo);
	
	 int getMyApvCount(String empNo);
	 int getMyWaitApvCount(String empNo);
	 int getMyCompleApvCount(String empNo);
	 int getMyRejectApvCount(String empNo);
	
	 int getMyReferApvCount(String empNo);
	 int getMyReferWaitApvCount(String empNo);
	 int getMyReferCompleApvCount(String empNo);
	 int getMyReferRejectApvCount(String empNo);
	
	 List<ApprovalDto> getApvList(Map<String, Object> map);
	 List<ApprovalDto> getWaitApvList(Map<String, Object> map);
	 List<ApprovalDto> getConfirmApvList(Map<String, Object> map);
	 List<ApprovalDto> getCompleteApvList(Map<String, Object> map);
	 
	 List<ApprovalDto> getMyApvList(Map<String, Object> map);	 
	 List<ApprovalDto> getMyWaitApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyCompleteApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyRejectedApvList(Map<String, Object> map);
	 
	 List<ApprovalDto> getMyReferApvList(Map<String, Object> map);	 
	 List<ApprovalDto> getMyReferWaitApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyReferCompleteApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyReferRejectedApvList(Map<String, Object> map);
	 
	 ApprovalDto getApvDetailByNo(int apvNo);
	 AppleaveDto getApvLeaveDetailByNo(int apvNo);
	 AppletterDto getApvAppDetailByNo(int apvNo);
	 int updateApprover(int apvNo, String empNo, String returnReason);
	 int updateApproval(int apvNo, int state);
	 List<String> getApprovers(int apvNo);
	 ApvWriterDto getReturnApprover(int apvNo);
	 
}
