<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://balkan.app/js/OrgChart.js"></script>
<link rel="stylesheet" href="/resources/assets/css/depart.css" />

<div class="content-wrapper">

  <div id="tree"></div>


<script>
var orgChartData = JSON.parse('<c:out value="${orgChartData}" escapeXml="false"/>');
</script>
<script src="../assets/js/pages-depart-user.js"></script>
<%@ include file="../layout/footer.jsp" %>    