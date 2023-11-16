<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <div class="wrap">
        <header>
            <div id="today"></div>
        </header>
        <script>
            window.onload = () => {
                let now = new Date();
                var today = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate()
                          + ' ' + now.getHours() + ':' + now.getMinutes();
                console.log(today);

                document.querySelector('#today').innerText = today;

            }
        </script>

        <div id="left">
            <div class="logo">
                <img src="logo.png" alt="포롱포트 로고">
            </div>
        </div>

        <div id="right">
            <div id="login_form">
                <form action="login.em" method="post">
                    <div class="login_id">
                        <span class="icon"><i class="fa-solid fa-user fa-xl"></i></span>
                        <input type="text" id="userId" class="form-control" />
                    </div>
                    <div class="login_pwd">
                        <span class="icon"><i class="fa-solid fa-key fa-xl"></i></span>
                        <input type="text" id="userPwd" class="form-control" />
                    </div>

                    <button type="submit" id="login_btn">login</button>
                </form>
            </div>
            <a href="">비밀번호 찾기</a>
        </div>

    </div>
</body>
</html>