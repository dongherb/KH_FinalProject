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
	<!-- 폰트 시작 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
<!-- 폰트 끝 -->
<title>MOOD & STYLE</title>
<style>
* {
	box-sizing: border-box;
}

.section-1{
margin : 25px;
}

/*헤더 로고 폰트*/
.section-1>.top-header-font {
	font-family: 'Abril Fatface', cursive;
	font-size: 40px;
	text-align: center;
	margin-left: 80px;  
}

#navbarSupportedContent>.header-font {
	font-size: 12px;
	color: black;
	text-align: right;
}

.header-font>.header-navbar {
	white-space: nowrap;
}

.navbar .navbar-collapse {
	text-align: right;
}

/*헤더 검색 버튼*/
#hearderSearchBtn {
	background-color: #bebebe;
}

.btn-outline-success {
	color: palevioletred;
	border: rgb(255, 255, 255)
}

.button.btn.btn-outline-success {
	background-color: rgb(228, 210, 228);
}

/*장식용 언더라인*/
.hr.underline {
	border-bottom: 0px;
	text-align: left;
}

.section-2 {
	display: inline-block;
	border-top: 1px solid #dbdbdb;
	border-bottom: 1px solid #dbdbdb;
	padding-top: 15px;
	padding-bottom: 15px;
	margin-bottom: 40px;
}

/*카테고리 a태그 효과*/
.menu-second>a {
	font-size: 12px;
	font-weight: 1000;
	color: black;
	position: relative;
	display: inline-block;
	transition: .3s;
}

.menu-second>a::after {
	position: absolute;
	bottom: .3em;
	left: 0;
	content: '';
	width: 100%;
	height: 1px;
	background-color: #dbdbdb;
	opacity: 0;
	transition: .3s;
}

.menu-second>a:hover::after {
	bottom: 0;
	opacity: 1;
}
</style>
</head>
<body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid section-1">
				<div class="d-md-none d-lg-block col-lg-3 col-xl-2"></div>				
					<a class="navbar-brand top-header-font" href="${pageContext.request.contextPath}/">Mood & Style</a>					
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>

				<div class="d-flex justify-content-end">
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
					
					<ul class="navbar-nav ml-auto mb-2 mb-lg-0 header-font">
						<c:choose>
							<c:when test="${!empty loginSession}">
								<c:if test="${loginSession.manager_yn eq 'y'}">
									<li class="nav-item header-navbar"><a class="nav-link" id="managerBtn" href="${pageContext.request.contextPath}/toManagerPage">관리자페이지</a></li>
								</c:if>
								<li class="nav-item header-navbar"><a class="nav-link" id="logoutnBtn" href="${pageContext.request.contextPath}/member/toLogout.do">로그아웃</a></li>
							
							</c:when>
							<c:otherwise>
								<li class="nav-item header-navbar"><a class="nav-link" id="loginBtn" href="${pageContext.request.contextPath}/member/toLoginPage">로그인</a></li>
							</c:otherwise>
						</c:choose>
						<li class="nav-item search">
							<div class="input-group input-group-sm mb-3">
								<input class="form-control input-sm" id="hearderSearchInput" type="search" placeholder="상품명/카테고리" aria-label="Search" aria-describedby="hearderSearchBtn" value="${keyword}" >
								<button class="btn btn-outline-secondary" type="button" id="hearderSearchBtn">검색</button>
							</div>
						</li>
						
					</ul>
				</div>
			</div>
		</div>			
	</nav>
	
	<div class="container-fluid section-2 ">
			<ul class="nav justify-content-center">
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductList?product_category=All&currentPage=1" class="option">제품 목록</a>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toInsertProduct" class="option">제품 등록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/order/toOrderList?currentPage=1" class="option">주문 현황</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/member/toMemberList?currentPage=1" class="option">회원 목록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/report/toReportList?currentPage=1" class="option">신고 목록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/notice/toNoticeList?currentPage=1" class="option">공지사항 목록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/notice/toInsertNotice" class="option">공지사항 등록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/enquiry/toMangerEnquiryList" class="option">문의사항 목록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/advertisement/toInsertAd" class="option">광고 등록</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/advertisement/toDeleteAd" class="option">광고 삭제</a></li>
			</ul>
	</div>

	<script>
		// 검색 버튼 클릭 시
		$("#hearderSearchBtn").on("click", function(){
			let product_category = "전체";
			let detail_category = "전체";
			let option = "";
			let keyword = $("#hearderSearchInput").val();
			
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
		});
		
		// 검색창에서 엔터 입력 시
		$("#hearderSearchInput").keyup(function(e){			
			if(e.keyCode == 13){
				let product_category = "전체";
				let detail_category = "전체";
				let option = "";
				let keyword = $("#hearderSearchInput").val();
				
				$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
			}
		});
	</script>


</body>
</html>