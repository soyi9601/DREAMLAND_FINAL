/**
 * 작성자 : 고은정
 * 기능   : 보낸쪽지 상세 - 삭제
 * 이력   :
 *    1) 240611
 *        - alert 추가
 */

'use strict';

/************************** 변수 설정 **************************/

/************************** 함수 정의 **************************/

// 중요보관함 이동
document.getElementById("btn-save").addEventListener("click", function(evt) {
    document.getElementById("frm-send-detail").action = "/user/saveSendMsg.do";
    fnBlankCheck(evt, '쪽지를 보관하시겠습니까?','쪽지가 성공적으로 보관되었습니다.');
});

// 삭제 이동
document.getElementById("btn-delete").addEventListener("click", function(evt) {
    document.getElementById("frm-send-detail").action = "/user/deleteSendMsg.do";
    fnBlankCheck(evt, '쪽지를 삭제하시겠습니까?','쪽지가 성공적으로 삭제되었습니다.');
});

// 공백 체크 함수
const fnBlankCheck = (evt, message1, message2)=>{
      let btnConfirm = confirm(message1);
      if(!btnConfirm){
        evt.preventDefault();
        return;
      } else{
        document.getElementById("frm-send-detail").submit();
        alert(message2);        
      }
      
}


/************************** 함수 호출 **************************/

