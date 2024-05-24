/**
 * Account Settings - Account
 */

'use strict';

document.addEventListener('DOMContentLoaded', function (e) {
  (function () {
    const deactivateAcc = document.querySelector('#formAccountDeactivation');

    // 직원 사진
    let accountUserImage = document.getElementById('uploadedAvatar');
    const fileInput = document.querySelector('.account-file-input'),
      resetFileInput = document.querySelector('.account-image-reset');
      
    // 전자 서명
    let accountSignImage = document.getElementById('uploadSign');
    const signInput = document.querySelector('.account-sign-input'),
      resetSignInput = document.querySelector('.account-sign-reset');

    if (accountUserImage && accountSignImage) {
      const resetImage = accountUserImage.src;
      const resetSign = accountSignImage.src;
      
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
      
      // 서명 등록
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
      };
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
