<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	            <form action="update.em" method="post" enctype="multipart/form-data" id="emp_update">
	            
		            <div class="myProfile">
		            	<c:choose>
		            		<c:when test="${ empty profile.fileNo }">
				                <div class="img_box">
					                <img src="resources/images/profile.png" alt="기본 프로필 사진" id="preview">
					                <label for="profile"></label>
				                	<input type="file" id="profile" name="upfile" accept="image/*" />
				                </div>
		            		</c:when>
		            		<c:otherwise>
		            			<div class="img_box">
			            			<img src="resources/upProfiles/${ profile.changeFileName }" alt="입사자 사진" id="preview">
					                <label for="profile"></label>
					                <input type="file" id="profile" name="reUpfile" accept="image/*" />
					                <input type="hidden" name="changeFileName" value="${ profile.changeFileName }" />
		            			</div>
		            		</c:otherwise>
		            	</c:choose>
		            	
		                <div class="info">
		                    <h3>${ loginUser.empName }</h3><span>${ loginUser.jobName }</span>
		                    <h5>${ loginUser.deptName }</h5>
		                </div>
		            </div>
	
	                <div class="updateForm">
	                    <div class="form-group">
	                        <label for="empName">이름</label>
	                        <input type="text" id="empName" name="empName" readonly class="form-control" value="${ loginUser.empName }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="empNo">아이디</label>
	                        <input type="text" id="empNo" name="empNo" readonly class="form-control" value="${ loginUser.empNo }"/>
	                    </div>
	                    <div class="form-group">
	                        <label for="empPwd">비밀번호</label>
	                        <input type="password" id="empPwd" name="empPwd" class="form-control" />
	                    </div>
	                    <div class="form-group">
	                        <label>비밀번호 확인</label>
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
	                    <button type="submit" class="btn btn-primary" disabled id="form_btn">확인</button>
	                </div>
	            </form>
	        </div>
	        <script>
	            function findAddr() {
	                new daum.Postcode({
	                    oncomplete: function(data) {
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
	            
	        	$(() => {
	        		// 정보 변경이 감지
	        		$('#emp_update input').change(() => {
	        			$('.btn_area>button').attr('disabled', false);
	        		});
	        		
	        		// 프로필 사진 변경
					$('.img_box>img').on('click', () => {
						$('.myProfile input[type=file]').click();
					});
	        		
	        		// 프로필 프리뷰
					$("#profile").on('change', e => {
						const file = e.target.files;
						
						let reader = new FileReader();
				        reader.readAsDataURL(file[0]);

				        reader.onload = () => {
				        	$("#preview").attr('src', reader.result);
				        };

					});
	        	});
	        
	        </script>
	
	    </div>
	</div>
</body>
</html>