/**
 * 작성자 : 고은정
 * 기능   : 중요보관함
 * 이력   :
 *    1) 240610
 *        - 삭제 쪽지 가져오기
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
        url: '/message/deleteCount.do',
        data: 'empNo=' + empNo, 
        dataType: 'json',
        success: function(response) {
            $('#delete-count').text(response.notReadCount + ' / ' + response.total);
            
        },
        error: function(jqXHR, textStatus, errorThrown) {
           console.error('Error:', textStatus, '(' + jqXHR.status + '):', errorThrown);
        }
    });
})

// 전체 선택 체크박스 이벤트 핸들러
document.getElementById("check-all").addEventListener("change", function() {
    let checkboxes = document.getElementsByClassName('form-check-input');
    for(let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = this.checked;
    }
});


/************************** 함수 호출 **************************/

