<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>근태 관리</title>
    <!-- 마이페이지 스타일 -->
    <link rel="stylesheet" href="resources/css/mypage.css">
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />

	<div class="pp-content">
	
	    <div class="outer">
	
	        <div class="content_top">
	            <div class="top_box">
	                <div class="myProfile">
	                    <img src="resources/images/profile.png"  alt="입사자 사진">
	                    <div class="info">
	                        <h3>${ sessionScope.loginUser.empName }</h3><span>${ sessionScope.loginUser.jobName }</span>
	                        <h5>${ sessionScope.loginUser.deptName }</h5>
	                    </div>
	                </div>
	            
	                <div id="EDMSprogress">
	                    <div id="wating">
	                        <h3>결재대기</h3>
	                        <h3>0</h3>
	                    </div>
	                    <div class="arr">
	                        <span class="arrow-next"></span>
	                    </div>
	                    <div id="ing">
	                        <h3>결재진행</h3>
	                        <h3>0</h3>
	                    </div>
	                    <div class="arr">
	                        <span class="arrow-next"></span>
	                    </div>
	                    <div id="complete">
	                        <h3>완료</h3>
	                        <h3>0</h3>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <div class="content_bottom">
	            <h3>근태관리</h3>
	
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th>날짜</th>
	                        <th>출근기록</th>
	                        <th>퇴근기록</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<tr>
	                		<td id="sysdate"></td>
	                		<td id="workStart">
	                			<button onclick="insertAtt();" id="ws_btn" class="btn btn-primary">출근</button>
	                		</td>
	                		<td id="workEnd">
	                			<button onclick="updateAtt();" id="we_btn" class="btn btn-primary">퇴근</button>
	                		</td>
	                	</tr>
	                	<c:if test="${ not empty attList }">
		                	<c:forEach var="i" items="${ sessionScope.attList }" begin="0" end="2">
			                	<c:if test="${ not empty i.workEnd }">
				                	<tr>
				                		<td>${i.workDate}</td>
				                		<td>${i.workStart}</td>
				                		<td>${i.workEnd}</td>
				                	</tr>
			                	</c:if>
		                	</c:forEach>
	                	</c:if>
	                </tbody>
	            </table>
	        </div>
	    </div>
	</div>
	<script>
	  	let now = new Date();
 		var cTime = now.getHours() + ':' + now.getMinutes();
	 		
 		window.onload = () => {
	  		var today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();
	  		document.querySelector('#sysdate').innerText = today;
	  		
	  		$.ajax({
	  			url : 'checkAtt.em',
	  			data : {empNo : ${sessionScope.loginUser.empNo}},
	  			success : result => {
					$('#ws_btn').remove();
					$('#workStart').text(result.workStart);
					$('#workEnd').text(result.workEnd);
	  				
	  			},
	  			error : () => {
	  				console.log('fail');
	  			}
	  			
	  		})
	  		
 		};
         		
		function insertAtt(){
			$.ajax({
				url : 'insert.at',
				data : {
					workStart : window.cTime, 
					empNo : ${sessionScope.loginUser.empNo}
				},
				success : result => {
					console.log(result);
					$('#ws_btn').remove();
					$('#workStart').text(result.workStart);
					
				},
				error : () => {
					console.log('fail');	
				}
			})
		};
		
		function updateAtt(){
			$.ajax({
				url : 'update.at',
				data : {
					workEnd : window.cTime,
					empNo : ${sessionScope.loginUser.empNo}
				},
				success : result => {
					$('#we_btn').remove();
					$('#workEnd').text(result);
				},
				error : () => {
					console.log('fail');
				}
				
			})
		};
	</script>
</body>
</html>