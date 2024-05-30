<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="content-wrapper">

<h2>Department List</h2>
    <table border="1">
        <tr>
            <th>Department Name</th>
            <th>Employee Name</th>
        </tr>
        <c:forEach var="department" items="${departUser}">
            <tr>
                <td>${department.deptName}</td>
                <td>
                    <c:forEach var="employee" items="${department.employees}">
                        ${employee.empName}<br/>
                    </c:forEach>
                </td>
            </tr>
        </c:forEach>
    </table>


<%@ include file="../layout/footer.jsp" %>    