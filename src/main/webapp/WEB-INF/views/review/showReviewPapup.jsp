<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- 폰트 시작 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
<!-- 폰트 끝 -->
	<meta charset="UTF-8">
	<title>리뷰보기</title>
	
	<style>
		body{
			overflow: hidden;
		}
	
		.reviewContainer{
			margin-top: 20px;
		}
		.headerContainer{
			height: 20px;
			background-color: rgb(230, 230, 230);
		}
		.footerContainer{
			height: 150px;
			background-color: rgb(230, 230, 230);
		}
		
		.reviewContainer .productImgDiv{
			text-align: center;
			margin-bottom: 20px;
		}
		.reviewContainer .productInfoContainer{
			padding: 10px;
			margin-bottom: 50px;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
		}
		
		.reviewContainer .productInfoContainer img{
			height: 110px;
			width: 100%;
		}
		
		.borderDiv{
			border-top: 1px solid rgb(230, 230, 230);  
			height: 50px;
		}


		.reviewInfoContainer{
			padding: 10px;
			margin-bottom: 40px;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
		}
		.reviewInfoContainer .reviewImgDiv img{
			height: 110px;
			width: 100%;
		}
		.reviewInfoContainer .scoreImgDiv img{
			height: 10px;
		}
		
		.cancelBtnDiv{
			text-align: right;
			margin-bottom: 50px;
		}
		.productImgDiv>.top-header-font {
	font-family: 'Abril Fatface', cursive;
	font-size: 30px;
	text-align: center;
	margin:10px;
}
		
	</style>
	
</head>
<body>

	<c:if test="${exsit eq 'none'}">
		<script>
			alert("리뷰정보가 없습니다.");
			window.close();
		</script>
	</c:if>
	<div class="container-fluid headerContainer"></div>

	<div class="container reviewContainer">

		<div class="row productImgDiv">
				<div class="col top-header-font">
				Mood & Style
			</div>
		</div>
	
		<div class="row">
			<div class="col">
				<h3>상품정보</h3>
			</div>
		</div>
		<div class="row productInfoContainer bg-light">
		
			<div class="col-3">
				<img src="${pageContext.request.contextPath}/product_img/${productDTO.product_img}">
			</div>
			
			<div class="col-9">
				<div class="row">
					<div class="col">
						<span style="font-size: 1.1rem; font-weight: bold;">${productDTO.product_name}</span>
						<span style="font-size: 0.8rem;"> / ${productDTO.product_category}</span>
					</div>
				</div>
				<div class="row">
					<div class="col">
						${ Math.round( productDTO.price - (productDTO.price * (productDTO.discount / 100)) ) }원
					</div>
				</div>
				
				<div class="row" style="font-size: 0.5rem;"><br></div>
				
				<div class="row">
					<div class="col">
						⭐ ${String.format("%.2f", productDTO.avg_score)}
					</div>
				</div>
				<div class="row">
					<div class="col" style="font-size: 0.9rem;">
						리뷰 ${productDTO.review_count}개
					</div>
				</div>
			</div>
			
		</div>
		
		<div class="row borderDiv"></div>
	
		<div class="row">
			<div class="col">
				<h3>나의 리뷰</h3>
			</div>
		</div>
		<div class="row reviewInfoContainer bg-light">
			<div class="col-9">
			
				<div class="row">
					<div class="col">
						<span style="font-size: 0.85rem; color: rgb(70, 70, 70);">${reviewDTO.id}</span>
						<span style="font-size: 0.75rem; color: rgb(120, 120, 120);"> / ${reviewDTO.written_date}</span>
					</div>
				</div>
				
				<div class="row scoreImgDiv">
					<div class="col" style="font-size: 0.8rem;">
						<c:forEach var="i" begin="1" end="${reviewDTO.score}">
							<span><img src="${pageContext.request.contextPath}/resources/images/OneStarPoint.png"></span>
						</c:forEach>
						<c:forEach var="i" begin="${reviewDTO.score + 1}" end="5">
							<span><img src="${pageContext.request.contextPath}/resources/images/blackStar.png"></span>
						</c:forEach>
						${reviewDTO.score}
					</div>
				</div>

				<div class="row">
					<div class="col" style="margin-top: 5px;">${reviewDTO.content}</div>
				</div>
				
			</div>
			
			<div class="col-3 reviewImgDiv">
				<c:if test="${reviewDTO.review_img ne null}">
					<img src="${pageContext.request.contextPath}/review_img/${reviewDTO.review_img}">
				</c:if>
			</div>
		</div>
		
		<div class="row cancelBtnDiv">
			<div class="col">
				<button type="button" class="btn btn-secondary btn-sm" id="cancelReviewBtn">닫기</button>
			</div>
		</div>
	
	</div>

	<div class="container-fluid footerContainer"></div>
	
	<script>
	
		// 닫기버튼 클릭 시
		$("#cancelReviewBtn").on("click", function(){
			window.close();	
		})
		
	
	</script>

</body>
</html>