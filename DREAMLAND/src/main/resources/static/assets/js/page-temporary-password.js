/**
 * 작성자 : 고은정
 * 기능   : 임시 비밀번호 발급
 * 이력   :
 *    1) 240530
 *        - 이메일 체크 함수 추가
 */

'use strict';

/************************** 변수 설정 **************************/
var emailCheck = false;


/************************** 함수 정의 **************************/
// 이메일 체크 함수
const fnCheckEmail = () => {
  
  let inpEmail = document.getElementById('emp-email');
  let msgEmail = document.getElementById('result-email');
  let regEmail = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  
  if(inpEmail.value.length === 0){
    emailCheck = false;
    msgEmail.innerHTML = '이메일은 공백일 수 없습니다';
    msgEmail.style.fontSize = '0.75rem';
    msgEmail.style.color = '#EE2B4B';
  } else if(!regEmail.test(inpEmail.value)){
    emailCheck = false;
    msgEmail.innerHTML = '이메일 양식을 확인해주세요';
    msgEmail.style.fontSize = '0.75rem';
    msgEmail.style.color = '#EE2B4B';
  } else {
    emailCheck = true;
    msgEmail.innerHTML = '';
  }
}

/************************** 함수 호출 **************************/
document.getElementById('emp-email').addEventListener('blur', fnCheckEmail);

