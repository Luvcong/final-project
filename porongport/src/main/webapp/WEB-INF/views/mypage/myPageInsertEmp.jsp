<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입사자 등록</title>
    <!-- 마이페이지 스타일 -->
    <link rel="stylesheet" href="../resources/css/mypage.css">
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	    <div id="empInsertForm">
	        <form action="insert.emp" method="post">
	
	            <fieldset>입사자 등록</fieldset>
	
	            <div id="form_wrap">
	                <div class="form-group">
	                    <label for="empName">이름</label>
	                    <input type="text" id="empName" name="empName" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="empNo">아이디</label>
	                    <input type="text" id="empNo" name="empNo" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="empPwd">비밀번호</label>
	                    <input type="password" id="empPwd" name="empPwd" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="deptCode">부서</label>
	                    <input type="text" id="deptCode" name="deptCode" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="jobCode">직급</label>
	                    <input type="text" id="jobCode" name="jobCode" required class="form-control" />
	                </div>
	
	                <div class="btn_area">
	                    <button type="reset" class="btn">취소</button>
	                    <button type="submit" class="btn btn-primary">확인</button>
	                </div>
	            </div>
	        </form>
	    </div>
	</div>
</body>
</html>