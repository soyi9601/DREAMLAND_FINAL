<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>DREAMLAND</title>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="/../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="/../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/../assets/css/demo.css" />
    <link rel="stylesheet" href="/../assets/css/index.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="/../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <link rel="stylesheet" href="/../assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="/../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/../assets/js/config.js"></script>
    
    <!-- jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  </head>

  <body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar" >
      <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme" >
          <div class="app-brand demo">
            <a href="index.jsp" class="app-brand-link">
              <span class="app-brand-logo demo"></span>
              <span class="app-brand-text demo menu-text fw-bolder ms-2">DreamLand</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1" >
            <!-- Layouts -->
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-layout"></i>
                <div>근태</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="layouts-without-menu.html" class="menu-link">
                    <div>근태1</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="layouts-without-navbar.html" class="menu-link">
                    <div>근태1</div>
                  </a>
                </li>
              </ul>
            </li>

            <li class="menu-header small text-uppercase">
              <span class="menu-header-text">근태</span>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-dock-top"></i>
                <div>근태1</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="pages-account-settings-account.html" class="menu-link">
                    <div>근태22</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="pages-account-settings-notifications.html" class="menu-link">
                    <div>근태22</div>
                  </a>
                </li>
              </ul>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div>결재</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="auth-login-basic.html" class="menu-link" target="_blank">
                    <div>Login</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="auth-register-basic.html" class="menu-link" target="_blank">
                    <div>Register</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="auth-forgot-password-basic.html" class="menu-link" target="_blank">
                    <div>Forgot Password</div>
                  </a>
                </li>
              </ul>
            </li>
            <li class="menu-item" >
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-cube-alt"></i>
                <div>Misc</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="pages-misc-error.html" class="menu-link">
                    <div>Error</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="pages-misc-under-maintenance.html" class="menu-link">
                    <div>Under Maintenance</div>
                  </a>
                </li>
              </ul>
            </li>
            <!-- Components -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">결재</span></li>
            <!-- Cards -->
            <li class="menu-item">
              <a href="cards-basic.html" class="menu-link">
                <i class="menu-icon tf-icons bx bx-collection"></i>
                <div>결재</div>
              </a>
            </li>
            <!-- User interface -->
            <li class="menu-item">
              <a href="javascript:void(0)" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-box"></i>
                <div>결재</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="ui-accordion.html" class="menu-link">
                    <div>결재</div>
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </aside>
        <!-- / Menu -->
        
         <div class="layout-page">
          <!-- Navbar -->
          <nav class="layout-navbar navbar navbar-expand-xl align-items-center bg-navbar-theme" id="layout-navbar">
            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- 알림 -->
                <li class="nav-item lh-1 me-3">
                  <a>알림</a>
                </li>
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar">
                      <i class="tf-icons bx bxs-user-circle"></i>                      
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="../assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                          </div>
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">John Doe</span>
                            <small class="text-muted">Admin</small>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">My Profile</span>
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <i class="bx bx-cog me-2"></i>
                        <span class="align-middle">Settings</span>
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <span class="d-flex align-items-center align-middle">
                          <i class="flex-shrink-0 bx bx-credit-card me-2"></i>
                          <span class="flex-grow-1 align-middle">Billing</span>
                          <span class="flex-shrink-0 badge badge-center rounded-pill bg-danger w-px-20 h-px-20">4</span>
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="auth-login-basic.html">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>
          <!-- / Navbar -->
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">


        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->

          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
          >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <!-- Search -->
              <div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                  <i class="bx bx-search fs-4 lh-0"></i>
                  <input
                    type="text"
                    class="form-control border-0 shadow-none"
                    placeholder="Search..."
                    aria-label="Search..."
                  />
                </div>
              </div>
              <!-- /Search -->

              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- Place this tag where you want the button to render. -->
                <li class="nav-item lh-1 me-3">
                  <a
                    class="github-button"
                    href="https://github.com/themeselection/sneat-html-admin-template-free"
                    data-icon="octicon-star"
                    data-size="large"
                    data-show-count="true"
                    aria-label="Star themeselection/sneat-html-admin-template-free on GitHub"
                    >Star</a
                  >
                </li>

                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <img src="../assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="../assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                          </div>
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">John Doe</span>
                            <small class="text-muted">Admin</small>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">My Profile</span>
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <i class="bx bx-cog me-2"></i>
                        <span class="align-middle">Settings</span>
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <span class="d-flex align-items-center align-middle">
                          <i class="flex-shrink-0 bx bx-credit-card me-2"></i>
                          <span class="flex-grow-1 align-middle">Billing</span>
                          <span class="flex-shrink-0 badge badge-center rounded-pill bg-danger w-px-20 h-px-20">4</span>
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="auth-login-basic.html">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>

          <!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
              <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">UI elements /</span> Accordion</h4>

              <!-- Accordion -->
              <h5 class="mt-4">Accordion</h5>
              <div class="row">
                <div class="col-md mb-4 mb-md-0">
                  <small class="text-light fw-semibold">Basic Accordion</small>
                  <%
