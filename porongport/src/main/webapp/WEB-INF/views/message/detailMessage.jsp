<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 메시지함</title>
    <!-- 메인화면 css-->
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				메시지 상세보기
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="l-messageBtn">
				<i class="fa-regular fa-circle-left fa-2xl" id="backIcon" onclick="historyBack()"></i>
			</div>
			
			<div class="r-messageBtn">
				<button class="btn btn-sm btn-outline-primary" onclick="messageForm()">답장</button>
				<button class="btn btn-sm btn-outline-primary" onclick="storageMessage()">보관</button>
			</div>
      	</div>	<!-- toolbar  -->
      	
      	<div class="detailContent">
      		<table class="table table-sm rounded-3">
      			<tr>
      				<th width="100px">수신날짜</th>
      				<td><input class="form-control form-control-sm detail-input" readonly value="${ list.createDate }"></td>
      			</tr>
      			<tr class='tr-sender'>
      				<th>보낸사람</th>
      				<td>
      					<img id="profile-message" src="resources/images/20231106.png"  alt="프로필사진">
      					<input class="form-control form-control-sm detail-input" readonly value="${ list.empName } ${ list.jobName } / ${ list.deptName }">
      				</td>
      			</tr>
      			<tr>
      				<th>첨부파일</th>
      				<c:choose>
      					<c:when test="${ empty list.originFileName }">
      						<td><input class="form-control form-control-sm detail-input" readonly placeholder="첨부파일이 존재하지 않습니다."></td>
      					</c:when>
      					<c:otherwise>
		      				<td>
		      				<a class="form-control form-control-sm detail-input upload-name" 
		      				   href="${ list.changeFileName }" download="${ list.originFileName }">
		      				   <i class="fa-regular fa-floppy-disk"></i> ${ list.originFileName }</a>
      					</c:otherwise>
      				</c:choose>
      			</tr>
      			<tr>
      				<th>메시지내용</th>
      				<td><textarea id="messageTextarea" class="form-control form-control-sm detail-input" rows="3" readonly>${ list.messageContent }</textarea></td>
      			</tr>
      		</table>
      	</div>
		
	</div>	<!-- pp-content  -->
	
	<!-- 메시지보내기  modal창 -->
			<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
			<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
		 	<div class="modal" id="messageForm">
				<form method="post" action="insertMessage" enctype="multipart/form-data">
			        <div class="modal-dialog modal-lg">
			            <div class="modal-content">
			                <!-- Modal Header -->
			                <div class="modal-header">
			                    <span class="modal-title">메시지 작성</span>
			                    <button type="button" class="close" data-dismiss="modal" style="padding-top:10px;">&times;</button>	<!-- x 닫기버튼 -->
			                </div> 
			                <!-- Modal body -->
			                <div class="modal-body">
			                <table class="table table-sm">
			                	<tr>
			                		<th>To</th>
			                		<td>
										<select class="select-user select2-container form-control form-control-sm" name="receiveUser" multiple="multiple" style="width: 100%;" >
											<c:forEach var="userList" items="${ userList }">
												<option value="${ userList.empNo }">${ userList.empName } [${ userList.jobName } / ${ userList.deptName }]</option>
											</c:forEach>
										</select>			                		
			                		</td>
			                		
			                		<!-- <td><input class="form-control form-control-sm" type="text" name="receiveUser" placeholder="받는 사람"/></td> -->
			                	</tr>
			                	<tr>
			                		<th>Message</th>
			                		<td><textarea id="messageTextarea" class="form-control form-control-sm" rows="3" name="messageContent" placeholder="메시지 내용을 입력하세요"></textarea></td>
			                	</tr>
			                	<tr>
			                		<th>From</th>
			                		<td>
			                		<input hidden type="text" name="sendUser" value="${ loginUser.empNo }" />
			                		<input class="form-control form-control-sm" type="text" placeholder="${ loginUser.empName } ${ loginUser.jobName } / ${ loginUser.deptName}" readonly/></td>
			                	</tr>
			                	<tr>
			                		<th>첨부파일</th>
			                		<td class="filebox">
				                		<input class="upload-name form-control form-control-sm" placeholder="첨부파일" readonly>
			                		    <label for="file">파일찾기</label> 
										<input type="file" id="file" name="upfile">
			                		</td>
			                	</tr>
			                	<tr>
							        <div class="writeCount">
							        	<span id="writeCnt">0</span>/<span id="writeMax">1000Byte</span>
							        </div>
			                	</tr>
			                </table>
			                </div>
			                <!-- Modal footer -->
			                <div class="modal-footer">
			             		<button type="submit" class="btn btn-sm btn-primary">전송</button>
			                    <button type="reset" class="btn btn-sm btn-secondary" data-dismiss="modal">취소</button>
			                </div>
			            </div>
			        </div>
			</form>
		  </div>
		  
		  <script>
		  $("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		  });
		  </script>
	
	<script>
	$(function(){
		$('.select-user').select2({
			placeholder: "받는 사람",
			allowClear: true,
				language: {
		       noResults: function() {return "검색결과가 없습니다";}
		   },
		   dropdownCssClass: "text-sm"
		});
	})
	
	
	// ------------------------------------------------------------------
	// 뒤로가기 버튼 클릭 (이전페이지 이동)
	// ------------------------------------------------------------------
	function historyBack(){
		document.getElementById("backIcon").addEventListener("click", () => {
			  location.href = document.referrer;
		});
	}	// historyBack
	
	
	// ------------------------------------------------------------------
	// 메시지 작성 modal창 실행
	// ------------------------------------------------------------------
	function messageForm(){
		$('#messageForm').modal('show');
	}	// messageForm
	
	
	</script>
</body>
</html>