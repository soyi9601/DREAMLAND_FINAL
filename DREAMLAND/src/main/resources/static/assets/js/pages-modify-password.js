/**
 * 작성자 : 고은정
 * 기능   : 비밀번호 변경
 * 이력   :
 *    1) 240524
 *        - preventDefault 완료
 *        - 새로운 비밀번호 정규식
 *    2) 240530
 *        - 비밀번호 변경 java 구현
 */

'use strict';

/************************** 변수 설정 **************************/
var passwordCheck = false;
var passwordConfirm = false;
var currentPasswordCheck = false;

/************************** 함수 정의 **************************/
// 새로운 비밀번호 정규식 체크
const fnCheckPassword = () => {
  
  let newPw = document.getElementById('new-password').value;
  // 비밀번호 4~12자, 영문/숫자/특수문자 중 2개 이상 포함
  let validCount = /[A-Za-z]/.test(newPw)     // 영문 포함되어 있으면 true (JavaScript 에서 true 는 숫자 1 같다.)
                 + /[0-9]/.test(newPw)        // 숫자 포함되어 있으면 true
                 + /[^A-Za-z0-9]/.test(newPw) // 영문/숫자가 아니면 true
  let passwordLength = newPw.length;
  passwordCheck = passwordLength >= 4
               && passwordLength <= 12
               && validCount >= 2
  let msgPw = document.getElementById('new-password-result');
  if(!passwordCheck){
    msgPw.innerHTML = '비밀번호 4~12자, 영문/숫자/특수문자 중 2개 이상 포함';
    msgPw.style.fontSize = '0.75rem';
    msgPw.style.fontWeight = 'bold';
    msgPw.style.color = '#EE2B4B';
  } else {
    msgPw.innerHTML = '사용 가능한 비밀번호입니다.';
    msgPw.style.fontSize = '0.75rem';
    msgPw.style.fontWeight = 'bold';
    msgPw.style.color = '#BDBDBD';
  }
}

// 새로운 비밀번호 확인
const fnConfirmPassword = () => {
  let newPw = document.getElementById('new-password');
  let newPw2 = document.getElementById('new-password2');
  passwordConfirm = (newPw.value !== '')
                 && (newPw.value === newPw2.value)

  let msgPw2 = document.getElementById('password-check-result');
  if(!passwordConfirm) {
    msgPw2.innerHTML = '새로운 비밀번호와 일치하지 않습니다.';
    msgPw2.style.fontSize = '0.75rem';
    msgPw2.style.fontWeight = 'bold';
    msgPw2.style.color = '#EE2B4B';
  } else {
    msgPw2.innerHTML = '';
  }
}

// 현재 비밀번호 확인
const fnCurrentPasswordCheck = () => {
  let currentPw = document.getElementById('now-password');
  currentPasswordCheck = (currentPw.value !== '');
}

// preventDefault 부분
const fnModifyPassword = () =>{
  document.getElementById('frm-modify-password').addEventListener('submit', (evt)=>{

    if(!currentPasswordCheck){
      alert('현재 비밀번호를 확인해주세요');
      evt.preventDefault();
      return;
    }else if(!passwordCheck){
      alert('새로운 비밀번호 양식을 확인하세요');
      evt.preventDefault();
      return;
    } else if(!passwordConfirm){
      alert('새로운 비밀번호와 일치하지 않습니다.');
      evt.preventDefault();
      return;      
    }else if(newPw === ''){
      alert('새로운 비밀번호를 확인해주세요');
      evt.preventDefault();
      return;
    }
    
  });

}

/************************** 함수 호출 **************************/
document.getElementById('new-password').addEventListener('blur', fnCheckPassword);
document.getElementById('new-password2').addEventListener('blur', fnConfirmPassword);
document.getElementById('now-password').addEventListener('blur',fnCurrentPasswordCheck);
fnModifyPassword();
fnInsertResult();