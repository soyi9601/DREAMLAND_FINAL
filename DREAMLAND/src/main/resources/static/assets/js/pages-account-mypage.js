/**
 * 작성자 : 고은정
 * 기능   : 마이페이지 수정
 * 이력   :
 *    1) 240524
 *        - preventDefault 완료
 *        - 정규식(이름, 이메일, 휴대전화)
 *    1) 240613
 *        - 이름, 휴대전화 체크 함수를 oninput="함수이름()" 으로 호출 방식 변경
 */

'use strict';
/************************** 변수 설정 **************************/
var nameCheck = true;
var mobileCheck = true;


/************************** 함수 정의 **************************/

// 이미지 등록 함수(프로필 사진, 전자서명)
document.addEventListener('DOMContentLoaded', function (e) {
  (function () {
    const deactivateAcc = document.querySelector('#formAccountDeactivation');

    // 직원 사진
    let accountUserImage = document.getElementById('uploadedAvatar');
    const fileInput = document.querySelector('.account-file-input'),
      resetFileInput = document.querySelector('.account-image-reset');

      
    // 전자 서명
    let accountSignImage = document.getElementById('uploadSign');
    //const signInput = document.querySelector('.account-sign-input'),
      //resetSignInput = document.querySelector('.account-sign-reset');
    if (accountUserImage /*&& accountSignImage*/) {
      const resetImage = accountUserImage.src;
      // const resetSign = accountSignImage.src;

      // 프로필 이미지
      fileInput.onchange = () => {
        let maxSize = 800 * 1024;
        if (fileInput.files[0]) {
          if (fileInput.files[0].size > maxSize ){
            alert('사진 크기는 최대 800KB 입니다. 다시 선택해주세요');
            return;
          } else{            
            accountUserImage.src = window.URL.createObjectURL(fileInput.files[0]);
          }
        }
      };
      resetFileInput.onclick = () => {
        fileInput.value = '';
        accountUserImage.src = resetImage;
      };
      
/*      // 서명 등록
      signInput.onchange = () => {
        let maxSize = 100 * 1024;
        if (signInput.files[0]) {
          if (signInput.files[0].size > maxSize ){
            alert('서명 크기는 최대 100KB 입니다. 다시 선택해주세요');
            return;
          } else{            
            accountSignImage.src = window.URL.createObjectURL(signInput.files[0]);
          }
        }
      };
      resetSignInput.onclick = () => {
        signInput.value = '';
        accountSignImage.src = resetSign;
      };*/
    }
  })();
});

// kakao 도로명 주소 api
function fnExecDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var addr = ''; // 주소 변수
      var extraAddr = ''; // 참고항목 변수

      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
      }

      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      if(data.userSelectedType === 'R'){
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가한다.
        if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraAddr !== ''){
            extraAddr = ' (' + extraAddr + ')';
        }
        // 조합된 참고항목을 해당 필드에 넣는다.
        document.getElementById("detailAddress").value = extraAddr;
      
      } else {
          document.getElementById("detailAddress").value = '';
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('postcode').value = data.zonecode;
      document.getElementById("address").value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.getElementById("detailAddress").focus();
    }
  }).open();
}

// 이름 체크 함수
const fnCheckName = () => {
  let inpName = document.getElementById('emp-name');
  let name = inpName.value;
  let totalByte = 0;
  let msgName = document.getElementById('name-result');
  let regName = /^[가-힣a-zA-Z]+$/;
  
  // 글자수 -> byte 계산
  for(let i = 0; i < name.length; i++){
    if(name.charCodeAt(i) > 127) {  // 코드값이 127 초과이면 한 글자 당 2바이트 처리한다.
      totalByte += 2;
    } else {
      totalByte++;
    }
  }

  nameCheck = (totalByte <= 20);

  // 공백 및 byte 초과 체크
  if(totalByte === 0){
    nameCheck = false;
    msgName.innerHTML = '이름은 공백일 수 없습니다';
    msgName.style.fontSize = '0.75rem';
    msgName.style.color = '#EE2B4B';
  } else if(!nameCheck){
      nameCheck = false;
      msgName.innerHTML = '이름은 20 바이트를 초과할 수 없습니다.';
      msgName.style.fontSize = '0.75rem';
      msgName.style.fontWeight = 'bold';
      msgName.style.color = '#EE2B4B';
  } else if(!regName.test(name)) {
      nameCheck = false;
      msgName.innerHTML = '이름은 숫자와 특수문자가 포함될 수 없습니다.';
      msgName.style.fontSize = '0.75rem';
      msgName.style.fontWeight = 'bold';
      msgName.style.color = '#EE2B4B';
  } else {
    nameCheck = true;
    msgName.innerHTML = '';
  }

}

// 휴대전화 체크 함수
const fnCheckMobile = () => {
  let inpMobile = document.getElementById('emp-mobile');
  let msgMobile = document.getElementById('result-mobile');
  let regMobile = /^01[0-1,6-9]-\d{4}-\d{4}$/;
  
  if(inpMobile.value.length === 0){
    mobileCheck = false;
    msgMobile.innerHTML = '휴대전화는 공백일 수 없습니다';
    msgMobile.style.fontSize = '0.75rem';
    msgMobile.style.fontWeight = 'bold';
    msgMobile.style.color = '#EE2B4B';
  } else if(!regMobile.test(inpMobile.value)){
    mobileCheck = false;
    msgMobile.innerHTML = '전화번호 양식을 확인해주세요';
    msgMobile.style.fontSize = '0.75rem';
    msgMobile.style.fontWeight = 'bold';
    msgMobile.style.color = '#EE2B4B';
  } else {
    mobileCheck = true;
    msgMobile.innerHTML = '';
  }
}

// preventDefault 부분
const fnAddEmployee = () =>{
  document.getElementById('frm-modify-info').addEventListener('submit', (evt)=>{
    if(!nameCheck){
      alert('이름을 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!mobileCheck){
      alert('휴대전화를 확인하세요.');
      evt.preventDefault();
      return;
    } 
    
  });

}


// 비밀번호 변경 페이지 이동
const moveModifyPassword = () => {
  location.href = fnGetContextPath() + '/modifyPassword';
}
/************************** 함수 호출 **************************/
document.getElementById('modify-password').addEventListener('click', moveModifyPassword);
fnAddEmployee();
document.getElementById('move-before').addEventListener('click', ()=>{
  window.history.back();
})
