/**
 * 작성자 : 고은정
 * 기능   : 쪽지 보내기
 * 기능   : 받은편지함
 * 이력   :
 *    1) 240611
 *        - 쪽지 글자수 함수 추가
 *        - jQuery UI 활용해 자동완성 추가
 *    2) 240604
 *        - input 안에 button 추가
 *    3) 240614
 *        - 글자 바이트->글자수 함수 변경
 */

'use strict';

/************************** 변수 설정 **************************/


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

// 공백 체크 함수
const fnBlankCheck = ()=>{
  document.getElementById('frm-reply-message').addEventListener('submit', (evt)=>{ 
    let inpContents = document.getElementById('contents');
    let inpContainer = document.getElementById('receiver-container');
    let hasButton = inpContainer.querySelector("button");
    if(inpContents.value.length === 0){
      alert('쪽지 내용을 입력해주세요');
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
fnBlankCheck();
