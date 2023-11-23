<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
<!-- sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<c:if test="${ not empty loginFail }">
		<script>
			Swal.fire({
				text : '${ loginFail }',
				icon : 'error'
			});
			
			location.href = '${path}';
		</script>
		<c:remove var="loginFail" />
	</c:if>	

</body>
</html>