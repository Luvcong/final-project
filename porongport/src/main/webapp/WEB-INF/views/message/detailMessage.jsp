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
				<button class="btn btn-sm btn-outline-primary">목록으로</button>
			</div>
			
			<div class="r-messageBtn">
				<button class="btn btn-sm btn-outline-primary">답장</button>
				<button class="btn btn-sm btn-outline-primary">보관</button>
			</div>
      	</div>	<!-- toolbar  -->
      	
      	<div class="detailContent">
      		<div>수신날짜 <span>2023-11-02 오후 15:24:21</span></div>
      		<div>프로필사진 <span>김진희대리 / 개발팀</span></div>
      		<div>
      			<div>
	      			메시지내용 어쩌구 저쩌구
      			</div>
   			</div>
      	
<!--       		<table class="table table-sm shadow rounded-3">
      			<tr>
      				<th>수신날짜</th>
      				<td>2023-11-02 오후 15:24:21</td>
      			</tr>
      			<tr>
      				<th>프로필사진</th>
      				<td>김진희대리 / 개발팀<td>
      			</tr>
      			<tr>
      				<th></th>
      				<td>
      				<span>
      				안녕하세요
					박유저 팀장입니다.
					
					박유저드림
      				</span>
      				</td>
      				
      			</tr>
      				
      		</table> -->
      	</div>
		
	</div>	<!-- pp-content  -->

</body>
</html>