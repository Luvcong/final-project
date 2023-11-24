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
	
	            <form action="update.em" method="post">
	                <div id="updateForm">
	                    <div class="form-group">
	                        <label for="empName">이름</label>
	                        <input type="text" id="empName" name="empName" readonly class="form-control" value="${ loginUser.empName }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="empNo">아이디</label>
	                        <input type="text" id="empNo" name="empNo" readonly class="form-control" value="${ loginUser.empNo }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="empPwd">* 비밀번호</label>
	                        <input type="password" id="empPwd" name="empPwd" class="form-control" />
	                    </div>
	                    <div class="form-group">
	                        <label>* 비밀번호 확인</label>
	                        <input type="password" class="form-control" />
	                    </div>
	                    <div class="form-group">
	                        <label for="empPhone">연락처</label>
	                        <input type="text" id="empPhone" name="empPhone" placeholder="(-)포함 입력" class="form-control" value="${ loginUser.empPhone }" />
	                    </div>
	                    <div class="form-group">
	                        <label for="empEmail">이메일</label>
	                        <input type="email" id="empEmail" name="empEmail" class="form-control" value="${ loginUser.empEmail }"/>
	                    </div>
	                </div>
	
					<!-- 최초 로그인 식별을 위한 데이터 -->
					<input type="hidden" name="firstLogin" value="${ loginUser.firstLogin }" />
	
	                <label>주소</label>
	                <!-- 주소API -->
	                <div id="updateAddrForm">
	                    <div class="post_box">
	                        <input type="text" id="empAddressCode" name="empAddressCode" placeholder="우편번호" class="form-control" value="${ loginUser.empAddressCode }" />
	                        <button type="button" onclick="findAddr();" class="btn btn-info">주소찾기</button>
	                    </div>
	                    <input type="text" id="empAddress" name="empAddress" placeholder="주소" class="form-control" value="${ loginUser.empAddress }" />
	                    <input type="text" id="detailAddress" placeholder="상세주소" class="form-control" />
	                    <input type="text" id="extraAddress" placeholder="참고항목" class="form-control" />
	                </div>
	
	                <div class="btn_area">
	                    <button type="submit" class="btn btn-primary" style="width: 100%">확인</button>
	                </div>
	            </form>
	        </div>
	        <script>
	            function findAddr() {
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
	                            document.getElementById("extraAddress").value = extraAddr;
	                        
	                        } else {
	                            document.getElementById("extraAddress").value = '';
	                        }
	
	                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                        document.getElementById('empAddressCode').value = data.zonecode;
	                        document.getElementById("empAddress").value = addr;
	                        // 커서를 상세주소 필드로 이동한다.
	                        document.getElementById("detailAddress").focus();
	                    }
	                }).open();
	            };
	            
	            /* 아무것도 입력하지 않았을 때에 대한 유효성 검사
	            $(() => {
	            	$('button:submit').on('click', e => {
	            		const $empPwd = $('#empPwd');
	            		const $empPhone = $('#empPhone');
	            		const $empEmail = $('#empEmail');
	            		
	            		if($empPwd && $empPhone && $empEmail){
	            			Swal.fire({
	            				title : '오류',
	            				text : '입력된 정보가 없습니다.',
	            				icon : 'info'
	            			});
	            			console.log('인풋 벨류값이 없음');
	            			console.log($('#empPwd').val());
	            			console.log($('#empPhone').val());
	            			console.log($('#firstLogin').val());
	            			return false;
            			}
	            		else{
	            			return true;
	            		}
	            	})
	            })
	            */
	            
	        </script>
	
	    </div>
	</div>
</body>
</html>