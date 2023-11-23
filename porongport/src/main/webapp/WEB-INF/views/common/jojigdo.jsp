<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>조직도</title>
    <!-- CSS -->
    <link rel="stylesheet" href="resources/css/jojigdo.css">

</head>
<body>
	<jsp:include page="../common/sidebar.jsp" />

	<div class="pp-content">
	
	    <div class="outer">
	        
	        <div id="jojigdo">
	            <h2>
	            	<b>${ jojigdoList[0].deptName }</b> 조직도
	            </h2>
	            <!-- <span>20명</span> -->
		
	            <div id="jojigdo_chart">
	                <table class="table table-bordered">
	                    <thead>
	                        <tr>
	                            <th>직급</th>
	                            <th>이름</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:choose>
	                    		<c:when test="${ not empty jojigdoList }">
	                    			<c:forEach var="i" items="${ jojigdoList }">
				                        <tr>
				                            <td>${ i.jobName }</td>
				                            <td>${ i.empName }</td>
				                        </tr>
	                    			</c:forEach>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<tr>
	                    				<td>해당 부서에는 직원이 존재하지 않습니다.</td>
	                    			</tr>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                </table>
	            </div>
	            
		    </div>
		    
		</div>
	</div>
	
	<!-- 조직도, 부서 추가 모달창 -->
    <div id="insertDept" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h3>부서추가</h3>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="deptName">부서이름</label>
                        <input type="text" id="deptName" name="deptName" required class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="deptCode">부서코드</label>
                        <input type="text" id="deptCode" name="deptCode" required class="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" id="reset_btn" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="insertDept();">등록</button>
                </div>
            </div>
        </div>
    </div>
    <script>
   		function insertDept() {
   			$.ajax({
   				url : 'insert.de',
   				data : {
   					deptCode : $('#deptCode').val(),
   					deptName : $('#deptName').val()
   				},
   				success : result => {
   					console.log(result);
   				},
   				error : () => {
   					console.log('부서추가 실패');
   				}
   			})
   		}
    </script>
</body>
</html>