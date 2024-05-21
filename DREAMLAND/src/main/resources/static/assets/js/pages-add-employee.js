/**
 * 직원등록 인사관리 - 직원등록
 */

'use strict';

document.addEventListener('DOMContentLoaded', function (e) {
  (function () {
    const deactivateAcc = document.querySelector('#formAccountDeactivation');

    // Update/reset user image of account page
    let accountUserImage = document.getElementById('uploadedAvatar');
    const fileInput = document.querySelector('.account-file-input'),
      resetFileInput = document.querySelector('.account-image-reset');

    if (accountUserImage) {
      const resetImage = accountUserImage.src;
      fileInput.onchange = () => {
        if (fileInput.files[0]) {
          console.log(fileInput.files[0]);
          accountUserImage.src = window.URL.createObjectURL(fileInput.files[0]);
        }
      };
      resetFileInput.onclick = () => {
        fileInput.value = '';
        accountUserImage.src = resetImage;
      };
    }

  })();
});

let beforeBirth = document.getElementById('birth').value;

const fnGetPassword = () => {
  let currentBirth = document.getElementById('birth').value;
  
  if(beforeBirth !== currentBirth){
    const [year, month, day] = currentBirth.split('-');
    const shortYear = year.slice(2);
    const shortMonth = month.padStart(2, '0');
    const shortDay = day.padStart(2, '0');
    
    let password = shortYear + shortMonth + shortDay;
    //console.log(password); 
    document.getElementById('empPw').value = password;
  }
}

document.getElementById('birth').addEventListener('blur', fnGetPassword);

