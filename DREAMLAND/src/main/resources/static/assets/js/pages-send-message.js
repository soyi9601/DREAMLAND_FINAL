/**
 * 작성자 : 고은정
 * 기능   : 쪽지 보내기
 * 기능   : 받은편지함
 * 이력   :
 *    1) 240603
 *        - 쪽지 글자수 함수 추가
 *        - jQuery UI 활용해 자동완성 추가
 *    2) 240604
 *        - input 안에 button 추가
 *    3) 240614
 *        - 글자 바이트->글자수 함수 변경
 */

'use strict';

/************************** 변수 설정 **************************/
var contentsCheck = false;

/************************** 함수 정의 **************************/

// 글자수 계산 함수
const fnCheckLength = ()=>{
    const maxLength = 1000; //최대 1000 글자
    const textVal = document.getElementById('contents').value; //입력한 문자
    const textLen = textVal.length //입력한 문자수
    
    
    if(textLen >maxLength){
      contentsCheck = true;
      alert('최대 1000글자까지만 입력가능합니다.');
          document.getElementById("nowByte").innerText = textLen;
            document.getElementById("nowByte").style.color = "red";
        }else{
          contentsCheck = false;
          document.getElementById("nowByte").innerText = textLen;
            document.getElementById("nowByte").style.color = "green";
        }
    }

// 자동완성 기능
const fnEmployeeList = (evt)=>{
  $('#receiver').autocomplete({
    source : function(request, response){ // source : 입력시 보일 목록
      $.ajax({
      type: 'GET',
      url: fnGetContextPath() + '/employeeList',
      dataType: 'json',
      data : {value : request.term},    // 검색 키워드
      success: (resData)=>{   // 성공
        response(
          $.map(resData.resultList, function(item){
            return {
                label : item.empName + '[' + item.deptName + '-' + item.posName + ']'  // 목록에 표시되는 값
              , value : item.empName + '[' + item.deptName + '-' + item.posName + ']'  // 선택 시 input 창에 표시되는 값
              , idx : item.empNo
            };
          })
        );  // response
      },
      error: (jqXHR) => { // 실패
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }         
    });  
   }
   ,focus : function(evt, ui){ return false; } // 방향키로 자동완서단어 선택 가능하게 만들어 줌
   ,minLength: 1    // 최소 글자수
   ,autoFocus: true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
   ,delay: 100      // 딜레이 시간
   ,appendTo: '#auto-complete'  // div 에 항목 출력
   ,select: function(evt, ui){
      evt.preventDefault(); // 기본 동작 막기
      // const receiverContainer = $('#receiver-container');

        // 선택된 아이템으로 버튼 생성하여 input 필드 안에 추가
        const button = $("<button type='button' class='btn btn-outline-secondary'></button>")
          .text(ui.item.value)
          .on('click', function() {
            $(this).next('input[type="hidden"]').remove(); // 숨겨진 input 제거
            $(this).remove(); // 버튼 클릭 시 제거
          });

        const hiddenInput = $("<input type='hidden' name='receiver'>").val(ui.item.idx);

        $('#receiver').val(''); // 입력 필드 비우기
        button.insertBefore('#receiver'); // 입력 필드 앞에 버튼 추가
        hiddenInput.insertBefore('#receiver'); // 입력 필드 앞에 숨겨진 input 추가

   }
  }).data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<div class='autocomplete-item'></div>")
          .append("<div>" + item.label + "</div>")
          .appendTo(ul);
      };

}

// 공백 체크 함수
const fnBlankCheck = ()=>{
  document.getElementById('frm-send-message').addEventListener('submit', (evt)=>{ 
    let inpContents = document.getElementById('contents');
    let inpContainer = document.getElementById('receiver-container');
    let hasButton = inpContainer.querySelector("button");
    if(inpContents.value.length === 0 || contentsCheck){
      alert('쪽지 내용을 확인해주세요');
      evt.preventDefault();
      return;
    } else if(!hasButton){
      alert('받는 사람을 입력해주세요');
      evt.preventDefault();
      return;
    }
    alert('쪽지를 성공적으로 보냈습니다.');
    })
  
}


/************************** 함수 호출 **************************/
document.getElementById('contents').addEventListener('keyup', fnCheckLength);
document.getElementById('btn-cancel').addEventListener('click', ()=>{
  window.history.back();
});
fnEmployeeList();
fnBlankCheck();
