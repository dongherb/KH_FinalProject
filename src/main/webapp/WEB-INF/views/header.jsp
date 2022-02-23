<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
padding : 25px;
}

/*헤더 로고 폰트*/
.section-1>.top-header-font {
	font-family: 'Abril Fatface', cursive;
	font-size: 40px;
	text-align: center;
	/*font-weight: lighter;*/
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
	background-color: red;
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
				<div class="d-md-none d-lg-block col-lg-3 col-xl-4"></div>
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
						<li class="nav-item header-navbar"><a class="nav-link" id="moveMypageBtn" href="${pageContext.request.contextPath}/mypageHome/toMypageHome">마이페이지</a></li>
						<li class="nav-item header-navbar"><a class="nav-link" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=&currentPage=1">주문내역</a></li>
						<li class="nav-item header-navbar"><a class="nav-link" href="${pageContext.request.contextPath}/order/toBasket">장바구니</a></li>
						<li class="nav-item header-navbar"><a class="nav-link" href="${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=0">출석체크</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item header-navbar" href="${pageContext.request.contextPath}/notice/toNoticeList_user?currentPage=1">공지사항</a></li>
								<li><a class="dropdown-item header-navbar" href="${pageContext.request.contextPath}/enquiry/toEnquiryList">문의사항</a></li>
							</ul>
						</li>

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
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=전체&detail_category=&keyword=&currentPage=1"><font color="#ff761a">New</font></a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=전체&detail_category=&keyword=&option=avg_score&currentPage=1"><font color="#3585d7">Best</font></a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=아우터&detail_category=&keyword=&currentPage=1">Outer</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=상의&detail_category=&keyword=&currentPage=1">Top</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=하의&detail_category=&keyword=&currentPage=1">Bottom</a></li>
				<li class="nav-item menu-second"><a class="nav-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=신발&detail_category=&keyword=&currentPage=1">Shoe</a></li>
			</ul>
		</div>

	<script>
		// 검색 버튼 클릭 시
		$("#hearderSearchBtn").on("click", function(){
			
			if(($("#hearderSearchInput").val()).length < 2){
				alert("최소 2자 이상의 키워드를 입력해주세요.");
				return;
			}
			else if(($("#hearderSearchInput").val()).length > 10){
				alert("10자 이내의 키워드를 입력해주세요.");
				return;
			}
			
			let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
			if(!searchRegx.test($("#hearderSearchInput").val())){
				
				let product_category = "전체";
				let detail_category = "전체";
				let option = "";
				let keyword = $("#hearderSearchInput").val();
				
				$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
			}
			else{
				alert("특수문자를 포함할 수 없습니다.");
				$("#hearderSearchInput").val("");
			}
			
		});
		
		// 검색창에서 엔터 입력 시
		$("#hearderSearchInput").keyup(function(e){		

			if(e.keyCode == 13){
				
				if(($("#hearderSearchInput").val()).length < 2){
					alert("최소 2자 이상의 키워드를 입력해주세요.");
					return;
				}
				else if(($("#hearderSearchInput").val()).length > 10){
					alert("10자 이내의 키워드를 입력해주세요.");
					return;
				}
				
				let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
				if(!searchRegx.test($("#hearderSearchInput").val())){
					
					let product_category = "전체";
					let detail_category = "전체";
					let option = "";
					let keyword = $("#hearderSearchInput").val();
					
					$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
				}
				else{
					alert("특수문자를 포함할 수 없습니다.");
					$("#hearderSearchInput").val("");
				}
			}
			
		});
		
	</script>


</body>
</html>