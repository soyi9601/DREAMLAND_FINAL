/**
 * 작성자 : 고은정
 * 기능   : 로그인
 * 이력   :
 *    1) 240606 - 이메일 체크 함수 js 파일로 분리, 아이디 저장 구현
 */

'use strict';

/************************** 변수 설정 **************************/


/************************** 함수 정의 **************************/

// 로그인 submit 후 에러메시지 출력
function getErrorMessageFromURL() {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get('exception');
}

// 페이지가 로드될 때 실행
document.addEventListener('DOMContentLoaded', function() {
  // 오류 출력
  const errorMessage = getErrorMessageFromURL();
  
  if (errorMessage) {
    // 오류 메시지를 출력할 요소를 찾아서 오류 메시지를 삽입
    const loginResultElement = document.querySelector('.login-result');
    if (loginResultElement) {
      loginResultElement.textContent = errorMessage;
    }
  }
  
  // 쿠키에서 저장된 아이디를 불러오기
  var savedUsername = getCookie("savedUsername");
  if (savedUsername) {
    document.getElementById("username").value = savedUsername;
    document.getElementById("remember-me").checked = true;
  }
  
  // 쿠키 설정 함수
  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }
  
  // 쿠키 가져오기 함수
  function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }
  
  // 로그인 폼 제출 시 아이디 저장 처리
  document.getElementById("formAuthentication").addEventListener("submit", function () {
    if (document.getElementById("remember-me").checked) {
      setCookie("savedUsername", document.getElementById("username").value, 30); // 30일 동안 저장
    } else {
      setCookie("savedUsername", "", -1); // 쿠키 삭제
    }
  });
});

// 이메일 체크 함수
const fnEmailCheck = () => {
  let inpEmail = document.getElementById('username');
  let regEmail = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  let emailResult = document.getElementById('email-result');
  if(!regEmail.test(inpEmail.value)){
    emailResult.innerHTML = '이메일을 확인해주세요';
    emailResult.style.fontSize = '0.75rem';
    emailResult.style.fontWeight = 'bold';
    emailResult.style.color = '#EE2B4B';
    return;
  } else {
    emailResult.innerHTML = '';
  }
}

/************************** 함수 호출 **************************/
document.getElementById('username').addEventListener('blur', fnEmailCheck);
