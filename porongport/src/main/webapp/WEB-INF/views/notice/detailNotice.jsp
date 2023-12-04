<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항</title>

    <link rel="stylesheet" href="resources/css/notice.css">
    
    <!-- ckeditor5 -->
	<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    
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
				${ list.noticeTitle }
			</div>
		</div>	<!-- header  -->
		
		<div class='toolbar'>
		    <div>
				<i class="fa-regular fa-circle-left fa-2xl" id="backIcon" onclick="historyBack()"></i>
		    </div>
		    <div>
		    	<c:if test="${ list.noticeWriter eq loginUser.empNo }">
					<button class="btn btn-sm btn-danger" onclick="postFormSubmit(0)">수정</button>
					<button class="btn btn-sm btn-danger" onclick="postFormSubmit(1)">삭제</button>
				</c:if>
		    </div>
				

      	</div>	<!-- toolbar  -->
      	
		<form action="" method="post" id="postForm">		
				<input type="hidden" name="nno" value="${ list.noticeNo }">
			<c:forEach var="at" items="${ attachList }">
				<input type="hidden" name="changeFileName" value="${ at.filePath }/${ at.changeFileName }">
			</c:forEach>
		</form>
      	
      	<div class="detailContent">
      	<div class="notice-profile">
      		<div>
      		    <div class="profile-img">
					<img class="profile-notice" src="resources/upProfiles/${ profile.changeFileName }"  alt="프로필사진">
	   			</div>
	   			<div class="profile-info">
	   				<p>${ list.empList[0].empName } ${ list.empList[0].jobName } [ ${ list.empList[0].deptName } ]</p>
	   				<p class="n-write-date">작성일 : ${ list.createDate }<c:if test="${ not empty list.modifyDate }"> / 수정일 : ${ list.modifyDate }</c:if></p>
	   			</div>
      		</div>
			<div>
				<div class="notice-like">
					<c:choose>
						<c:when test="${ likeList > 0 }">	<!-- notice_like 테이블에 empNo가 있는지? 있으면 채워진 하트 ; 클릭시 좋아요 delete -->
							<i class="fa-solid fa-heart fa-2xl" onclick="likeCheck()" data-no=${ list.noticeNo }></i>
						</c:when>
						<c:otherwise>	<!-- 없으면 빈 하트 : 클릭시 좋아요 insert -->
							<i class="fa-regular fa-heart fa-2xl"  onclick="likeCheck()" data-no=${ list.noticeNo }></i>
						</c:otherwise>
					</c:choose>
					<span id="likeCount">${ list.noticeLikeCount }</span>	<!-- 해당 게시글의 좋아요 전체 개수 -->
				</div>
			</div>

      	</div>
      	
		<div class="notice-content">
			<div id=readEditor class="form-control form-control-sm form-control-notice">${ list.noticeContent }</div>
		</div>
		<div class="notice-file">
			<span>첨부파일 ${at.originFileName }</span>
			<c:if test="${ empty attachList }">
				<input class="form-control form-control-sm detail-input" readonly placeholder="첨부파일이 존재하지 않습니다.">
			</c:if>
			<c:forEach var="at" items="${ attachList }">
   			<a class="detail-input upload-name" 
   			   href="${ at.filePath }/${ at.changeFileName }" download="${ at.originFileName }">
   			   <i class="fa-regular fa-floppy-disk"></i> ${ at.originFileName }</a>
			</c:forEach>
		</div>
      	</div>
      	
      	<table id="replyArea" class="table" align="center">
	        <thead>
	            <tr>
	                <th colspan="4" style="padding-left:0;">
	                    <textarea class="form-control" id="replyContent" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
	                </th>
	                <th style="vertical-align:middle; width:100px;"><button class="btn btn-sm btn-secondary" onclick="addReply()">등록하기</button></th>
	            </tr>
	            
	            <tr>
	                <th colspan="5">댓글(<span id="rcount">0</span>)</th>
	            </tr>
	        </thead>
			<tbody>
			
			</tbody>
		</table>		
		
	</div>	<!-- pp-content  -->
	
	
	
	<script>
	$(function(){
		selectReplyList();
	})
	
	let editor;
	
    ClassicEditor
    .create(document.getElementById('readEditor'))
    .then( newEditor => {
    	editor = newEditor;
		editor.isReadOnly = true;
		
		const toolbarElement = editor.ui.view.toolbar.element;
		toolbarElement.style.display = 'none';

 	})
    .catch((error) => {
        console.error( error );
    });
	
	
	// ------------------------------------------------------------------
	// 뒤로가기 버튼 클릭 (이전페이지 이동)
	// ------------------------------------------------------------------
	$(function(){
		
		let input_hidden = document.getElementById('contentHidden');
		let content = input_hidden.value;
		console.log(input_hidden);
		console.log(content);
		
	})
	
	function historyBack() {
		let back_url = document.refeeror;
		if(back_url == undefined)
			back_url = 'noticeList';
		
		location.href = back_url;
			  
	}	// historyBack
	
	
	// ------------------------------------------------------------------
	// 공지사항 게시글 좋아요 체크 여부 ajax
	// ------------------------------------------------------------------
	function likeCheck(){
		
		let target = event.currentTarget;
		let get_like = target.classList.contains('fa-solid');	// 해당 class가 포함되어 있으면 true (좋아요 한 경우)
		let notice_no = target.getAttribute('data-no');
		console.log(target);
		console.log(notice_no);
		console.log(get_like);	
		
		let like_count = document.getElementById('likeCount');
		let total = parseInt(like_count.textContent);
		
	 	$.ajax({
			url : 'likeCheck',
			type : 'get',
			data : { 
					notice_no : notice_no,
			 		get_like : get_like					// token이 true로 넘어오면 읽음 / false인 경우 안읽음
			},
			success : function(result){
				
				if(result){
					target.classList.remove('fa-regular');
					target.classList.add('fa-solid');
					total++;
					like_count.textContent = total; 
				} else {
					target.classList.remove('fa-solid');
					target.classList.add('fa-regular');
					total--;
					like_count.textContent = total;
				}
				
			},	// success
			error : function(result){
				console.log('통신오류! 실패');
			},	// error
		});	// ajax
	}	// likeCount
	
	
	// ------------------------------------------------------------------
	// 공지사항 게시글 수정 & 삭제
	// ------------------------------------------------------------------
	function postFormSubmit(num){
		if(num == 0){	// 수정하기 클릭시
			$('#postForm').attr('action', 'updateNoticeForm').submit();
		} else {		// 삭제하기 클릭시
			$('#postForm').attr('action', 'deleteNotice').submit();
	  }
	}	// postFormSubmit
	
	
	// ------------------------------------------------------------------
	// 공지사항 댓글 작성 ajax
	// ------------------------------------------------------------------
	function addReply(){
		
		if($('#replyContent').val().trim() != ''){
			
			$.ajax({
				url : 'addReply',
				type : 'post',
				data : { 
						noticeNo : ${ list.noticeNo },
						replyContent : $('#replyContent').val(),
						replyWriter : '${ sessionScope.loginUser.empNo }'
					},
				success : function(result){	// result => {
					
					if(result === 'success'){
						$('#replyContent').val('');
						selectReplyList();
					} 
				},	// success
				error : function(result){
					console.log('통신오류! 실패');
				},	// error
			});	// ajax
		}
		else {
			Swal.fire('실패', '댓글을 작성해주세요!', 'warning');
		}
	
	}	// addReply
	
	
	// ------------------------------------------------------------------
	// 공지사항 댓글 조회 ajax
	// ------------------------------------------------------------------
	function selectReplyList(){
		
		$.ajax({
			url : 'noticeReplyList',
			type : 'post',
			data : { noticeNo : ${ list.noticeNo } },
			success : replyList => {
				console.log(replyList);
				
				let value = '';
				for(let list of replyList) {
					value += '<tr style="line-height:40px">'
						   + '<td style="width:75px;">' + '<img src="resources/images/20231106.png" alt="프로필사진" class="profile-notice">' + '</td>'
						   + '<td style="width:250px;">' + list.empList[0].empName + list.empList[0].jobName + ' / ' + list.empList[0].deptName + '</td>'
						   + '<td>' + list.replyContent + '</td>'
						   + '<td style="width:170px;">' + list.replyDate + '</td>';
						   if(list.replyWriter == ${loginUser.empNo} ){
				   value += '<td onclick="deleteReply('+ list.replyNo +')" style="text-align: center;">' + '<i class="fa-solid fa-square-xmark" style="color: #e71313;"></i>' + '</td>'
						   }
						   + '</tr>';
				}
				$('#replyArea tbody').html(value);
				$('#rcount').text(replyList.length);
			},	// success
			error : () => {
				console.log('AJAX 댓글 목록조회 실패!');
			}	// error
		});	// 	// ajax
	}	// selectReplyList
	
	
	
	// ------------------------------------------------------------------
	// 공지사항 댓글 삭제 ajax
	// ------------------------------------------------------------------
 	function deleteReply(replyNo){
 		let tr = event.currentTarget.parentElement;
 		
 		Swal.fire({
			title: "댓글을 삭제하시겠습니까?",
			text : "※ 삭제된 댓글은 복원이 불가합니다.",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
			}).then((result) => {
			if (!result.isConfirmed) {
				  return;
				}
 		
			$.ajax({
				url : 'deleteReply',
				type : 'post',
				data : { 
						 replyNo : replyNo
						},
				success : result => {
					tr.remove();
					
					
					//$('#replyArea tbody').html(value);
					let countElement = document.getElementById('rcount');
					countElement.textContent = parseInt(countElement.textContent) - 1;
				},	// success
				error : () => {
					console.log('AJAX 댓글 삭제 실패!');
				}	// error
			});	// 	// ajax
			});		// confrim	
		}	// deleteReply
	
		
	</script>
	
 	<c:choose>
 		<c:when test="${ not empty successMsg }">
 			<script>
	 			Swal.fire('성공', '${ successMsg }', 'success');
 			</script>
 		</c:when>
 		<c:when test="${ not empty failMsg }">
 			<script>
 			Swal.fire('실패', '${ failMsg }', 'error');
 			</script>
 		</c:when>
 	</c:choose>
 	
 	<c:remove var="successMsg" />
 	<c:remove var="failMsg" />
 	
</body>
</html>