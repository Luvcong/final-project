<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 정보</title>
    <!-- 마이페이지 스타일 -->
    <link rel="stylesheet" href="resources/css/mypage.css">
    <!-- Daum 주소API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
	    <div class="outer">
	
	        <div id="myPage">
	            <div class="myProfile">
	                <img src="resources/images/profile.png"  alt="입사자 사진">
	                <div class="info">
	                    <h3>${ loginUser.empName }</h3><span>${ loginUser.jobName }</span>
	                    <h5>${ loginUser.deptName }</h5>
	                </div>
	            </div>
	
	            <form action="update.emp" method="post">
	                <div id="updateForm">
	                    <div class="form-group">
	                        <label for="userName">이름</label>
	                        <input type="text" id="userName" readonly class="form-control" value="${ loginUser.empName }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="userId">아이디</label>
	                        <input type="text" id="userId" readonly class="form-control" value="${ loginUser.empNo }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="userPwd">* 비밀번호</label>
	                        <input type="password" id="userPwd" class="form-control" required />
	                    </div>
	                    <div class="form-group">
	                        <label for="userPwd">* 비밀번호 확인</label>
	                        <input type="password" class="form-control" required />
	                    </div>
	                    <div class="form-group">
	                        <label for="phone">연락처</label>
	                        <input type="text" id="phone" placeholder="(-)포함 입력" class="form-control" value="${ loginUser.empPhone }" />
	                    </div>
	                    <div class="form-group">
	                        <label for="email">이메일</label>
	                        <input type="email" id="email" class="form-control" value="${ loginUser.empEmail }"/>
	                    </div>
	                </div>
	
	                <label>주소</label>
	                <!-- 주소API -->
	                <div id="updateAddrForm">
	                    <div class="post_box">
	                        <input type="text" id="postNo" placeholder="우편번호" class="form-control" />
	                        <button onclick="findAddr()" class="btn btn-info">주소찾기</button>
	                    </div>
	                    <input type="text" id="address" placeholder="주소" class="form-control" />
	                    <input type="text" id="detailAddress" placeholder="상세주소" class="form-control" />
	                    <input type="text" id="extraAddress" placeholder="참고항목" class="form-control" />
	                </div>
	
	                <div class="btn_area">
	                    <button type="reset" class="btn">취소</button>
	                    <button type="submit" class="btn btn-primary">확인</button>
	                </div>
	            </form>
	        </div>
	        <script>
	            function daumPostAPI() {
	                new daum.Postcode({
	                    oncomplete: function(data) {
	                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                        var addr = ''; // 주소 변수
	                        var extraAddr = ''; // 참고항목 변수
	
	                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                            addr = data.roadAddress;
	                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                            addr = data.jibunAddress;
	                        }
	
	                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                        if(data.userSelectedType === 'R'){
	                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                                extraAddr += data.bname;
	                            }
	                            // 건물명이 있고, 공동주택일 경우 추가한다.
	                            if(data.buildingName !== '' && data.apartment === 'Y'){
	                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                            }
	                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                            if(extraAddr !== ''){
	                                extraAddr = ' (' + extraAddr + ')';
	                            }
	                            // 조합된 참고항목을 해당 필드에 넣는다.
	                            document.getElementById("sample6_extraAddress").value = extraAddr;
	                        
	                        } else {
	                            document.getElementById("sample6_extraAddress").value = '';
	                        }
	
	                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                        document.getElementById('sample6_postcode').value = data.zonecode;
	                        document.getElementById("sample6_address").value = addr;
	                        // 커서를 상세주소 필드로 이동한다.
	                        document.getElementById("sample6_detailAddress").focus();
	                    }
	                }).open();
	            }
	        </script>
	
	    </div>
	</div>
</body>
</html>