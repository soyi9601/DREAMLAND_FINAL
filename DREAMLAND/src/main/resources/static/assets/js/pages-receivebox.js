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
        url: '/message/receiveCount.do',
        data: 'empNo=' + empNo, 
        dataType: 'json',
        success: function(response) {
            $('#receive-count').text(response + '개 / ');
        },
        error: function(jqXHR, textStatus, errorThrown) {
           console.error('Error:', textStatus, '(' + jqXHR.status + '):', errorThrown);
        }
    });
})

// 받은 쪽지함 리스트
const fnGetReceiveMessage = () => {
  $.ajax({
    // 요청
    type: 'GET',
    url: '/message/getReceiveMessage.do',
    data: 'empNo=' + empNo + '&page=' + page,
    // 응답
    dataType: 'json',
    success: (resData) => {
      console.log(resData);
      totalPage = resData.totalPage;
      const receiveList = $('#receive-list');
      const receivePage = $('#receive-page');
      if (page === 1) {
        receiveList.empty();
      }
      if (resData.messageList.length === 0) {
        receiveList.append('<tr><td>받은 쪽지가 없습니다</td></tr>');
      } else {
        $.each(resData.messageList, (i, msg) => {         
          let str = '<tr><td><input class="form-check-input" type="checkbox" value="" id="defaultCheck1" /></td>';
          str += '<td>' + (i + 1) + '</td>';
          str += '<td>' + msg.msgContents + '</td>';
          str += '<td>' + msg.msgCreateDt + '</td>';
          str += '<td>' + msg.senderName + '</td>';
          str += '<td>';
          str += '  <div class="dropdown">';
          str += '    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">';
          str += '      <i class="bx bx-dots-vertical-rounded"></i>'
          str += '    </button>';
          str += '    <div class="dropdown-menu">'
          str += '      <a class="dropdown-item" href=""><i class="bx bx-edit-alt me-1"></i>답장하기</a>';
          str += '<a class="dropdown-item" href=""><i class="bx bx-trash me-1"></i>삭제하기</a>';
          str += '</div></div></td>'
          str += '</tr>';

          receiveList.append(str);
        });
        receivePage.append(resData.paging);
      }
    },
    error: (jqXHR) => {
      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
    }
  });
}

/************************** 함수 호출 **************************/
/*document.getElementById('contents').addEventListener('keyup', fnCheckByte);
fnEmployeeList();*/
fnGetReceiveMessage();
