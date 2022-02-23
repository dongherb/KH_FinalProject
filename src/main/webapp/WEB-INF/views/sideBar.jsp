<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>사이드바</title>
	
	<style>
		
		.sideBarContainer{
			position: fixed;
			bottom: 50px;
			left: 90%;
			z-index: 100;
		}
		
		.sideBarContent .sideBarRow{
			margin-top: 15px;
		}
		.sideBarContent .sideBarImg{
			border-radius: 50px;
			height: 40px;
			width: 40px;
			background-color: white;
		}
		
		.sideBarContent .sideBarToProduct{
			cursor: pointer;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
			transition: 0.3s;
		}
		.sideBarContent .sideBarToProduct:hover{
			opacity: 0.8;
			transform: scale(1.1);
		}
		
		.sideBarContent #sideBarToTop{
			cursor: pointer;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
			transition: 0.3s;
		}
		.sideBarContent #sideBarToTop:hover{
			transform: scale(1.1);
		}

		
	</style>
	
</head>
<body>

	<div class="container sideBarContainer">
	
		<div class="row">

			<div class="col sideBarContent">
				
				<c:if test="${!rencentViews.isEmpty()}">
					<div class="row">
						<div class="col" style="text-shadow: 1px 1px 1px rgb(255, 255, 255);">
							<span style="font-size: 0.65rem; font-weight: bold;">최근조회</span>
						</div>
					</div>
				</c:if>
				
				<c:forEach items="${rencentViews}" var="rencentView">
					<div class="row sideBarRow">
						<div class="col">
							<img class="sideBarImg sideBarToProduct" sideValue="${rencentView.product_code}" src="${pageContext.request.contextPath}/product_img/${rencentView.product_img}">
						</div>
					</div>
				</c:forEach>


				<div class="row sideBarRow">
					<div class="col">
						<img class="sideBarImg" id="sideBarToTop" src="${pageContext.request.contextPath}/resources/images/top.png">
					</div>
				</div>
			</div>

		</div>
		
	</div>

	<script>
		// 사이드바의 이미지 클릭 시
		$(".sideBarToProduct").on("click", function(e){
			let product_code = (e.target).getAttribute('sideValue');
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductDetail?product_code="+product_code);
		});
		
		// 위로가지 이미지 클릭 시
		$("#sideBarToTop").on("click", function(){
			$(location).attr("href", "#");
		});
	
	
	</script>

</body>
</html>