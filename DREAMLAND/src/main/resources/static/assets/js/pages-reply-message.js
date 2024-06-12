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
 */

'use strict';

/************************** 변수 설정 **************************/


/************************** 함수 정의 **************************/

// 글자크기(Byte) 계산 함수
const fnCheckByte = ()=>{
    const maxByte = 4000; //최대 100바이트
    const textVal = document.getElementById('contents').value; //입력한 문자
    const textLen = textVal.length //입력한 문자수
    
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
document.getElementById('contents').addEventListener('keyup', fnCheckByte);
fnBlankCheck();
