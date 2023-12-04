<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 메시지함</title>
    <link rel="stylesheet" href="resources/css/message.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- 메시지 관련 js -->
	<script type="text/javascript" src="resources/js/message/message.js"></script>
</head>
<body>

	<jsp:include page="../common/sidebar.jsp" />
	
	<div class="pp-content">
		<div class="header">
			<div class="h-title">
				보낸 메시지 보관함 <i class="fa-solid fa-comments"></i>
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
			<div class="messageBtn">
				<button class="btn btn-sm btn-outline-primary" onclick="moveMessageBox()">이동</button>
				<button class="btn btn-sm btn-outline-primary" onclick="deleteMessage()">삭제</button>
				<button id="readYN" class="btn btn-sm btn-outline-primary" onclick="readMessage()">읽음</button>
			</div>
			
	        <div class="searchTable">
				<form id="searchForm" action="searchSendStorageMsg" method="get">
	        	<table>
	        		<tr>
	        			<td>
							<select class="select btn btn-sm btn-outline-primary dropdown-toggle" name="condition">
								<option value="userName">이름</option>
								<option value="jobName">직급</option>
								<option value="deptName">부서</option>
								<option value="messageContent">내용</option>
							</select>
	        			</td>
	        			<td>
							<input class="form-control form-control-sm" name="keyword" type="text" placeholder="검색어를 입력하세요" size="30" value="${ keyword }">
	        			</td>
	        			<td>
							<button type="submit" class="btn btn-sm btn-outline-primary" >검색</button>
	        			</td>
	        		</tr>
	        	</table>
				</form>	<!-- searchForm  -->
			</div>	<!-- searchTable  -->
      	</div>	<!-- toolbar  -->
		
		<div class="pp-content-message">
			<div class="selectCount">
			보낸 메시지 수 <span class="message-count" id="messageListCount">${ pi.listCount }</span>개
			</div>
		
			<div class="tableBody">
				<table class="tb-message table table-sm table-hover shadow rounded-3">
				<thead>
					<tr class="tb-title-tr">
						<th><input type="checkbox" onclick="checkAll()"></th>
						<th></th>
						<th>번호</th>
						<th>수신자</th>
						<th>부서</th>
						<th>내용</th>
						<th>받은 시간</th>
						<th>읽음 여부</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
	           	<c:when test="${ empty list }">
	   	            <tr>
		            	<td colspan="8">받은 메시지가 없습니다.</td>
	                </tr>
	           	</c:when>
	           	<c:otherwise>
	           		<c:forEach var="message" items="${ list }">
	           			<tr>
		                    <td><input type="checkbox" onclick="checkOnce()" value=${ message.messageNo }></td>
		                    <c:choose>
		                    	<c:when test="${ message.bookmarkYN eq 'N' }">
			                    	<td><i onclick="bookmark_msg()" class="fa-regular fa-star td-fa-star" data-no=${ message.messageNo }></i></td>
		                    	</c:when>
		                    	<c:otherwise>
				                    <td><i  onclick="bookmark_msg()" class="fa-solid fa-star td-fa-star" data-no=${ message.messageNo }></i></td>
		                    	</c:otherwise>
		                    </c:choose>
		                    <td>${ message.messageRank }</td>
							<td>${ message.empName } [${ message.jobName }]</td>
							<td>${ message.deptName }</td>
							<td>${ message.messageContent }</td>
							<td>${ message.createDate }</td>
							<c:choose>
								<c:when test="${ message.readYN eq 'N' }">
									<td><i class="fa-solid fa-envelope td-fa-envelope"></i></td>
								</c:when>
								<c:otherwise>
				                    <td><i class="fa-solid fa-envelope-open td-fa-envelope"></i></td>
								</c:otherwise>
							</c:choose>
						</tr>
	           		</c:forEach>
	           	</c:otherwise>
				</c:choose>
				</tbody>
				</table>
			</div>	<!-- tableBody  -->
			
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
			
			<div id="pagingArea">
                <ul class="pagination justify-content-center">
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
	                    	<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                		</c:when>
                		<c:when test="${ empty condition }">
	                    	<li class="page-item"><a class="page-link" href="sendStorageMessage?page=${ pi.currentPage-1 }">&laquo;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="searchSendStorageMessage?page=${ pi.currentPage-1 }&condition=${ condition }&keyword=${ keyword }">&laquo;</a></li>
          				</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                    	<c:when test="${ pi.currentPage eq p }">
		                    	<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
	                    	</c:when>
	                    	<c:when test="${ empty condition }">
	                    		<li class="page-item"><a class="page-link" href="sendStorageMessage?page=${ p }">${ p }</a></li>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="searchSendStorageMessage?page=${ p }&condition=${ condition }&keyword=${ keyword }">${ p }</a></li>
	                    	</c:otherwise>
                    	</c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.endPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                    	</c:when>
                    	<c:when test="${ empty condition }">
                    		<li class="page-item"><a class="page-link" href="sendStorageMessage?page=${ pi.currentPage+1 }">&raquo;</a></li>
                    	</c:when>
                    	<c:otherwise>
		                    <li class="page-item" ><a class="page-link" href="searchSendStorageMessage?page=${ pi.currentPage+1 }&condition=${ condition }&keyword=${ keyword }">&raquo;</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>

		</div>	<!-- pp-content-message  -->
	</div>	<!-- pp-content  -->
	
</body>
</html>