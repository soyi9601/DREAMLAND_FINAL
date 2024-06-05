<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- =========================================================
* Sneat - Bootstrap 5 HTML Admin Template - Pro | v1.0.0
==============================================================

* Product Page: https://themeselection.com/products/sneat-bootstrap-html-admin-template/
* Created by: ThemeSelection
* License: You must have a valid license purchased in order to legally use the theme for your project.
* Copyright ThemeSelection (https://themeselection.com)

=========================================================
 -->
<!-- beautify ignore:start -->
<html
  lang="en"
  class="light-style customizer-hide"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../assets/"
  data-template="vertical-menu-template-free"
>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>DREAM LAND - 로그인</title>

    <meta name="description" content="" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="../assets/vendor/css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
  </head>

  <body>
    <!-- Content -->

    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <!-- Register -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                <a href="${contextPath}/" class="app-brand-link gap-2">
                  <span class="app-brand-text demo text-body fw-bolder">
                    <img
                    src="../assets/img/logo/logo1.png"
                    alt="user-avatar"
                    width="350px"
                    class="d-block rounded"
                    id="uploadedAvatar"
                   /></span>
                </a>
              </div>
              <!-- /Logo -->
              <form id="formAuthentication" class="mb-3" action="/login" method="POST">
                <div class="mb-3">
                  <label for="username" class="form-label">이메일</label>
                  <input
                    type="text"
                    class="form-control"
                    id="username"
                    name="username"
                    placeholder="example@dreamland.com"
                    autofocus
                  />
                  <div class="mb-3" id="email-result"></div>
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">비밀번호</label>
                    <a href="/login/tempPassword">
                      <small>임시 비밀번호 발급하기</small>
                    </a>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="password"
                      class="form-control"
                      name="password"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password"
                      maxlength="30"
                    />
                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                </div>
                <div class="mb-3">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="remember-me" />
                    <label class="form-check-label" for="remember-me"> 아이디 저장 </label>
                  </div>
                </div>
                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" type="submit">로그인</button>
                </div>
              </form>
              <p class="login-result">
              </p>
            </div>
          </div>
          <!-- /Register -->
        </div>
      </div>
    </div>

    <!-- / Content -->

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../assets/vendor/libs/popper/popper.js"></script>
    <script src="../assets/vendor/js/bootstrap.js"></script>
    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="../assets/js/main.js"></script>

    <!-- Page JS -->
    <script>
    /**
     * 작성자 : 고은정
     * 기능   : 로그인
     * 이력   :
     *    1) 240524 - 로그인 이메일 체크 함수 추가
     */
    
    
    // 로그인 submit 후 에러메시지 출력
    function getErrorMessageFromURL() {
      const urlParams = new URLSearchParams(window.location.search);
      return urlParams.get('exception');
    }

    // 페이지가 로드될 때 실행
    document.addEventListener('DOMContentLoaded', function() {
      const errorMessage = getErrorMessageFromURL();
      if (errorMessage) {
        // 오류 메시지를 출력할 요소를 찾아서 오류 메시지를 삽입
        const loginResultElement = document.querySelector('.login-result');
        if (loginResultElement) {
          loginResultElement.textContent = errorMessage;
        }
      }
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
    
    document.getElementById('username').addEventListener('blur', fnEmailCheck);
    
    </script>
    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>