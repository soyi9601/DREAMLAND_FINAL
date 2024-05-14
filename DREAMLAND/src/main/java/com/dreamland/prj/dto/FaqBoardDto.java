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

public class FaqBoardDto {
	
	int faqNo, hit, category, empNo;
	String boardTitle, boardContents;
	Date boardCreateDt, boardModifyDt;
	
}
