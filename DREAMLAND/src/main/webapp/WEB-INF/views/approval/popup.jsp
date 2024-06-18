<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.employeeDto }" />
      <!DOCTYPE html>
        <html lang="ko">
        <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.min.css" crossorigin />

  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="/resources/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="/resources/assets/css/main.css" />
  <link rel="stylesheet" href="/resources/assets/css/apv.css" />


  <!-- Vendors CSS -->
  <link rel="stylesheet" href="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <link rel="stylesheet" href="/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

  <link rel="icon" href="/resources/assets/img/logo/favicon.ico">
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/themes/default/style.min.css" integrity="sha512-A5OJVuNqxRragmJeYTW19bnw9M2WyxoshScX/rGTgZYj5hRXuqwZ+1AVn2d6wYTZPzPXxDeAGlae0XwTQdXjQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js" integrity="sha256-J8ay84czFazJ9wcTuSDLpPmwpMXOm573OUtZHPQqpEU=" crossorigin="anonymous"></script>
  <!-- Helpers -->
  <script src="/resources/assets/vendor/js/helpers.js"></script>

  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="/resources/assets/js/config.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/jstree.min.js" integrity="sha512-ekwRoEshEqHU64D4luhOv/WNmhml94P8X5LnZd9FNOiOfSKgkY12cDFz3ZC6Ws+7wjMPQ4bPf94d+zZ3cOjlig==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        
            <meta charset="UTF-8">
            <title>반려 사유</title>
        </head>
        <body>
            <form id="popupForm">
                <div>
                       <h2 class="text-nowrap mb-2 text-primary" style="margin-left:200px">반려사유</h2>
                <textarea id="rejectedReason" name="rejectedReason"  style="width:500px; height:300px"required></textarea><br>
                <button  class="btn btn-primary justify-content-sm-center" style="margin-left:415px" type="submit">확인</button></div>
            </form>
            <script>
                document.getElementById('popupForm').addEventListener('submit', function(event) {
                    event.preventDefault();
                    const inputText = document.getElementById('rejectedReason').value;
                    window.opener.handlePopupFormSubmission(inputText);
                    window.close();
                });
            </script>
        </body>
        </html>