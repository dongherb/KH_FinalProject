<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"crossorigin="anonymous"></script>
<title>문의글 상세보기</title>
<style>
.container {
	margin-bottom: 150px;
}

.title {
	margin-bottom: 10px;;
}

.answer>img {
	width: 25px;
	height: 25px;
}
.rowBorder {
	padding: 10px;
}

.rowBorder-btn {
	padding: 10px;
	margin-bottom: 20px;
}

.form-label {
	padding: 10px;
}

.contentForm {
	padding-left: 5px;
}

.content{
margin-top: 5px;
}

.admin {
margin-left: 10px;
}

.date{
padding-top: 5px;
}

</style>
</head>
<body>
    <%@include file="../../header.jsp" %>
	<%@include file="../mypageNavi.jsp"%>

	<div class="container w-50">
		<input class="d-none" name="enquiry_seq" value="0">
		<div class="row">
			<div class="col d-flex justify-content-center title">
				<h3>문의글 상세보기</h3>
			</div>
		</div>

		<div class="row rowBorder">
			<div class="col-3">
				<div class="form-control" readonly>제목: ${dto.title}</div>
			</div>

			<div class="col-3">
				<div class="form-control" readonly>문의유형: ${dto.category}</div>
			</div>

			<div class="col-3">
				<div class="form-control" readonly>문의일: ${dto.enquiry_date}</div>
			</div>

			<div class="row rowBorder">
				<div class="col content">
					<label for="content" class="form-label"><b>문의 내용</b></label>
					<textarea class="form-control contentForm" id="content" name="content" rows="10" style="resize: none;"  readonly>${dto.content}</textarea>
				</div>
			</div>

			<div class="row rowBorder-btn">
				<div class="col" style="text-align: right;">
					<button type="button" class="btn btn-secondary btn-sm" id="previousBtn">이전으로</button>
					<button type="button" class="btn btn-dark btn-sm" id="modifyBtn">수정하기</button>
					<button type="button" class="btn btn-danger btn-sm" id="deleteBtn">삭제하기</button>
				</div>
			</div>

			<!-- 댓글 출력 !empty dto.answer-->
			<c:choose>
				<c:when test="${!empty dto.answer}">
					<div class="container w-90">
						<div class="row answer">
							<div class="col admin"> <img src="${pageContext.request.contextPath}/resources/image/admin.png">관리자  &nbsp; ${dto.answer_date}</div>
						</div>
						
						<div class="row rowBorder">
							<div class="col">
							<textarea style="resize: none; width:98%;" class="form-control" rows="3" readonly>${dto.answer}</textarea>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>

		</div>
	</div>

	<%@include file="../../footer.jsp"%>

	<script>
		//이전 페이지 이동
		$("#previousBtn").on("click",function() {
			location.href = "${pageContext.request.contextPath}/enquiry/toEnquiryList";
		});
		
		//문의글 수정페이지 요청
		$("#modifyBtn").on("click",function() {
        	location.href = "${pageContext.request.contextPath}/enquiry/toModifyEnquiry?enquiry_seq=" + ${dto.enquiry_seq};
		});
		
		//문의글 삭제
		$("#deleteBtn").on("click",function() {
			let rs = confirm("게시글을 삭제하시겠습니까?");
			if(rs) {
        		location.href = "${pageContext.request.contextPath}/enquiry/deleteEnquiry.bo?enquiry_seq=" + ${dto.enquiry_seq};
				}
		});
    </script>

</body>
</html>