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
<title>제품 정보</title>
<style>
img {
	width: 300px;
	heigth: 400px;
}

.row {
	padding: 10px;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${dto eq null}">
		    <div style="color:red; text-align:center; font-weight:bold">존재하지 않는 제품 코드입니다.</div>
		</c:when>
		<c:otherwise>
			<div class="container">
				<div class="row">
					<div class="col">제품 코드 : ${dto.product_code}</div>
				</div>
				<div class="row">
					<div class="col">카테고리 : ${dto.product_category}</div>
				</div>
				<div class="row">
					<div class="col">세부 카테고리 : ${dto.detail_category}</div>
				</div>
				<div class="row">
					<div class="col">
						<img
							src="${pageContext.request.contextPath}/product_img/${dto.product_img}">
					</div>
				</div>
				<div class="row">
					<div class="col">가격 : ${dto.price}</div>
				</div>
				<div class="row">
					<div class="col">할인율 : ${dto.discount}</div>
				</div>
				<div class="row">
					<div class="col">별점 : ${dto.avg_score}</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>