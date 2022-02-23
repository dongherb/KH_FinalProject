<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>문의글 수정</title>
<style>
	.container{
	margin-bottom : 150px;
	}
	
		
	#content{
	resize: none;
	}
	
		.rowBorder{
	padding:10px;
	}
</style>
</head>
<body>
    <%@include file="../../header.jsp" %>
	<%@include file="../mypageNavi.jsp"%>

	<div class="container w-50">
		<form id="enquiryForm" action="${pageContext.request.contextPath}/enquiry/modifyEnquiry.bo" method="post">
			<div class="row">
				<div class="col d-flex justify-content-center">
					<h3>문의 글 작성</h3>
				</div>
			</div>

			<div class="row rowBorder">
				<div class="col col-4">
					<label for="title" class="form-label">제목</label> 
					<input type="text" class="form-control form-control-sm" id="title" name="title" value="${dto.title}">
				</div>

				<div class="col col-4">
					<label for="title" class="form-label">문의유형</label> <select
						class="form-select form-select-sm" aria-label="Default select example" name="category" value="${dto.category}">
						<option selected value="상품문의">상품문의</option>
						<option value="사이즈문의">사이즈문의</option>
						<option value="교환문의">교환문의</option>
						<option value="배송문의">배송문의</option>
						<option value="불량문의">불량문의</option>
					</select>
				</div>


				<div class="row rowBorder">
					<div class="col">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control form-control-sm" id="content" name="content" rows="10">${dto.content}</textarea>
					</div>
				</div>

				<div class="row rowBorder">
					<div class="col" style="text-align: right;">
							<button type="button" class="btn btn-secondary btn-sm" id="previousBtn">이전으로</button>
							<button type="button" class="btn btn-dark btn-sm" id="modifyBtn">수정하기</button>
					</div>
				</div>
			</div>
			<div>
				<input type="text" name="enquiry_seq" value="${dto.enquiry_seq}" hidden>
			</div>
		</form>
	</div>

	<%@include file="../../footer.jsp"%>
	
	<script>
		//이전 버튼
		$("#previousBtn").on("click",function() {
			location.href = "${pageContext.request.contextPath}/enquiry/toEnquiryList";
		});
		
		//수정 버튼
		$("#modifyBtn").on("click",function() {
			if(title.value == ""){
				alert("제목을 입력하세요.");
				return;
			}else if(content.value == ""){
				alert("내용을 입력하세요.");
				return;
			}
			document.getElementById("enquiryForm").submit();	
		});
	</script>
</body>
</html>