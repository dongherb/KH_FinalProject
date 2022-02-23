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
<title>광고 등록</title>
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

.codeCheckBtn {
	border: 1px solid #0e0f37;
	background-color: white;
	color: #0e0f37;
	border-radius: 5px;
	height: 38px;
}

.codeCheckBtn:hover {
	color: white;
	background-color: #0e0f37;
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
	<form id="insertForm"
		action="${pageContext.request.contextPath}/advertisement/insertAd.do"
		method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="row">
				<div class="col big-title">
					<div>광고 등록</div>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">날씨</div>
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
			<div class="row" style="text-align : left">
			    <div class="col-1"></div>
			    <div class="col"><h4>제품 1</h4></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">제품 코드</div>
				<div class="col-2">
					<input type="text" class="form-control" id="product_code1" name="product_code1">
				</div>
				<div class="col-2">
				    <button type="button" class="codeCheckBtn" id="btn1">코드 확인</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">광고 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file1" name="file1" accept="jpg, jpeg, png" required>
				</div>
			</div>
			<div class="row" style="text-align : left">
			    <div class="col-1"></div>
			    <div class="col"><h4>제품 2</h4></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">제품 코드</div>
				<div class="col-2">
					<input type="text" class="form-control" id="product_code2" name="product_code2">
				</div>
				<div class="col-2">
				    <button type="button" class="codeCheckBtn" id="btn2">코드 확인</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">광고 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file2" name="file2" accept="jpg, jpeg, png" required>
				</div>
			</div>
			<div class="row" style="text-align : left">
			    <div class="col-1"></div>
			    <div class="col"><h4>제품 3</h4></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">제품 코드</div>
				<div class="col-2">
					<input type="text" class="form-control" id="product_code3" name="product_code3">
				</div>
				<div class="col-2">
				    <button type="button" class="codeCheckBtn" id="btn3">코드 확인</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">광고 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file3" name="file3" accept="jpg, jpeg, png" required>
				</div>
			</div>
			<div class="row" style="text-align : left">
			    <div class="col-1"></div>
			    <div class="col"><h4>제품 4</h4></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">제품 코드</div>
				<div class="col-2">
					<input type="text" class="form-control" id="product_code4" name="product_code4">
				</div>
				<div class="col-2">
				    <button type="button" class="codeCheckBtn" id="btn4">코드 확인</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-3 title">광고 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file4" name="file4" accept="jpg, jpeg, png" required>
				</div>
			</div>
			<div class="row">
			    <div class="col">
			        <button type="button" id="cancelBtn">취소</button>
			        <button type="submit" id="submitBtn">등록</button>
			    </div>
			</div>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
	
	<script>
	$("#cancelBtn").click(function(){
    	history.back();
    })
    
    $("#btn1").click(function(){
    	let product_code = $("#product_code1").val();
    	
    	if(product_code == ""){
    		alert("제품 코드가 입력되지 않았습니다.");
    	} else{
    		let url = "${pageContext.request.contextPath}/advertisement/toPopup?product_code=" + product_code;
        	let name = "제품 정보";
        	let option = "width=400, height=600";
        	
        	window.open(url, name, option);
    	}
    })
    
    $("#btn2").click(function(){
    	let product_code = $("#product_code2").val();
    	
    	if(product_code == ""){
    		alert("제품 코드가 입력되지 않았습니다.");
    	} else{
    		let url = "${pageContext.request.contextPath}/advertisement/toPopup?product_code=" + product_code;
        	let name = "제품 정보";
        	let option = "width=400, height=600";
        	
        	window.open(url, name, option);
    	}
    })
    
    $("#btn3").click(function(){
    	let product_code = $("#product_code3").val();
    	
    	if(product_code == ""){
    		alert("제품 코드가 입력되지 않았습니다.");
    	} else{
    		let url = "${pageContext.request.contextPath}/advertisement/toPopup?product_code=" + product_code;
        	let name = "제품 정보";
        	let option = "width=400, height=600";
        	
        	window.open(url, name, option);
    	}
    })
    
    $("#btn4").click(function(){
    	let product_code = $("#product_code4").val();
    	
    	if(product_code == ""){
    		alert("제품 코드가 입력되지 않았습니다.");
    	} else{
    		let url = "${pageContext.request.contextPath}/advertisement/toPopup?product_code=" + product_code;
        	let name = "제품 정보";
        	let option = "width=400, height=600";
        	
        	window.open(url, name, option);
    	}
    })
	</script>
</body>
</html>