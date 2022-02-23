<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>작동확인</title>
</head>
<body>
	<div>
		<button type="button" id="home">home</button>
	</div>

	<div>
		<button type="button" id="mypagetest">mypage test</button>
	</div>
	
	<div>
		<button type="button" id="toProductList">toProductList</button>
	</div>
	
	<div>
		<button type="button" id="toProductShopList">toProductShopList</button>
	</div>
	
	<div>
		<button type="button" id="toNoticeList">toNoticeList</button>
	</div>
	
	<div>
		<button type="button" id="toReportList">toReportList</button>
	</div>
	
	<div>
		<button type="button" id="toMemberList">toMemberList</button>
	</div>
	
	<div>
		<button type="button" id="toLogin">toLogin</button>
	</div>

</body>

<script>
	$("#home").on("click", function(){
	    $(location).attr("href", "${pageContext.request.contextPath}/");
	});

	$("#mypagetest").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/toMypageHome");
	});
	
	$("#toProductList").on("click", function(){
		let product_category = "All";
		$(location).attr("href", "${pageContext.request.contextPath}/product/toProductList?product_category=" +product_category+ "&currentPage=1");
	});
	
	$("#toProductShopList").on("click", function(){
		let product_category = "전체"
		$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category=&detail_category=&keyword=&currentPage=1");
	});
	
	
	$("#toNoticeList").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/notice/toNoticeList?currentPage=1");
	});
	
	$("#toReportList").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/report/toReportList?currentPage=1");
	});
	
	$("#toMemberList").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/member/toMemberList?currentPage=1");
	});
	
	$("#toLogin").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/member/toLoginPage");
	});

</script>

</html>