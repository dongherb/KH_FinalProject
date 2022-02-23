<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>문의사항 목록</title>
<style>
.row {
	padding: 5px;
}

a.toDetail {
	color: black;
	text-decoration: none;
}

a.toDetail:hover {
	color: gray;
}

table {
	background-color: rgb(245, 245, 245);
	table-layout: fixed;
}

.dynamic-tr>td {
	vertical-align: middle;
}

.table-title {
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-enquiry {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<div class="container">
		<div class="table-title">
			<div class="row">
				<div class="col title-enquiry">
					<div>문의사항</div>
				</div>
			</div>
		</div>
		<table class="table table-hover dynamic-table"
			style="text-align: center">
			<thead class="table-light">
				<tr class="text-center">
					<th class="col-1">번호</th>
					<th class="col-2">문의유형</th>
					<th class="col-3">제목</th>
					<th class="col-2">작성자</th>
					<th class="col-1">날짜</th>
					<th class="col-1">답변여부</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="6">등록된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${list}" var="dto">
					<tr class="text-center dynamic-tr">
						<td>${dto.enquiry_seq}</td>
						<td>${dto.category}</td>
						<td><a
							href="${pageContext.request.contextPath}/enquiry/toEnquiryDetail?enquiry_seq=${dto.enquiry_seq}"
							class="toDetail">${dto.title}</a></td>
						<td>${dto.id}</td>
						<td>${dto.enquiry_date}</td>
						<td><c:choose>
								<c:when test="${dto.answer ne null}">
									<span style="color: blue; font-weight: bold">답변 완료</span>
								</c:when>
								<c:otherwise>
									<span style="color: red; font-weight: bold">답변대기중</span>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이징 -->

	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>