String paramValue = request.getParameter("category");
%>
                  <form method="GET"
                        action="${contextPath}/board/faq/search.do">
                    <div>
                     <% if (paramValue != null && !paramValue.isEmpty()) { %>
            <input type="text" name="category" value="<%= paramValue %>">
        <% } %>
                      <input type="text" name="query">
                      
                      <button type="submit">검색</button>
                    </div>
                  </form>

                  <ul>
                      <li>
                          <!-- 검색 쿼리가 있을 경우 이를 포함 -->
                          <a href="${contextPath}/board/faq/list.do">전체</a>
                      </li>
                      <li>
                          <a href="${contextPath}/board/faq/sort.do?category=1"">1번 카테고리</a>
                      </li>
                      <li>
                          <a href="${contextPath}/board/faq/sort.do?category=2">2번 카테고리</a>
                      </li>
                      
                  </ul>
                  
                  <div class="accordion mt-3" id="accordionExample">
                    
                    <div class="card accordion-item">
                      <h2 class="accordion-header" id="headingTwo">
                        <button
                          type="button"
                          class="accordion-button collapsed"
                          data-bs-toggle="collapse"
                          data-bs-target="#accordionTwo"
                          aria-expanded="false"
                          aria-controls="accordionTwo"
                        >
                          Accordion Item 2
                        </button>
                      </h2>
                      <div
                        id="accordionTwo"
                        class="accordion-collapse collapse"
                        aria-labelledby="headingTwo"
                        data-bs-parent="#accordionExample"
                      >
                        <div class="accordion-body">
                          Dessert ice cream donut oat cake jelly-o pie sugar plum cheesecake. Bear claw dragée oat cake
                          dragée ice cream halvah tootsie roll. Danish cake oat cake pie macaroon tart donut gummies.
                          Jelly beans candy canes carrot cake. Fruitcake chocolate chupa chups.
                        </div>
                      </div>
                    </div>
                    
                    <!--  -->
                    <div class="card accordion-item">
                      <div class="accordion-header sdheader" id="headingTwo">
                        <div class="sdtitle"></div>
                        <div class="sdicon on"></div>
                      </div>
                      <div class="accordion-body">
                          ㄴㅇㅎㄴㅇㅎㄴㅇㅎㄴㅇㅎㄶ
                          
                      </div>
                    </div>
                    <!--  -->
                    <!-- 이거 -->
                    <c:forEach items="${faqBoardList}" var="faq" varStatus="vs">
                      <div class="card accordion-item">
                        <div class="accordion-header faqheader" id="headingTwo">
                          
                          <div class="faqtitle">
                            <span class="faq-category">
                              <c:if test="${faq.category==1}">
                              인사
                              </c:if>
                            </span>
                            <span class="faq-q">Q.</span>
                            ${faq.boardTitle}
                            <span>index : ${beginNo - vs.index}</span>
                            <span>faqNo : ${faq.faqNo}</span>
                          </div>
                          <div class="faqicon on"></div>
                        </div>
                        <div class="accordion-body">
                          <span class="faq-a">A.</span>
                          ${faq.boardContents}
                           
                            <button type="button"  class="btn-edit btn btn-warning btn-sm">편집</button>
                            <button type="button"  class="btn-remove btn btn-danger btn-sm">삭제</button>
                            <input class="faqno" type="hidden" value="${faq.faqNo}" >
                        </div>
                      </div>
                    </c:forEach>
                    <!--  -->
                    
                    <script>
                    
                    // 탭
                    $(".accordion-header").click(function(){
                      if($(this).children('.faqicon').hasClass('on')){
                        $(this).children('.faqicon').removeClass('on');
                        $(this).children('.faqicon').addClass('on1');
                      }else{
                        $(this).children('.faqicon').removeClass('on1');
                        $(this).children('.faqicon').addClass('on');
                      }
                      $(this).siblings('.accordion-body').slideToggle(400);
                    })
                    
                    //var frmBtn = $('#frm-btn');
                    /*
                    const fnEditFaq = () => {
                      $(".btn-edit").on('click', (evt)=>{
                        alert($(evt.target));
                        location.href = '${contextPath}/board/faq/edit.do?faqNo='+$(evt.target).next().val();
                      })
                       
                    }
                    */
                    
                    const fnEditFaq = () => {
                      $(".btn-edit").on('click', (evt) => {
                        //alert('gggg');
                          const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
                          location.href = '${contextPath}/board/faq/edit.do?faqNo=' + faqNo;
                      });
                    }
                    
                    const fnRemoveFaq = () => {
                      $(".btn-remove").on('click', (evt) => {
                        if(confirm('해당 게시글을 삭제할까요?')){
                            const faqNo = $(evt.target).closest('.accordion-item').find('.faqno').val();
                            location.href = '${contextPath}/board/faq/remove.do?faqNo=' + faqNo;
                        }
                      });
                    }
                    
                    const fnAfterModifyFaq = () => {
                      const modifyResult = '${modifyResult}';
                      if(modifyResult !== '') {
                        alert(modifyResult);
                      }
                    }
                    
                    const fnAfterDeleteFaq = () => {
                        const modifyResult = '${removeResult}';
                        if(modifyResult !== '') {
                          alert(modifyResult);
                        }
                      }
                  
                  fnEditFaq();  
                  fnAfterModifyFaq();
                  fnRemoveFaq();    
                  fnAfterDeleteFaq(); 
                  
                 
                    </script>

                    <style>
                    .faqheader{display:flex;justify-content: space-between;align-items:center;    padding: 0.79rem 1.125rem;}
                    
                    .faq-q{font-weight:600; margin-right:10px;color:red;}
                    .faq-a{font-weight:600; margin-right:10px;color:blue;}
                    .faqicon{width: 0.75rem;height: 0.75rem; transition: transform 0.3s ease-in-out;}
                    .faqicon.on{
                      background-repeat: no-repeat;
                      background-size: 0.75rem;
                      background-image: url("data:image/svg+xml,%3Csvg width='12' height='12' viewBox='0 0 12 12' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Cdefs%3E%3Cpath id='a' d='m1.532 12 6.182-6-6.182-6L0 1.487 4.65 6 0 10.513z'/%3E%3C/defs%3E%3Cg transform='translate%282.571%29' fill='none' fill-rule='evenodd'%3E%3Cuse fill='%23435971' xlink:href='%23a'/%3E%3Cuse fill-opacity='.1' fill='%23566a7f' xlink:href='%23a'/%3E%3C/g%3E%3C/svg%3E%0A");
                    }
                    .faqicon.on1{
                      background-repeat: no-repeat;
                      background-size: 0.75rem;
                      background-image: url("data:image/svg+xml,%3Csvg width='12' height='12' viewBox='0 0 12 12' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Cdefs%3E%3Cpath id='a' d='m1.532 12 6.182-6-6.182-6L0 1.487 4.65 6 0 10.513z'/%3E%3C/defs%3E%3Cg transform='translate%282.571%29' fill='none' fill-rule='evenodd'%3E%3Cuse fill='%23435971' xlink:href='%23a'/%3E%3Cuse fill-opacity='.1' fill='%23566a7f' xlink:href='%23a'/%3E%3C/g%3E%3C/svg%3E%0A");
                      transform: rotate(90deg);
                    }
                   
                    .accordion-body{display:none;}
                    </style>
                    
                    
                    
                  </div>
                </div>
               
                </div>
                
                <div><a href="${contextPath}/board/faq/write.page">작성</a></div>
                <div>${paging}</div>
              </div>
              <!--/ Accordion -->
                  
                  
                  
              <!--/ Advance Styling Options -->
            </div>
            
            <!-- / Content -->

            <!-- Footer -->
            <footer class="content-footer footer bg-footer-theme">
              <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                <div class="mb-2 mb-md-0">
                  ©
                  <script>
                    document.write(new Date().getFullYear());
                  </script>
                  , made with ❤️ by
                  <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
                </div>
                <div>
                  <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
                  <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a>

                  <a
                    href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
                    target="_blank"
                    class="footer-link me-4"
                    >Documentation</a
                  >

                  <a
                    href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
                    target="_blank"
                    class="footer-link me-4"
                    >Support</a
                  >
                </div>
              </div>
            </footer>
            <!-- / Footer -->

            <div class="content-backdrop fade"></div>
          </div>
          <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>
    </div>
    <!-- / Layout wrapper -->

    <div class="buy-now">
      <a
        href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/"
        target="_blank"
        class="btn btn-danger btn-buy-now"
        >Upgrade to Pro</a
      >
    </div>

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="/../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="/../assets/vendor/libs/popper/popper.js"></script>
    <!-- js -->
    <script src="/../assets/vendor/js/bootstrap.js"></script> 
    <script src="/../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="/../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="/../assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
