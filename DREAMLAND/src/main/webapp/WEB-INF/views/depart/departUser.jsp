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

OrgChart.templates.myTemplate = Object.assign({}, OrgChart.templates.ana);
OrgChart.templates.myTemplate.size = [140, 60];
OrgChart.templates.myTemplate.node = '<rect x="0" y="0" height="60" width="140" fill="#90B54C" stroke-width="1" stroke="#fff" rx="5" ry="5"></rect>';
OrgChart.templates.myTemplate.field_0 = '<text data-width="140" class="field_0" style="font-size: 18px;" fill="#fff" x="71" y="34" text-anchor="middle">{val}</text>';
OrgChart.templates.myTemplate.plus = '<circle cx="15" cy="15" r="12" fill="#fff" stroke="#90B54C" stroke-width="1"></circle>'
    + '<line x1="10" y1="15" x2="20" y2="15" stroke-width="1" stroke="#444"></line>'
    + '<line x1="15" y1="10" x2="15" y2="20" stroke-width="1" stroke="#444"></line>';
OrgChart.templates.myTemplate.minus = '<circle cx="15" cy="15" r="12" fill="#fff" stroke="#90B54C" stroke-width="1"></circle>'
    + '<line x1="10" y1="15" x2="20" y2="15" stroke-width="1" stroke="#444"></line>';
OrgChart.templates.myTemplate.link =
    '<path stroke-linejoin="round" stroke="#afafaf" stroke-width="2px" fill="none" d="M{xa},{ya} {xb},{yb} {xc},{yc} L{xd},{yd}" />';

OrgChart.templates.employees = Object.assign({}, OrgChart.templates.myTemplate);
OrgChart.templates.employees.node = '<rect x="0" y="0" height="60" width="140" fill="#fff" stroke-width="2" stroke="#90B54C" rx="5" ry="5"></rect>';
OrgChart.templates.employees.field_0 = '<text data-width="140" class="field_0" style="font-size: 18px;" fill="#444" x="71" y="34" text-anchor="middle">{val}</text>';

var orgChartData = JSON.parse('<c:out value="${orgChartData}" escapeXml="false"/>');

	console.log(orgChartData);
	
	var chart = new OrgChart(document.getElementById('tree'), {
	  template: 'myTemplate',    
	  mouseScroll: OrgChart.none,
	  layout: OrgChart.mixed,
	  enableSearch: false,
	  enableDragDrop: false,
	  nodeBinding: {
	    field_0: 'name',
	  },
	  tags: {
		  employees: {
			  template: "employees"
		  },
	  },
	  nodes: orgChartData
	});

	chart.load(orgChartData); 
	
</script>

<%@ include file="../layout/footer.jsp" %>    