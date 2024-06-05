/**
 * 작성자 : 고은정
 * 기능   : 쪽지 보내기
 * 이력   :
 *    1) 240603
 *        - 쪽지 글자수 함수 추가
 *        - jQuery UI 활용해 자동완성 추가
 */

'use strict';

/************************** 변수 설정 **************************/


/************************** 함수 정의 **************************/

// 글자크기(Byte) 계산 함수
const fnCheckByte = ()=>{
    const maxByte = 4000; //최대 100바이트
    const textVal = document.getElementById('contents').value; //입력한 문자
    const textLen = textVal.length //입력한 문자수
    
    console.log(textLen);
    let totalByte=0;
    for(let i=0; i<textLen; i++){
      const eachChar = textVal.charAt(i);
        const uniChar = escape(eachChar); //유니코드 형식으로 변환
        if(uniChar.length>4){
          // 한글 : 2Byte
            totalByte += 2;
        }else{
          // 영문,숫자,특수문자 : 1Byte
            totalByte += 1;
        }
    }
    
    if(totalByte>maxByte){
      alert('최대 4000Byte까지만 입력가능합니다.');
          document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "red";
        }else{
          document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "green";
        }
    };

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
                label : item.empName  // 목록에 표시되는 값
              , value : item.empName + '[' + item.email + ']'  // 선택 시 input 창에 표시되는 값
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
      // 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, label/value/idex 를 가짐
    console.log(ui.item.label)
    console.log(ui.item.idx)
   }
  }).data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<div class='autocomplete-item'></div>")
          .append("<div>" + item.label + "</div>")
          .appendTo(ul);
      };


}

/*const fnEmployeeList = (evt)=>{
  let empNameList = [];
  let $receiver = document.getElementById('receiver');
  let $auto = document.getElementById('auto-complete');
  let nowIndex = 0;
  $.ajax({
    type: 'GET',
    url: fnGetContextPath() + '/employeeList',
    dataType: 'json',
    success: (resData)=>{
      $.each(resData.employeeList, (i, employee) => { 
        empNameList.push(employee.empName);
      });

        
      console.log(empNameList);
    },
    error: (jqXHR) => {
      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
    }         
  });
  $receiver.onkeyup = (evt)=>{
    // 검색어
    const value = $receiver.value.trim();
    
    // 자동완성 필터링
    const matchDetailList = value ? dataList.filter((label) => label.includes(value)) : [];
    
    switch(evt.keyCode){
      
    }
    
  }
  
}*/

/************************** 함수 호출 **************************/
document.getElementById('contents').addEventListener('keyup', fnCheckByte);
fnEmployeeList();
