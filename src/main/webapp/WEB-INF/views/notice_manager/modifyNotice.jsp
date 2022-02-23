<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>공지사항 수정</title>
<style>
.row {
	padding: 5px;
}

textarea {
	resize: none;
	height: 500px;
}

.title {
	font-size: 15px;
	font-weight: bold;
	padding: 10px 20px;
	background: #f8f8f8;
	border-bottom: 1px solid #dddddd;
}

#cancelBtn {
	border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
}

#cancelBtn:hover {
	color: white;
	background-color: black;
}

#submitBtn {
	border: 1px solid blue;
	background-color: white;
	color: blue;
	border-radius: 5px;
	height: 38px;
}

#submitBtn:hover {
	color: white;
	background-color: blue;
}

.big-title {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
	background: #f8f9fa;
}

* {
	box-sizing: border-box;
}

.container {
	text-align: center;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<form
		action="${pageContext.request.contextPath}/notice/modifyNotice.do"
		method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="row">
				<div class="col big-title">
					<div>공지사항 수정</div>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">제목</div>
				<div class="col-6">
					<input type="text" class="form-control" id="title" name="title"
						value="${dto.title}">
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">이미지 파일</div>
				<div class="col-6">
					<input type="file" class="form-control" name="file">
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">내용</div>
				<div class="col-6">
					<textarea class="form-control" id="content" name="content" style="resize: none">${dto.content}</textarea>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col" style="text-align: center;">
				<button type="button" id="cancelBtn">취소</button>
				<button type="button" id="submitBtn">수정 완료</button>
			</div>
		</div>
		<div>
			<input type="text" name="notice_seq" value="${dto.notice_seq}" hidden>
		</div>
	</form>
	<%@include file="../footer.jsp"%>

	<script>
		$("#cancelBtn").on("click", function() {
			history.back();
		})
		
		$("#submitBtn").click(function(){
			if($("#title").val() == ""){
				alert("제목을 입력해주세요.");
			}else if($("#content").val() == ""){
				alert("내용을 입력해주세요.");
			}else{
				$("#insertForm").submit();
			}
		})
	</script>
</body>
</html>