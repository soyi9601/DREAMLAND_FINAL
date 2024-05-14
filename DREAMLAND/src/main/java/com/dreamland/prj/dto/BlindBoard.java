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

public class BlindBoard {
	
	private int blindNo, hit, password;
	private String boardTitle, boardContents, delYn;
	private Date boardCreateDt, boardModifyDt;
	
}
