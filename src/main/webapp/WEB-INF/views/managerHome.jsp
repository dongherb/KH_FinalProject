<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>관리자 페이지</title>
<style>
* {
	box-sizing: border-box;
}

.table-title {        
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-main{
	padding:25px;
}

.main{
width: 300x;
height: 300px;

}

</style>
</head>
<body>
    <%@include file="managerHeader.jsp" %>

<div class="container">
	<div class="table-title">
		<div class="row">
			<div class="col title-main">
				<h2>관리자 페이지 메인</h2>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col main">
			
		</div>
	</div>
	
</div>
	<%@include file="footer.jsp" %>
	
</body>
</html>