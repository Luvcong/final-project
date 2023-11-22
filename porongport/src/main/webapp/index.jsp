<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포롱포트</title>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- 폰트어썸 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- css -->
    <link rel="stylesheet" href="resources/css/index.css">
</head>
<body>
	<!-- 로그인 실패 alert -->
	<c:if test="${ not empty errorMsg }">
		<script>
			alert('${ errorMsg }');
			location.href = '${ path }';
		</script>
	</c:if>

    <div class="wrap">
    	<!-- 현재 시간 띄워주기 -->
        <header>
            <div id="today"></div>
        </header>
        <script>
            window.onload = () => {
                let now = new Date();
                var today = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate()
                          + ' ' + now.getHours() + ':' + now.getMinutes().toString().padStart(2, '0');

                document.querySelector('#today').innerText = today;
            }
        </script>
		
		<!-- 로고플레이 -->
        <div id="left">
            <div class="logo">
                <img src="resources/images/logo.png" alt="포롱포트 로고">
            </div>
        </div>

		<!-- 로그인 창 -->
        <div id="right">
            <div id="login_form">
                <form action="login.em" method="post">
                    <div class="login_id">
                        <span class="icon"><i class="fa-solid fa-user fa-xl"></i></span>
                        <input type="text" name="empNo" class="form-control" required />
                    </div>
                    <div class="login_pwd">
                        <span class="icon"><i class="fa-solid fa-key fa-xl"></i></span>
                        <input type="password" name="empPwd" class="form-control" required />
                    </div>
					
                    <button type="submit" id="login_btn">login</button>
                </form>
            </div>
            <a href="">비밀번호 찾기</a>
        </div>

    </div>
</body>
</html>