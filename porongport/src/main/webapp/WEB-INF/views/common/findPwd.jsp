<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <!-- CSS -->
    <link rel="stylesheet" href="resources/css/findPwd.css">
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	    <div id="findPwd_area">
	
	        <form action="findPwd.em" method="post">
	            <fieldset>비밀번호 찾기</fieldset>
	
	            <div class="form_wrap">
	                <div class="form-group">
	                    <label for="empName">이름</label>
	                    <input type="text" id="empName" name="empName" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="empNo">아이디</label>
	                    <input type="text" id="empNo" name="empNo" required class="form-control" maxlength="7" />
	                </div>
	                <div class="form-group">
	                    <label for="empEmail">이메일</label>
	                    <div class="email_box">
	                        <input type="text" id="empEmail" name="empEmail" required class="form-control" />
	                    </div>
	                </div>
	                <div class="btn_area">
	                    <button type="submit" class="btn btn-primary">확인</button>
	                </div>
	            </div>
	
	        </form>
	
	    </div>
    </div>
</body>
</html>