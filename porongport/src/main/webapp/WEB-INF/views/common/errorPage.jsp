<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
</head>
<body>
	<c:choose>
		<c:when test="${ not empty goToMain }">
			<script>
				alert('${ goToMain }');
				location.href = '${path}';
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert('${ errorMsg }');
			</script>
		</c:otherwise>
	</c:choose>

</body>
</html>