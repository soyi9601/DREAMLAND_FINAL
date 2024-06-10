/**
 * 작성자 : 고은정
 * 기능   : 받은편지함
 * 이력   :
 *    1) 240605
 *        - 받은 쪽지 개수 가져오기
 *        - MessageDto List 를 ajax 으로 가져오기
 *    2) 240609
 *        - 상세보기, 삭제, 보관함 이동 함수
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
        url: '/message/receiveCount.do',
        data: 'empNo=' + empNo, 
        dataType: 'json',
        success: function(response) {
            $('#receive-count').text(response.notReadCount + ' / ' + response.total);
            
        },
        error: function(jqXHR, textStatus, errorThrown) {
           console.error('Error:', textStatus, '(' + jqXHR.status + '):', errorThrown);
        }
    });
})

// 상세보기 링크
document.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll(".clickable-row");
    rows.forEach(row => {
        row.addEventListener("click", () => {
            window.location.href = row.dataset.href;
        });
    });
});

// 중요보관함 이동
document.getElementById("btn-save").addEventListener("click", function() {
    document.getElementById("receive-form").action = "/user/saveMsg.do";
    document.getElementById("receive-form").submit();
});

// 삭제 이동
document.getElementById("btn-delete").addEventListener("click", function() {
    document.getElementById("receive-form").action = "/user/deleteMsg.do";
    document.getElementById("receive-form").submit();
});


/************************** 함수 호출 **************************/

