package com.dreamland.prj.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class NoticeBoardDto {
	
	private int noticeNo, signal, hit, empNo;
	private String boardTitle, boardContents;
	private Date boardCreateDt, boardModifyDt;
	private EmployeeDto employee;
	private int attachCount;
	private String delAttachList;
}
