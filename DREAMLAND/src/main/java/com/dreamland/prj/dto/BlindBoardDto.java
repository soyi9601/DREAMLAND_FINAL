package com.dreamland.prj.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class BlindBoardDto {
	
	private int blindNo, hit, commentCount;
	private String boardTitle, boardContents, delYn, password;
	private Timestamp boardCreateDt, boardModifyDt;
	
}
