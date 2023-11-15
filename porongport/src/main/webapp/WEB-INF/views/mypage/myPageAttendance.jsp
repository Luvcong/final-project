<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>근태 관리</title>
    <!-- 마이페이지 스타일 -->
    <link rel="stylesheet" href="../resources/css/mypage.css">
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	
	    <div class="outer">
	
	        <div class="content_top">
	            <div class="top_box">
	                <div class="profile">
	                    <img src="profile.png"  alt="입사자 사진">
	                    <div class="info">
	                        <h3>홍길동</h3><span>팀장</span>
	                        <h5>인사관리팀</h5>
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