/**
 * 작성자 : 고은정
 * 기능   : 받은편지함
 * 이력   :
 *    1) 240605
 *        - 받은 쪽지 개수 가져오기
 *        - MessageDto List 를 ajax 으로 가져오기
 *    2) 240611
 *        - 삭제 버튼, 공백 체크 함수
 */

'use strict';

/************************** 변수 설정 **************************/
var totalPage = 0;
var page = 0;

/************************** 함수 정의 **************************/

// 받은 메시지 카운트
$(document).ready(function() {
    $.ajax({
        type: 'GET',
        url: '/message/sendCount.do',
        data: 'empNo=' + empNo, 
        dataType: 'json',
        success: function(response) {
            $('#send-count').text(response);
        },
        error: function(jqXHR, textStatus, errorThrown) {
           console.error('Error:', textStatus, '(' + jqXHR.status + '):', errorThrown);
        }
    });
})

// 삭제 이동
document.getElementById("btn-delete").addEventListener("click", function(evt) {
    document.getElementById("frm-send-box").action = "/user/deleteSendMsg.do";
    fnBlankCheck(evt, '쪽지를 삭제하시겠습니까?','쪽지가 성공적으로 삭제되었습니다.');
});

// 공백 체크 함수
const fnBlankCheck = (evt, message1, message2)=>{
    let inpCheckbox = document.getElementsByClassName('form-check-input');
    let isChecked = false;
    
    for(let i = 0 ; i < inpCheckbox.length; i++){
      if(inpCheckbox[i].checked){
        isChecked = true;
        break;
      }
    }
    if(!isChecked){
      alert('쪽지를 선택해주세요');
      evt.preventDefault();
      return;
    } else {
      let btnConfirm = confirm(message1);
      if(!btnConfirm){
        evt.preventDefault();
        return;
      } else{
        document.getElementById("frm-send-box").submit();
        alert(message2);        
      }
      
    }
}

// 전체 선택 체크박스 이벤트 핸들러
document.getElementById("check-all").addEventListener("change", function() {
    let checkboxes = document.getElementsByClassName('form-check-input');
    for(let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = this.checked;
    }
});

/************************** 함수 호출 **************************/

