<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 쪽지함</title>
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				받은 쪽지함
			</div>
		</div>	<!-- header  -->
		
        <div class="searchTable">
	      	<table id="check-table">
	      		<tr>
		            <td>
	     			    <select name="searchDrop">
							<option value="all">전체</option>
							<option value="userName">발신자</option>
							<option value="messageContent">내용</option>
						</select>
	     			</td>
	      			<td>
	      				<input class="form-control form-control-sm" name="serarchMessageReceived" type="text" placeholder="검색어를 입력하세요" size="30">
	   				</td>
					<td>
	      				<button onclick="searchMessage()" class="btn btn-sm btn-warning">검색</button>
	   				</td>
	      		</tr>
	      	</table>
      	</div>	<!-- searchTable  -->
		
		<div class="receivedBtn">
			<button>보관</button>
			<button>삭제</button>
		</div>
		
		<span>총 ${ pi.listCount }개</span>
		
		<div class="tableBody">
			<table id='tb-received' class="table table-sm table-hover">
			<thead>
				<tr>
					<th><input type="checkbox" /></th>
					<th></th>
					<th>발신자</th>
					<th>내용</th>
					<th>받은 시간</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
           	<c:when test="${ empty list }">
   	            <tr>
	            	<td colspan="5">받은 메시지가 없습니다.</td>
                </tr>
           	</c:when>
           	<c:otherwise>
           		<c:forEach var="message" items="${ list }">
           			<tr>
	                    <td><input type="checkbox"></td>
	                    <td><i class="fa-solid fa-envelope"></i></td>
						<td>${ message.empName } ${ message.jobName }</td>
						<td>${ message.messageContent }</td>
						<td>${ message.createDate }</td>
					</tr>
           		</c:forEach>
           	</c:otherwise>
			</c:choose>
 				<tr>
                    <td><input type="checkbox"></td>
                    <td><i class="fa-solid fa-envelope"></i></td>
					<td>김유저 대리</td>
					<td>비품신청서 결재 완료되었습니다.</td>
					<td>2023-11-07 오전 10:11:30</td>
				</tr>
				<tr>
                    <td><input type="checkbox"></td>
                    <td><i class="fa-solid fa-envelope-open"></i></td>
					<td>이유저 과장</td>
					<td>금일 오후 6시 회의실에서 프로젝트 미팅 있습니다.</td>
					<td>2023-11-06 오후 17:20:50</td>
				</tr>
			</tbody>
			</table>
		</div>	<!-- tableBody  -->
	
	</div>	<!-- pp-content  -->
	

</body>
</html>