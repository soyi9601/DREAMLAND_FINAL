package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.AppletterDto;
import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.ApvAttachDto;
import com.dreamland.prj.dto.ApvRefDto;
import com.dreamland.prj.dto.ApvWriterDto;
import com.dreamland.prj.dto.FaqBoardDto;

@Mapper
public interface ApprovalMapper {
	 int getApvNo();
	 String getEmployeeNo(String empName);
	 String getEmployeeName(String empNo);
	 List<String> getReferrer(int apvNo);
	 List<String> getApprover(int apvNo);
	
	 int insertApproval(ApprovalDto appdto);
	 int insertApvAttach(ApvAttachDto appdto);
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
	 int getMyTempApvCount(String empNo);
	
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
	 List<ApprovalDto> getMyTempApvList(Map<String, Object> map);
	 
	 List<ApprovalDto> getMyReferApvList(Map<String, Object> map);	 
	 List<ApprovalDto> getMyReferWaitApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyReferCompleteApvList(Map<String, Object> map);
	 List<ApprovalDto> getMyReferRejectedApvList(Map<String, Object> map);
	 
	 ApprovalDto getApvDetailByNo(int apvNo);
	 AppleaveDto getApvLeaveDetailByNo(int apvNo);
	 AppletterDto getApvAppDetailByNo(int apvNo);
	 List<ApvAttachDto> getAttachList(int apvNo);
	 ApvAttachDto getAttachByNo(int attachNo);
	 int updateApprover(int apvNo, String empNo, String returnReason);
	 int updateApproval(int apvNo, int state);
	 int updateApvLeave(int apvNo);
	 int modifyApproval(ApprovalDto apvNo);
	 int modifyApvWriter(int empNo, String apvNo, int i);
	 int modifyApvLetter(String apvNo , String detail  );
	 int modifyApvLeave( AppleaveDto leave);
	 int revokeApproval(String apvNo );
	 int revokeApvLeave(String apvNo );
	 int  deleteApvRef(int apvNo);
	 int  deleteApvWriter(int apvNo);
	 int  deleteAttach(String apvNo, String attachNo);
	 List<String> getApprovers(int apvNo);
	 ApvWriterDto getReturnApprover(int apvNo);
	 
}
