/**
 * 작성자 : 고은정
 * 기능   : 받은편지함
 * 이력   :
 *    1) 240605
 *        - 받은 쪽지 개수 가져오기
 *        - MessageDto List 를 ajax 으로 가져오기
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

/************************** 함수 호출 **************************/
/*document.getElementById('contents').addEventListener('keyup', fnCheckByte);
fnEmployeeList();*/
//fnGetReceiveMessage();
