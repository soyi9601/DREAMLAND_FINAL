<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />

<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

  <title>DREAMLAND</title>
  <!-- Fonts -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.min.css" crossorigin />

  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="/resources/assets/css/demo.css" />
  <link rel="stylesheet" href="/resources/assets/css/main.css" />

  <!-- Vendors CSS -->
  <link rel="stylesheet" href="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <link rel="stylesheet" href="/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

  <link rel="icon" href="/resources/assets/img/logo/favicon.ico">

  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <!-- Helpers -->
  <script src="/resources/assets/vendor/js/helpers.js"></script>

  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="/resources/assets/js/config.js"></script>

</head>

<body>
  <!-- Layout wrapper -->
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <!-- Menu -->

      <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
        <div class="app-brand demo">
          <a href="${contextPath}/" class="app-brand-link">
            <span class="app-brand-logo demo"></span>
            <span class="app-brand-text demo menu-text fw-bolder ms-2">DreamLand</span>
          </a>

          <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
            <i class="bx bx-chevron-left bx-sm align-middle"></i>
          </a>
        </div>

        <div class="menu-inner-shadow"></div>

        <ul class="menu-inner py-1">
          <!-- Layouts -->
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>인사관리</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>직원등록</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>부서등록</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>조직도-관리자</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>조직도-유저</div>
                </a>
              </li>
            </ul>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>게시판</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>FAQ</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>공지사항</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>익명게시판</div>
                </a>
              </li>
            </ul>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>쪽지함</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>받은쪽지함</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>보낸쪽지함</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>중요보관함</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/employee/add" class="menu-link">
                  <div>휴지통</div>
                </a>
              </li>
            </ul>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>매출</div>
            </a>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>시설</div>
            </a>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>일정</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/schedule/calendar.do" class="menu-link">
                  <div>캘린더</div>
                </a>
              </li>
            </ul>
          </li>
          <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-layout"></i>
              <div>근태</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/work/status.do" class="menu-link">
                  <div>근태관리</div>
                </a>
              </li>
              <li class="menu-item">
                <a href="${contextPath}/dayoff/info.do" class="menu-link">
                  <div>휴가관리</div>
                </a>
              </li>
            </ul>
          </li>
          <!-- User interface -->
          <li class="menu-item">
            <a href="javascript:void(0)" class="menu-link menu-toggle">
              <i class="menu-icon tf-icons bx bx-box"></i>
              <div>결재</div>
            </a>
            <ul class="menu-sub">
              <li class="menu-item">
                <a href="${contextPath}/approval/appWrite?apvNo=000" class="menu-link">
                  <div>기안서 작성</div>
                </a>
                <a href="${contextPath}/approval/appList" class="menu-link">
                  <div>결재 문서</div>
                </a>
                <a href="${contextPath}/approval/appReferList" class="menu-link">
                  <div>참조 문서</div>
                </a>
                <a href="${contextPath}/approval/appMyList" class="menu-link">
                  <div>내 문서</div>
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
              <!-- <li class="nav-item lh-1 me-3">
                <a>알림</a>
              </li> -->
              
              <!-- User -->
              <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                  <div class="avatar">
                    <div class="avatar avatar-online">
                      <c:choose>
                        <c:when test="${loginEmployee.profilePath != null}">
                          <img src="${loginEmployee.profilePath}" alt class="w-px-40 h-auto rounded-circle" />
                        </c:when>
                        <c:otherwise>
                          <img src="../assets/img/user-solid.png"  alt class="w-px-40 h-auto rounded-circle" />
                        </c:otherwise>
                      </c:choose>
                    </div>                    
                  </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li>
                    <a class="dropdown-item" href="#">
                      <div class="d-flex">
                        <div class="flex-shrink-0 me-3">
                          <div class="avatar avatar-online">
			                      <c:choose>
			                        <c:when test="${loginEmployee.profilePath != null}">
			                          <img src="${loginEmployee.profilePath}" alt class="w-px-40 h-auto rounded-circle" />
			                        </c:when>
			                        <c:otherwise>
			                          <img src="../assets/img/user-solid.png"  alt class="w-px-40 h-auto rounded-circle" />
			                        </c:otherwise>
			                      </c:choose>
                          </div>
                        </div>
                        <div class="flex-grow-1">
                          <span class="fw-semibold d-block">${loginEmployee.empName}</span>
                          <small class="text-muted">${loginEmployee.posName}</small>
                        </div>
                      </div>
                    </a>
                  </li>
                  <li>
                    <div class="dropdown-divider"></div>
                  </li>
                  <li>
                    <a class="dropdown-item" href="${contextPath}/user/mypage">
                      <i class="bx bx-user me-2"></i>
                      <span class="align-middle">마이페이지</span>
                    </a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="${contextPath}/user/receiveBox?empNo=${loginEmployee.empNo}">
                      <i class="bx bx-cog me-2"></i>
                      <span class="align-middle">받은쪽지함</span>
                    </a>
                  </li>
                  <li>
                    <div class="dropdown-divider"></div>
                  </li>
                  <li>
                    <a class="dropdown-item" href="/logout">
                      <i class="bx bx-power-off me-2"></i>
                      <span class="align-middle">로그아웃</span>
                    </a>
                  </li>
                </ul>
              </li>
              <!--/ User -->
            </ul>
          </div>
        </nav>
        <!-- / Navbar -->
