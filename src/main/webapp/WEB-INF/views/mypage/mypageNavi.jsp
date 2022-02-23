<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>마이페이지 헤더</title>

<style>
.naviContainer {
	margin: auto;
	margin-top: 100px;
	margin-bottom: 80px;
}

.myPageNavi_titleDiv {
	text-align: center;
	margin-bottom: 30px;
}

.myPageNavi_btnDiv{
	height: 100px;
	text-align: center;
	align-items: center;
}

.mypageNaviBtn{
	background-color: #e5eaee;
	height:100%;
	width:100%;
	box-shadow: 1px 1px 1px 2px rgb(150, 150, 150);
	padding-top: 25px;
	margin : 20px;
	cursor:pointer;
	border-radius:5px;
}

.mypageNaviBtn:hover{
    background-color : white;
}
</style>
</head>
<body>

	<div class="container naviContainer">
		<div class="row myPageNavi_titleDiv">
			<div class="col">
				<h3>마이페이지</h3>
			</div>
		</div>
		
		<div class="row myPageNavi_btnDiv d-flex justify-content-center">
				<div class="d-sm-none d-md-block col-md-1 col-lg-1"></div>
				<div class="col-1 mypageNaviBtn"id="btn_ToShowMember">
					<div><b>Profile</b></div>
					<div>회원 정보</div>
				</div>
				
			<div class="col-1 mypageNaviBtn" id="btn_ToOrderPage">
				<div><b>Oreder</b></div>
				<div>주문 내역</div>
			</div>
			
				<div class="col-1 mypageNaviBtn" id="btn_ToMyBasket">
					<div><b>Cart</b></div>
				<div>장바구니</div>
				</div>

			<div class="col-1 mypageNaviBtn" id="btn_ToMyInquiry">
				<div><b>QnA</b></div>
				<div>문의현황</div>
			</div>

			<div class="col-1 mypageNaviBtn" id="btn_ToMyCheck">
				<div><b>Check</b></div>
				<div>출석체크</div>
			</div>
					<div class="d-sm-none d-md-block col-md-1 col-lg-1"></div>
		</div> 

	</div>
	
	<script>
		// 회원정보조회 페이지로
		$("#btn_ToShowMember").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/toMypageHome");
		});
	
		// 주문내역조회 페이지로
		$("#btn_ToOrderPage").on("click", function(){
			let deal_status = "전체";
			$(location).attr("href", "${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status="+deal_status+"&currentPage=1");
		});
		
		// 장바구니조회 페이지로
		$("#btn_ToMyBasket").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/order/toBasket");
		});
		
		// 문의현황조회 페이지로
		$("#btn_ToMyInquiry").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/enquiry/toEnquiryList");
		});
		
		// 출석체크현황 페이지로
		$("#btn_ToMyCheck").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=0");
		});
		
	</script>
	
</body>

</html>