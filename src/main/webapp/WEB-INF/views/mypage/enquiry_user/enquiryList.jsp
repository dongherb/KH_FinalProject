<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>문의현황</title>
<style>
.dynamic-tr>td {
	vertical-align: middle;
}

#myInfoContentTitle {
	text-align: center;
}

.enquiry-group {
	margin-bottom: 150px;
}

.text-center{
   color : black;
}

.text-center:hover{
   color : gray;
}

#writeBtn{
    font-weight : bold;
    background-color: #e5eaee;
	color: black;
	border-radius: 5px;
    height: 38px;
}

#writeBtn:hover{
    background-color : white;
}
</style>
</head>
<body>
    <%@include file="../../header.jsp" %>
	<%@include file="../mypageNavi.jsp"%>

	<div class="container mypage-section-1">
		<div class="row">
			<div class="d-sm-none d-md-block col-md-1"></div>
			
			<div class="col">	
				
					<div class="row" id="myInfoContentTitle">
					<div class="col">
						<h2>문의 사항</h2>
					</div>
				</div>
				  <br>
   				  <br>
				
			<div class="container enquiry-group">
				<table class="table" style="text-align: center">
				<thead class="table-light">
				<tr class="text-center">
							<th class="col">문의유형</th>
							<th class="col">제목</th>
							<th class="col">작성자</th>
							<th class="col">날짜</th>
							<th class="col">답변여부</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
						<tr class="text-center dynamic-tr">
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach items="${list}" var="dto">
							<tr>
								<td>${dto.category}</td>
								<td><a
									href="${pageContext.request.contextPath}/enquiry/toDetail?enquiry_seq=${dto.enquiry_seq}">${dto.title}</a></td>
								<td>${dto.id}</td>
								<td>${dto.enquiry_date}</td>
								<td><c:choose>
										<c:when test="${!empty dto.answer}">답변완료</c:when>
										<c:otherwise>답변대기중</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="row">
					<div class="col d-flex justify-content-end">
						<button type="button" id="writeBtn">문의하기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="d-sm-none d-md-block col-md-1"></div>
	</div>
	</div>

	<%@include file="../../footer.jsp"%>

	<script>
		//문의글 페이지 요청
		$("#writeBtn").on("click",function() {
			location.href = "${pageContext.request.contextPath}/enquiry/toInsertEnquiry";
		});
	</script>

</body>
</html>