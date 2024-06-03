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

// contextPath
const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}

// 이메일 체크 및 임시 비밀번호 전송 함수
const fnCheckEmail = () => {
  
  let inpEmail = document.getElementById('emp-email');
  let msgEmail = document.getElementById('result-email');
  let regEmail = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  
  if(inpEmail.value.length === 0){
    emailCheck = false;
    msgEmail.innerHTML = '이메일은 공백일 수 없습니다';
    msgEmail.style.fontWeight = 'bold';
    msgEmail.style.fontSize = '0.75rem';
    msgEmail.style.color = '#EE2B4B';
  } else if(!regEmail.test(inpEmail.value)){
    emailCheck = false;
    msgEmail.innerHTML = '이메일 양식을 확인해주세요';
    msgEmail.style.fontWeight = 'bold';
    msgEmail.style.fontSize = '0.75rem';
    msgEmail.style.color = '#EE2B4B';
  } else {
    emailCheck = true;
    msgEmail.innerHTML = '';
  }

}

const fnSendEmail = () => {
  let msgEmail = document.getElementById('result-email');
  let inpEmail = document.getElementById('emp-email');
  fetch(fnGetContextPath() + '/user/checkEmail.do', {
    method: 'POST',
    headers : { 
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: JSON.stringify({
      'email': inpEmail.value
    })
  })
  .then(response => response.json())  
  //.then( (response) => { console.log(response); return response.json(); } )
  .then(resData => {
    if(resData.enableEmail){
      msgEmail.innerHTML = '';
      fetch(fnGetContextPath() + '/user/sendTempPassword.do', {
        method: 'POST',
        headers : { 
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify({
          'email': inpEmail.value
        })
      })
      .then(response => response.json())
      .then(resData => {  // resData = {"code": "123qaz"}
        if(resData.result === 1){
          alert(inpEmail.value + '로 임시 비밀번호를 전송했습니다. 로그인 후 비밀번호를 변경해주세요');
          location.href = '/login';         
        } else {
          alert('다시 시도해주세요');                    
        }
      })
    } else {
      msgEmail.innerHTML = '이메일이 존재하지 않습니다.';
      msgEmail.style.fontSize = '0.75rem';
      msgEmail.style.fontWeight = 'bold'; 
      msgEmail.style.color = '#EE2B4B';
      return;
    }
  })
  
}

// 취소 버튼 함수
const fnBack = () => {
  location.href = '/login';
}

/************************** 함수 호출 **************************/
document.getElementById('emp-email').addEventListener('blur', fnCheckEmail);
document.getElementById('send-temp').addEventListener('click', fnSendEmail);
document.getElementById('move-login').addEventListener('click', fnBack);