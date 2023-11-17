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
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	    <div id="empInsertForm">
	        <form action="insert.emp" method="post">
	
	            <fieldset>입사자 등록</fieldset>
	
	            <div id="form_wrap">
	                <div class="form-group">
	                    <label for="userName">이름</label>
	                    <input type="text" id="empName" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="userId">아이디</label>
	                    <input type="text" id="empNo" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="userPwd">비밀번호</label>
	                    <input type="password" id="empPwd" required class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="dept">부서</label>
	                    <input type="text" id="deptCode" class="form-control" />
	                </div>
	                <div class="form-group">
	                    <label for="job">직급</label>
	                    <input type="text" id="jobCode" class="form-control" />
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