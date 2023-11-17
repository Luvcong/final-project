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
	                        <th width="40">날짜</th>
	                        <th>출근기록</th>
	                        <th>퇴근기록</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>20202</td>
	                        <td>2022</td>
	                        <td>2022</td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	
	    </div>
	</div>
</body>
</html>