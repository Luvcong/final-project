<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>조직도</title>
    <!-- CSS -->
    <link rel="stylesheet" href="../resources/css/jojigdo.css">
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="outer">
        
        <div id="jojigdo">
            <h2>인사부 조직도</h2><span>20명</span>

            <div id="jojigdo_chart">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>직급</th>
                            <th>이름</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>과장</td>
                            <td>홍길동</td>
                        </tr>
                        <tr>
                            <td>대리</td>
                            <td>홍길동</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Trigger the modal with a button -->
        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h3>부서추가</h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="deptName">부서이름</label>
                            <input type="text" id="deptName" required class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="deptCode">부서코드</label>
                            <input type="text" id="deptCode" required class="form-control" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn" id="modal_close_btn" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary" >등록</button>
                    </div>
                </div>

            </div>
        </div>
        <script>
            $.ajax({
                url : 'insert.de',
                data: {
                    deptName : $('#deptName').val(),
                    deptCode : $('#deptCode').val()
                },
                success : result => {
                    console.log(result);
                },
                error : () => {
                    console.log('fail');
                }
            })
        </script>

    </div>
</body>
</html>