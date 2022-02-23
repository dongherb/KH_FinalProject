<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>제품 코드 중복확인</title>
</head>
<style>
    container{
       margin : auto;
    }
    
#cancelBtn{
    border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
}
#cancelBtn:hover{
    color:white;
    background-color:black;
}
#useBtn{
    border: 1px solid blue;
	background-color: white;
	color: blue;
	border-radius: 5px;
	height: 38px;
}
#useBtn:hover{
    color:white;
    background-color:blue;
}
#checkBtn{
    border: 1px solid #ffd400;
	background-color: white;
	color: #ffd400;
	border-radius: 5px;
	height: 38px;
}
#checkBtn:hover{
    color:white;
    background-color:#ffd400;
}
</style>
<body>
	<form action="${pageContext.request.contextPath}/product/checkCode.do"
		method="post" id="checkForm">
		<div class="container">
			<div class="row" style="padding-top:20px;">
				<div class="col-8 mb-4">
					<input type="text" id="product_code" name="product_code"
						class="form-control" value="${product_code}">
				</div>
				<div class="col-4 mb-4">
					<button type="button" id="checkBtn">코드
						확인</button>
				</div>
			</div>
			<div class="row">
			    <div class="col mb-4">
			        <h6>확인 결과 : </h6>
			    </div>
			    <div class="col mb-4">
			        <c:if test="${rs eq 'available'}">
			            <p id="rs" style="font-weight : bold">사용 가능한 코드</p>
			        </c:if>
			        <c:if test="${rs eq 'unavailable'}">
			            <p id="rs" style="font-weight : bold">사용 불가능한 코드</p>
			        </c:if>
			    </div>
			</div>
			<div class="row justify-content-center">
			    <div class="col-6" style="text-align:right;">
			        <button type="button" id="cancelBtn">창닫기</button>
			    </div>
			    <div class="col-6" style="text-align:left;">
			        <button type="button" id="useBtn" disabled>사용</button>
			    </div>
			</div>
		</div>
	</form>
	<script>
	    let rs = document.getElementById("rs");
        let checkBtn = document.getElementById("checkBtn");
        let product_code = document.getElementById("product_code");
        
	    $("#checkBtn").click(function(){
	    	let regexCode = /[a-zA-Z0-9]{3,10}/;
	    	if(!regexCode.test(product_code.value)){
	    		alert("제품 코드가 형식에 맞지 않습니다.\n"
	    				+ "3글자 이상/영문자, 숫자만 사용가능");
	    		return;
	    	}
	    	document.getElementById("checkForm").submit();
	    })
	
	    $("#cancelBtn").click(function(){
	    	self.close();
	    })
	    
	    $("#useBtn").click(function(){
	    	console.log(product_code.value);
	    	opener.document.getElementById("product_code").value = product_code.value;
			self.close();
	    })
	    
	    
	    if(rs.innerHTML == "사용 가능한 코드"){
	    	rs.style.color = "green";
	    	$("#product_code").attr("readonly", true);
	    	useBtn.disabled = false;
	    }else{
	    	rs.style.color = "red";
	    }
	    
	</script>
</body>
</html>