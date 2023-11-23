<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 메시지함</title>
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				메시지 상세보기
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="l-messageBtn">
				<i class="fa-regular fa-circle-left fa-2xl" id="backIcon" onclick="historyBack()"></i>
			</div>
			
			<div class="r-messageBtn">
				<button class="btn btn-sm btn-outline-primary">답장</button>
				<button class="btn btn-sm btn-outline-primary">보관</button>
			</div>
      	</div>	<!-- toolbar  -->
      	
      	<div class="detailContent">
      		<table class="table table-sm rounded-3">
      			<tr>
      				<th width="100px">수신날짜</th>
      				<td><input class="form-control form-control-sm detail-input" readonly value="${ list.createDate }"></td>
      			</tr>
      			<tr>
      				<th>보낸사람</th>
      				<td><img id="profile-message" src="resources/images/20231106.png"  alt="프로필사진">
      				<input class="form-control form-control-sm detail-input" readonly value="${ list.empName } ${ list.jobName } / ${ list.deptName }"></td>
      			</tr>
      			<tr>
      				<th>첨부파일</th>
      				<td><input class="form-control form-control-sm detail-input" readonly value="첨부파일"></td>
      			</tr>
      			<tr>
      				<th>메시지내용</th>
      				<td><textarea id="messageTextarea" class="form-control form-control-sm detail-input" rows="3" readonly>${ list.messageContent }</textarea></td>
      			</tr>
      		</table>
      	</div>
		
	</div>	<!-- pp-content  -->
	
	<script>
	function historyBack(){
		
		document.getElementById("backIcon").addEventListener("click", () => {
			  history.back();
		});
	}	// historyBack
		
		
	</script>

</body>
</html>