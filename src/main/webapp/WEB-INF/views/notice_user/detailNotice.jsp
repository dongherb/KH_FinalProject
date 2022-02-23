<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<style>
.title {
	font-size: 15px;
	font-weight: bold;
	padding: 10px 20px;
	background: #f8f8f8;
	border-bottom: 1px solid #dddddd;
}

.cont {
	padding: 10px 20px;
	background: rgb(250, 250, 250);
	border-bottom: 1px solid #dddddd;
}

#content{
    resize: none;
    width: 100%; 
    height: 500px; 
    border : 0px;
}
</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<div class="container w-50">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-2 title">제목</div>
			<div class="col-9 cont">${dto.title}</div>
		</div>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-2 title">작성일</div>
			<div class="col-9 cont">${dto.written_date}</div>
		</div>
		<c:choose>
			<c:when test="${empty dto.notice_img}">
			</c:when>
			<c:when test="${dto.notice_seq ne null}">
				<div class="row">
					<div class="col-1"></div>
					<div class="col-11 cont">
						<img
							src="${pageContext.request.contextPath}/notice_img/${dto.notice_img}">
					</div>
				</div>
			</c:when>
		</c:choose>
		<div class="row" style="padding-bottom : 30px;">
			<div class="col-1"></div>
			<div class="col-11 cont">
				<textarea id="content" readonly>${dto.content}</textarea>
			</div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>