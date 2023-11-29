<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약현황</title>
</head>
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- css-->
	<link rel="stylesheet" href="resources/css/reservationStatus.css">
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	<div class="pp-content">
	<br>
	<h1 class="reservationTableSize">예약 현황</h1>
	<br><br>
	
	<div class="reservationTableSize">
		<table class="table table-border" id="reservationTable">
		<thead>
			<tr>
				<th>No.</th>
				<th>시작</th>
				<th>종료</th>
				<th>부서</th>
				<th>성명/직급</th>
				<th>인원수</th>
				<th>승인결과</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="m">
               	<tr>
               		<td class="mno">${m.meetNo}</td>
               		<td>${m.meetStart}</td>
               		<td>${m.meetEnd}</td>
               		<td>${m.deptName}</td>
               		<td>${m.empName}/${m.jobName}</td>
               		<td>${m.meetPnum}</td>
               		<td>${m.meetApproval}</td>
               		<td class="tdborder" style="border:none;"><button class="btn btn-danger">-</button></td>
               	</tr>
			</c:forEach>
		</tbody>
		</table>
		
		
		<div class="reservation-footer-paging">
		<script>
            	$(function(){
                	$('#reservationTable>tbody>tr').click(function(){
                    	location.href="detailReservation?mno="+$(this).children('.mno').text();
                	});
               })
            </script>
			
            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="reservationStatus?cPage=${pi.currentPage-1}">Previous</a></li>
                    	</c:otherwise>
                    </c:choose>
                    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var ="p">
                    	<li class="page-item"><a class="page-link" href="reservationStatus?cPage=${p}">${p}</a></li>
                    </c:forEach>
                    <c:choose>
                    	<c:when test="${pi.endPage eq pi.maxPage}">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="reservationStatus?cPage=${pi.currentPage+11}">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>
		</div>
	
	</div>
	
	</div>
	
</body>
</html>