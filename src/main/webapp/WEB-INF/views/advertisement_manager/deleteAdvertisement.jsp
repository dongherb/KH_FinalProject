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
<title>광고 수정</title>
<style>
.row {
	padding: 5px;
}

.big-title {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
	background: #f8f9fa;
}

.title {
	font-size: 15px;
	font-weight: bold;
	padding: 10px 20px;
	background: #f8f8f8;
	border-bottom: 1px solid #dddddd;
}

* {
	box-sizing: border-box;
}

.container {
	text-align: center;
}

#submitBtn {
	border: 1px solid red;
	background-color: white;
	color: red;
	border-radius: 5px;
	height: 38px;
}

#submitBtn:hover {
	color: white;
	background-color: red;
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

.weather {
	font-size: 20px;
	font-weight: bold;
}

.product_code{
    width: 200px;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<form id="deleteForm"
		action="${pageContext.request.contextPath}/advertisement/deleteAd.do"
		method="post" enctype="multipart/form-data">
		<div class="container" style="height : 475px;">
			<div class="row">
				<div class="col big-title">
					<div>광고 삭제</div>
				</div>
			</div>
			<div class="row" style="padding-top : 100px;">
				<div class="col-3"></div>
				<div class="col-3 title">삭제할 광고 날씨</div>
				<div class="col-2">
				    <select class="form-select" name="weather" id="weather">
				        <option selected>=== 선택 ===</option>
				        <option value="normal">보통</option>
				        <option value="hot">더움</option>
				        <option value="cold">추움</option>
				        <option value="rain">비</option>
				    </select>
				</div>
			</div>
			<div class="row" style="padding-top : 30px;">
			    <div class="col">
			        <button type="button" id="cancelBtn">취소</button>
			        <button type="button" id="submitBtn">삭제</button>
			    </div>
			</div>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
	
	<script>
	$("#cancelBtn").click(function(){
    	history.back();
    })
    
    $("#submitBtn").click(function(){
    	if($("#weather").val() == "=== 선택 ==="){
    		alert("삭제할 날씨를 선택해주세요.");
    	}else{
    		$("#deleteForm").submit();
    	}
    })
	</script>
</body>
</html>