<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <!-- CSS -->
    <link rel="stylesheet" href="../resources/css/findPwd.css">
     <!--bootstrap-->
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
    <div id="findPwd_area">

        <form action="" method="post">
            <fieldset>비밀번호 찾기</fieldset>

            <div class="form_wrap">
                <div class="form-group">
                    <label for="userName">이름</label>
                    <input type="text" id="userName" required class="form-control" />
                </div>
                <div class="form-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" required class="form-control" />
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <div class="email_box">
                        <input type="text" id="email" required class="form-control" />
                        <button type="button" class="btn btn-info" id="cert_btn">인증번호</button>
                    </div>
                </div>
                <div class="btn_area">
                    <button type="reset" class="btn">취소</button>
                    <button type="submit" class="btn btn-primary">확인</button>
                </div>
            </div>

        </form>

    </div>
</body>
</html>