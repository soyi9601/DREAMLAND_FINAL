<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://balkan.app/js/OrgChart.js"></script>

<style>
#tree {
    width: 100%;
    height: 100%;
    background: #f3f3f3;
}
</style>
<div class="content-wrapper">

  <div id="tree"></div>


<script>
var orgChartData = JSON.parse('<c:out value="${orgChartData}" escapeXml="false"/>');
</script>
<script src="../assets/js/pages-depart-user.js"></script>
<%@ include file="../layout/footer.jsp" %>    