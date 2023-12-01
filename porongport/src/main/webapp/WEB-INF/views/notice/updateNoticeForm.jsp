<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>[포롱포트] 공지사항 수정</title>

<style>
	.ck-editor__editable { height: 400px; }
	.ck-content { font-size: 14px; }
	.ck-editor__editable p {margin: 0}
	
	<!-- 버튼 -->
	#btnDiv { text-align: center; margin-top: 20px; }
	.btns { display: inline-block; padding: 0 10px; height: 28px; line-height: 26px; text-align: center; vertical-align: middle; border-radius: 3px; border: 1px solid transparent; font-weight: 500; }
	.btns.save { background: #139dc8; color: #fff; cursor: pointer; }
	.btns.back { background: #fff; border: 1px solid #199bc4; color: #199bc4; }
	#tb-notice-form th{ text-align: center;}
</style>

<link rel="stylesheet" href="resources/css/notice.css">
<!-- ckeditor5 -->
<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>

   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	  rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
</head>
<body>
   	<jsp:include page="../common/sidebar.jsp" />
	
	
	<div class="pp-content">
	
    <h2 style="text-align: center;">공지사항 수정</h2>
    
    <form action="insertNotice" method="post" enctype="multipart/form-data">
	    <table id="tb-notice-form" class="table table-sm">
	   		<tr>
	   			<th>제목</th>
	   			<td><input class="form-control form-control-sm" name="noticeTitle" required value="${ list.noticeTitle }"></td>
	   			<td >
	   			<div class="form-check form-switch">
				  <label>
				  <input class="form-check-input" type="checkbox" name="noticeTypeTmp" checked="${ list.noticeType }">
				  <input type="hidden" name="noticeType"/>
				  중요공지 설정
				  </label>
				</div>
	   			</td>
	   		</tr>
	   		<tr>
	   			<th>첨부파일</th>
	   			<td><input type="file" name="multiFile" multiple></td>
	   		</tr>
	   		<tr>
	   			<th>기존파일</th>
	   			<td>
					<c:forEach var="at" items="${ attachList }">
	   				<c:choose>
	   					<c:when test="${ empty at.originFileName }">
	   						<input class="form-control form-control-sm detail-input" readonly placeholder="기존 첨부파일이 존재하지 않습니다.">
	      				</c:when>
	      				<c:otherwise>
			      			<a class="form-control form-control-sm detail-input upload-name" 
			      			   href="${ at.filePath }/${ at.changeFileName }" download="${ at.originFileName }">
			      			   <i class="fa-regular fa-floppy-disk"></i> ${ at.originFileName }</a>
	      				</c:otherwise>
	      			</c:choose>
   				</c:forEach>
	   			</td>
	   		</tr>
	   		<tr>
	   			<th>내용</th>
	   			<td>
		   			<div>
		   				<textarea id="editor" name="noticeContent" required>${ list.noticeContent }</textarea>
		   			</div>
	   			</td>
	   		</tr>
	   	</table>
				    	
		<div id="btnDiv">
		    <button type="submit" class="btns save" onclick="updatetNotice()">수정하기</button>
		    <button type="button" class="btns back" onclick="location.href='${path}/noticeList'">목록으로</button>
		</div>
    </form>

	</div>
	    


	<script>
	
		let editor;
 	    ClassicEditor.create(document.getElementById('editor'),
   		{	
	    	// 한국어 설정
    		language: "ko",
    		// 파일 업로드 어댑터 설정
    		ckfinder: {
                uploadUrl: 'fileUpload'
            }
	    })
        .then( newEditor => {
        	editor = newEditor;
   	 	})
	    .catch((error) => {
	        console.error( error );
	    });
 	   
	</script>
	    
</body>
</html>
