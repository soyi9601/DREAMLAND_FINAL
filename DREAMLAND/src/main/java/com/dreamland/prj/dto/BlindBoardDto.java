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

public class BlindBoardDto {
	
	private int blindNo, hit;
	private String boardTitle, boardContents, delYn, password;
	private Date boardCreateDt, boardModifyDt;
	
}
