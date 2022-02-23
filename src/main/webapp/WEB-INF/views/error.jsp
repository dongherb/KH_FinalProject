<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>에러</title>
	
	<style>

	</style>
</head>
<body>

	<c:choose>
		<c:when test="${reason eq 'nullDTO'}">
			<script>
				alert("존재하지 않는 제품페이지입니다.");
			</script>
		</c:when>
		
		<c:otherwise></c:otherwise>
	</c:choose>

	<h1>Error</h1>
	<a href="${pageContext.request.contextPath}/">홈으로</a>

	<script>
	</script>

</body>
</html>