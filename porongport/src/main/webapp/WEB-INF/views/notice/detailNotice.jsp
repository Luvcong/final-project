<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항</title>
    <!-- 메인화면 css-->
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
				<i class="fa-regular fa-circle-left fa-2xl" id="backIcon" onclick="historyBack()"></i>
				<c:if test="${ list.empNo eq loginUser.empNo }">
					<button class="btn btn-sm btn-danger">삭제</button>
				</c:if>
			<div class="likeCount">
				<c:choose>
					<c:when test="${ likeList eq 1 }">	<!-- notice_like 테이블에 empNo가 있는지? 있으면 채워진 하트 ; 클릭시 좋아요 delete -->
						<i class="fa-solid fa-heart fa-2xl" style="color: #e71313;" onclick="likeChck()" data-no=${ list.noticeNo }></i>
					</c:when>
					<c:otherwise>	<!-- 없으면 빈 하트 : 클릭시 좋아요 insert -->
						<i class="fa-regular fa-heart fa-2xl" style="color: #e71313;" onclick="likeChck()" data-no=${ list.noticeNo }></i>
					</c:otherwise>
				</c:choose>
						${ list.noticeLikeCount }	<!-- 해당 게시글의 좋아요 전체 개수 -->
			</div>
      	</div>	<!-- toolbar  -->
      	
      	<div class="detailContent">
  			<div class="notice-profile">
				<img id="profile-notice" src="resources/images/20231106.png"  alt="프로필사진">
   			</div>
   			<div class="notice-profile-info">
				${ list.empName } ${ list.jobName } / ${ list.deptName }
   			</div>
   			<div class="notice-profile-date">
				${ list.createDate }
   			</div>
   			<hr>
   			<div class="notice-content">
   				<div id=readEditor class="form-control form-control-sm form-control-notice">${ list.noticeContent }</div>
   			</div>
   			<div class="notice-file">
   				<span>첨부파일</span>
   				<c:forEach var="at" items="${ attachList }">
	   				<c:choose>
	   					<c:when test="${ empty at.originFileName }">
	   						<input class="form-control form-control-sm detail-input" readonly placeholder="첨부파일이 존재하지 않습니다.">
	      				</c:when>
	      				<c:otherwise>
			      			<a class="form-control form-control-sm detail-input upload-name" 
			      			   href="${ at.filePath }/${ at.changeFileName }" download="${ at.originFileName }">
			      			   <i class="fa-regular fa-floppy-disk"></i> ${ at.originFileName }</a>
	      				</c:otherwise>
	      			</c:choose>
   				</c:forEach>
   			</div>
      	</div>
		
	</div>	<!-- pp-content  -->
	
	<script>
	
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
	
	function historyBack(){
			  location.href = document.referrer;
	}	// historyBack
	
	function likeChck(){
		
		let target = event.currentTarget;
		let get_like = target.classList.contains('fa-solid');	// 해당 class가 포함되어 있으면 true (좋아요 한 경우)
		let message_no = target.getAttribute('data-no');
		console.log(target);
		console.log(message_no);
		console.log(like_y);	
		
/* 		
	 	$.ajax({
			url : 'likeChck',
			type : 'get',
			data : { 
					message_no : message_no,
			 		get_like : get_like					// token이 true로 넘어오면 읽음 / false인 경우 안읽음
			},
			success : function(result){
				if(!result) {
					console.log('작업 실패');
					return;
				}
				
				for (let icon of icon_list) {
					if(!token) {
						icon.classList.remove('fa-envelope-open');
						icon.classList.add('fa-envelope');
						
						let tr = icon.parentElement.parentElement;
						tr.style.color = '';
						tr.style.fontWeight = '';		
					} else {
						icon.classList.add('fa-envelope-open');
						icon.classList.remove('fa-envelope');
						
						let tr = icon.parentElement.parentElement;
						tr.style.color = 'darkgray';
						tr.style.fontWeight = 'normal';
					}
				}

				read_yn_btn.textContent = token ? '안읽음' : '읽음';
			},	// success
			error : function(result){
				console.log('통신오류! 실패');
			},	// error
		});	// ajax */
	}	// likeCount
	
	
	
	</script>
</body>
</html>