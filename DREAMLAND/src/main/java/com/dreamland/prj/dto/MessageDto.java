package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class MessageDto {
	
  private int msgNo, msgSender, msgReceiver;
  private String msgContents, readYn, delYn, starYn, senderName, receiverName, msgCreateDt;
  
}
