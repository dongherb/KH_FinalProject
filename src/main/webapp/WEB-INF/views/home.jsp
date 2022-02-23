<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>MOOD & STYLE</title>
<style>

/*슬라이드 메인 여백제거*/
#carouselExampleIndicators{
  padding: 0px;
  margin-top: 0px;
}

/*슬라이드 이미지 조절*/
.titleImage > img{
  padding: 0px;
  width: 100%;
  height: 100%;
  margin: auto;
}

/*제품 전체 폰트*/
.product > a {
  text-decoration: none;
  color: #474554;
}

/*제품 전체 여백 */
.section-4, .section-5, .section-6, .section-7, .section-8{
  margin-top: 5%;
}

.product{
  padding:5px;
}

/*상품 h태그*/
.title > h2{
  font-size: 25px;
}

/*상품 p태그*/
.card-title{
  font-weight: bolder;
  font-size:15px;
  margin-bottom: 0px;
}

.card-price{
  font-weight: bold;
  font-size: 13px;
  margin-bottom: 1px;
}

.card-discount{
  font-size: 13px;
}

.card-content{
  font-size: 11.5px;
  color: darkgrey;
}

.card-score{
  font-size: 11.5px;
  margin-bottom: 0%;
}

.product > .card-body{
  height: 200px;
  margin-bottom: -8%;
}

/*더보기 공통사항*/
.more-btn{
	text-align: center;
}
.more-btn > button{
 margin-top: 2%;
 padding: 1%;
 font-size: 13px;
}

/*날씨 옷차림 내용*/
.section-5{
	padding-top: 20px;
	padding-bottom: 15px;
	text-shadow: 1px 1px 1px white;
	font-weight: bold;
}
#section-5Back{
	background-image : linear-gradient( rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7) ), url('${pageContext.request.contextPath}/resources/images/back_basic.gif');
	background-repeat : no-repeat;
    background-size : cover;
}

.weather > .weather-content{
  height: 80%;
  margin-top: 0.75%;
}

.weather-content .sky_img{
	height: 50px;
}

.weather-group{
  margin: 1%;
  padding: 0%;
}
.weather-group img{
  height: 160px;
  opacity: 0.8;
  box-shadow: 1px 1px 1px 1px gray;
  transition: 0.3s;
}
.weather-group img:hover{
  opacity: 1;
  transform: scale(1.03);
}

/* section-6 */
.section-6{
	margin-top: 100px;
}

/*테마 전체 배경*/
.section-7{
  background-color: #ece6e6;
  margin-bottom: 2%;
  padding-bottom: 2%;
}

/*테마 타이틀*/
.theme-title{
  text-align: center;
  font-size:40px;
  font-weight:600;
  margin: 0%;
  padding : 35px;
}

/*테마*/
.theme-group {
  padding: auto;
}
.theme-group > a > span{
font-size: 16px;
 font-style: italic;
 
}

/*테마 이미지 테두리*/
.theme-group > a > img{
  border : 0.5px solid thistle;
  border-radius: 2%;
}

/*테마 a태그*/
.theme-group > a{
  font-size: 20px;
  font-weight: 600;
  text-decoration: none;
  color: #474554;
}

/*리뷰 회색배경(전체) 여백*/
.section-9{
    background-color: rgb(240, 240, 240);
    padding-bottom: 2%;
    margin-top: 5%;
}

/*리뷰 h2 타이틀*/
.review-title{
  text-align: center;
  padding-top: 2.5%;
}

/*리뷰 그룹(묶음) 간격 */
.review > .group-review{
  margin: 2.5%;
  
}

</style>
</head>
<body>

<%@include file="header.jsp" %>
<%@include file="sideBar.jsp" %>

  <!--카드 슬라이드-->
  <div class="container-fluid section-3">
  <div class="row titleImage">
    <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active" data-bs-interval="1500">
                <img src="${pageContext.request.contextPath}/resources/image/slide1.png" class="d-block w-100">
                <div class="carousel-caption d-none d-md-block">
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="1500">
                <img src="${pageContext.request.contextPath}/resources/image/slide2.png" class="d-block w-100">
                <div class="carousel-caption d-none d-md-block">
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="1500">
                <img src="${pageContext.request.contextPath}/resources/image/slide3.png" class="d-block w-100">
                <div class="carousel-caption d-none d-md-block">
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="1500">
              <img src="${pageContext.request.contextPath}/resources/image/slide4.png" class="d-block w-100">
              <div class="carousel-caption d-none d-md-block">
              </div>
          </div>
        </div>
    </div>
</div>
</div>

<!--신상품(new)-->
<div class="container section-4">
<div class="row new-title">
  <h2>NEW ARRIVALS</h2>
  <div class="col col4">
    <div class="row row-cols-2 row-cols-md-4 g-4">
    
	    <!-- 리스트로 -->
	    <c:forEach items="${newArrivals}" var="newArrival">
	    
	      <div class="col product">
	        <a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${newArrival.product_code}">
	          <div class="card h-100">
	            <div id="carouselExampleIndicators" class="carousel slide new-card" data-bs-ride="carousel">
	              <div class="carousel-inner">
	                <div class="carousel-item active" data-bs-interval="2200">
	                  <img src="${pageContext.request.contextPath}/product_img/${newArrival.product_img}" class="d-block w-100" style="height: 400px;">
	                </div>
	                <div class="carousel-item">
	                  <img src="${pageContext.request.contextPath}/product_img/${newArrival.product_img}" class="d-block w-100" style="height: 400px;">
	                </div>
	              </div>
	            </div>
	            <div class="card-body">
					<p class="card-title">${newArrival.product_name}</p>
					<c:choose>
						<c:when test="${newArrival.discount ne 0}">
							<p class="card-price">
								${Math.round( newArrival.price - (newArrival.price * (newArrival.discount / 100)) )}원
								<span style="text-decoration: line-through; color: rgb(180, 180, 180);">${newArrival.price}원</span>
								<br><span style="color: rgb(255,100,100);">${newArrival.discount}%&nbsp;SALE</span>
							</p>
						</c:when>
						<c:otherwise>
							<p class="card-price">${newArrival.price}원
								<br>&nbsp;
							</p>
						</c:otherwise>
					</c:choose>
					<p class="card-content">${newArrival.product_content} </p>
					<c:choose>
						<c:when test="${newArrival.avg_score eq 0}">
							<p class="card-score" style="color: gray;">별점없음</p>
						</c:when>
						<c:otherwise>
							<p class="card-score">평점 : ${String.format("%.2f", newArrival.avg_score)} (${newArrival.review_count})</p>
						</c:otherwise>
					</c:choose>
	            </div>
	          </div>
	        </a>
	      </div>
	      
		</c:forEach>
   	</div>

    <div class="row">       
      <div class="d-none d-lg-block more-btn">
      	<button type="button" class="btn btn-dark btn-sm newBtn" id="newBtn">신상품 더 보러가기 >></button>         
      </div>
    </div>

  </div>
</div>
</div>

<!--날씨(weather)-->
<div class="container-fluid" id="section-5Back">
	<div class="container section-5">
	  <div class="weather-title" id="weather-title">
	    <h2>STYLE BY WEATHER</h2>
	  </div>
	  <div class="row weather">
	    <div class="col-12 col-lg-3 weather-content">
	      <p class="weather-header" id="weather-header">실시간기온별 옷차림 추천!</P>
	      <P class="weather-body" id="weather-body">
	      	<c:choose>
	      		<c:when test="${!empty loginSession}">
	      			<strong style="font-size: 1.2rem">${firstAddress}</strong>의 온도는
	      		</c:when>
	      		<c:otherwise>오늘의 온도는(서울)</c:otherwise>
	      	</c:choose>
	      </P>
	      <p class="weather-temperature" id="weather-temperature"><span style='font-size: 6rem;'>없음</span></p>
	      <p class="weather-suggest" id="weather-suggest">온도에 맞는 옷을 추천드려요!</p>
	    </div>
	
	    <div class="col-12 col-lg-9">
	      <div class="row">
	          <div class="col weather-group" id="product0Div"></div>
	          <div class="col weather-group" id="product1Div"></div>
	      </div>
	      
	      <div class="row">
	          <div class="col weather-group" id="product2Div"></div>
	      	  <div class="col weather-group" id="product3Div"></div>
	     </div>
	  </div>
	 </div>
	</div>
</div>

  <!--베스트 아이템(best)-->
  <div class="container section-6">
    <div class="row product-title">
      <h2>BEST ITEMS</h2>
      <div class="col col4">
        <div class="row row-cols-2 row-cols-md-4 g-4">
        
           <c:forEach items="${bestItems}" var="bestItem">
		    <c:if test="${bestItem.review_count ne 0}">
		    
		      <div class="col product">
		        <a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${bestItem.product_code}">
		          <div class="card h-100">
		            <div id="carouselExampleIndicators" class="carousel slide new-card" data-bs-ride="carousel">
		              <div class="carousel-inner">
		                <div class="carousel-item active" data-bs-interval="2200">
		                  <img src="${pageContext.request.contextPath}/product_img/${bestItem.product_img}" class="d-block w-100" style="height: 400px;">
		                </div>
		                <div class="carousel-item">
		                  <img src="${pageContext.request.contextPath}/product_img/${bestItem.product_img}" class="d-block w-100" style="height: 400px;">
		                </div>
		              </div>
		            </div>
		            <div class="card-body">
						<p class="card-title">${bestItem.product_name}</p>
						<c:choose>
							<c:when test="${bestItem.discount ne 0}">
								<p class="card-price">
									${Math.round( bestItem.price - (bestItem.price * (bestItem.discount / 100)) )}원
									<span style="text-decoration: line-through; color: rgb(180, 180, 180);">${bestItem.price}원</span>
									<br><span style="color: rgb(255,100,100);">${bestItem.discount}%&nbsp;SALE</span>
								</p>
							</c:when>
							<c:otherwise>
								<p class="card-price">${bestItem.price}원
									<br>&nbsp;
								</p>
							</c:otherwise>
						</c:choose>
						<p class="card-content">${bestItem.product_content} </p>
						<c:choose>
							<c:when test="${bestItem.avg_score eq 0}">
								<p class="card-score" style="color: gray;">별점없음</p>
							</c:when>
							<c:otherwise>
								<p class="card-score">평점 : ${String.format("%.2f", bestItem.avg_score)} (${bestItem.review_count})</p>
							</c:otherwise>
						</c:choose>
		            </div>
		          </div>
		        </a>
		      </div>
		      
		      </c:if>
			</c:forEach>
          
        </div>
    
        <div class="row">       
          <div class="d-none d-lg-block more-btn">
          <button type="button" class="btn btn-dark btn-sm bestBtn" id="bestBtn">BEST제품 더 보러가기 >></button>     
          </div>
        </div>
      </div>
    </div>
    </div>

    <!--테마(theme) -->
    <div class="container-fluid section-7">
      <div class="container theme">
        <div class="theme-title">
          <div>THEME</div>
        </div>
        <div class="row theme">
          <div class="col">
            <div class="row">
              <div class="col theme-group"  style="margin-top:50px;">
                <a href="${pageContext.request.contextPath}/product/toProductShopList?product_category=아우터&detail_category=코트&keyword=&option=&currentPage=1">
                  <img class="w-100" style="height: 600px;" src="${pageContext.request.contextPath}/resources/image/theme3.jpg">
                <span>#코트</span>
              </a>
              </div>
       
              <div class="col theme-group" style="margin-top:100px;">
                <a href="${pageContext.request.contextPath}/product/toProductShopList?product_category=상의&detail_category=셔츠&keyword=&option=&currentPage=1">
                <img class="w-100" style="height: 300px;" src="${pageContext.request.contextPath}/resources/image/theme2.jpg">
                   <span>#셔츠</span>
                </a>
                <a href="${pageContext.request.contextPath}/product/toProductShopList?product_category=신발&detail_category=운동화&keyword=&option=&currentPage=1">
                <img class="w-100" style="height: 200px;" src="${pageContext.request.contextPath}/resources/image/theme1.jpg">
                   <span>#운동화</span>
                </a>
            </div>
  
              <div class="col theme-group" style="margin-top:50px;">
                <a href="${pageContext.request.contextPath}/product/toProductShopList?product_category=상의&detail_category=맨투맨&keyword=&option=&currentPage=1">
                <img class="w-100" style="height: 300px;" src="${pageContext.request.contextPath}/resources/image/theme4.jpg">
                  <span>#맨투맨</span>
                </a>
                <a href="${pageContext.request.contextPath}/product/toProductShopList?product_category=하의&detail_category=면바지&keyword=&option=&currentPage=1">
                <img class="w-100" style="height: 300px;" src="${pageContext.request.contextPath}/resources/image/BOT-27121_SQ2.jpg">
                    <span>#일상에서도 편안한 면바지</span>
                </a>
            </div>
  
          </div>
          </div>
        </div>
    </div>

    </div>

<!--신발(shoe)-->
<div class="container section-8">
  <div class="row title">
    <h2>SHOE</h2>
    <div class="col col4">
      <div class="row row-cols-2 row-cols-md-4 g-4">
      
        <c:forEach items="${shoes}" var="shoe">
		    <c:if test="${shoe.review_count ne 0}">
		    
		      <div class="col product">
		        <a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${shoe.product_code}">
		          <div class="card h-100">
		            <div id="carouselExampleIndicators" class="carousel slide new-card" data-bs-ride="carousel">
		              <div class="carousel-inner">
		                <div class="carousel-item active" data-bs-interval="2200">
		                  <img src="${pageContext.request.contextPath}/product_img/${shoe.product_img}" class="d-block w-100" style="height: 400px;">
		                </div>
		                <div class="carousel-item">
		                  <img src="${pageContext.request.contextPath}/product_img/${shoe.product_img}" class="d-block w-100" style="height: 400px;">
		                </div>
		              </div>
		            </div>
		            <div class="card-body">
						<p class="card-title">${shoe.product_name}</p>
						<c:choose>
							<c:when test="${shoe.discount ne 0}">
								<p class="card-price">
									${Math.round( shoe.price - (shoe.price * (shoe.discount / 100)) )}원
									<span style="text-decoration: line-through; color: rgb(180, 180, 180);">${shoe.price}원</span>
									<br><span style="color: rgb(255,100,100);">${shoe.discount}%&nbsp;SALE</span>
								</p>
							</c:when>
							<c:otherwise>
								<p class="card-price">${shoe.price}원
									<br>&nbsp;
								</p>
							</c:otherwise>
						</c:choose>
						<p class="card-content">${shoe.product_content} </p>
						<c:choose>
							<c:when test="${shoe.avg_score eq 0}">
								<p class="card-score" style="color: gray;">별점없음</p>
							</c:when>
							<c:otherwise>
								<p class="card-score">평점 : ${String.format("%.2f", shoe.avg_score)} (${shoe.review_count})</p>
							</c:otherwise>
						</c:choose>
		            </div>
		          </div>
		        </a>
		      </div>
		      
		      </c:if>
			</c:forEach>
  
      </div>
  
      <div class="row">       
        <div class="d-none d-lg-block more-btn">
        <button type="button" class="btn btn-dark btn-sm shoeBtn" id="shoeBtn">SHOE 더 보러가기 >></button>      
        </div>
      </div>
  
    </div>
  </div>
  </div>  

      <!--리뷰-->
	<div class="container d-lg-block section-9"> 
	
        <div class="review-title">
          	<h2>REVIEW</h2>
        </div>
      	<div class="card-group review">
      		<!-- 리스트로 -->
	      	<c:forEach items="${latestReviews}" var="latestReview">
	      	
		        <div class="card group-review">
		          	<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${latestReview.product_code}">
		          		<img src="${pageContext.request.contextPath}/review_img/${latestReview.review_img}" class="card-img-top" style="height: 400px;">
		          	</a>
		        	<div class="card-body">
			            <p class="card-title ">${latestReview.content}</p>
			            <p class="card-score">평점 : ${String.format("%.2f", latestReview.score)}</p>
		          	</div>
		        </div>
		        
			</c:forEach>
       	</div>
	</div>
    
<%@include file="footer.jsp" %>

<script>

	// 신상품 더보기 클릭 시
	$("#newBtn").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category=전체&detail_category=&keyword=&currentPage=1");
	});
	
	// 베스트 더보기 클릭 시
	$("#bestBtn").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category=전체&detail_category=&keyword=&option=avg_score&currentPage=1");
	});
	
	// 신발 더보기 클릭 시
	$("#shoeBtn").on("click", function(){
		$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category=신발&detail_category=&keyword=&currentPage=1");
	});


	// 기상청 데이터를 받아서 append 시킴
	let items = ${jsonForecast}.response.body.items.item;
	for(let item of items){
		
		// 기온
		if(item.category == 'TMP'){		// 기온
			let fcstTime = (item.fcstTime).substring(0, 2);		// 기준시각 : 20시
			let temperature = item.fcstValue;

			$("#weather-body").append("<span style='font-size: 0.8rem;'> / UPDATE_"+fcstTime+":00 </span>")
			$("#weather-temperature").html("<span style='font-size: 6rem;'>"+temperature+"도</span>");
			
			if(temperature <= 5) {
				// 설정한 광고에 맞춰서 이미지를 띄움 // cold
				<c:forEach var="i" begin="0" end="3">
					<c:choose>
						<c:when test="${advermtCold[i] eq null}">
							$("#product${i}Div").html("");
						</c:when>
						<c:otherwise>
							$("#product${i}Div").html('<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${advermtCold[i].product_code}">'
									+'<img src="${pageContext.request.contextPath}/product_img/${advermtCold[i].product_img}" class="d-block w-100">'
								+'</a>');
						</c:otherwise>
					</c:choose>
	       		</c:forEach>
			}
			
			else if (temperature <= 20) {
				// 설정한 광고에 맞춰서 이미지를 띄움 // normal
				<c:forEach var="i" begin="0" end="3">
					<c:choose>
						<c:when test="${advermtNormal[i] eq null}">
							$("#product${i}Div").html("");
						</c:when>
						<c:otherwise>
							$("#product${i}Div").html('<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${advermtNormal[i].product_code}">'
									+'<img src="${pageContext.request.contextPath}/product_img/${advermtNormal[i].product_img}" class="d-block w-100">'
								+'</a>');
						</c:otherwise>
					</c:choose>
	       		</c:forEach>
			}
			
			else{
				// 설정한 광고에 맞춰서 이미지를 띄움 // hot
				<c:forEach var="i" begin="0" end="3">
					<c:choose>
						<c:when test="${advermtHot[i] eq null}">
							$("#product${i}Div").html("");
						</c:when>
						<c:otherwise>
							$("#product${i}Div").html('<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${advermtHot[i].product_code}">'
									+'<img src="${pageContext.request.contextPath}/product_img/${advermtHot[i].product_img}" class="d-block w-100">'
								+'</a>');
						</c:otherwise>
					</c:choose>
	       		</c:forEach>
			}
		}
		
		// 풍속
		if(item.category == 'WSD'){
			let windsd = "<br><span style='font-size: 1rem;'> (풍속: "+item.fcstValue+"m/s)</span>";
			$("#weather-temperature").append(windsd);
		}
		
		// 구름상태
		if(item.category == 'SKY'){		// 하늘상태1
			let sky_img = "";
			if((item.fcstValue) == 0){	// 맑음
				sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_sun.png" class="sky_img"> (맑음)';
				$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.6), rgba(255, 255, 255, 0.6) ), url('${pageContext.request.contextPath}/resources/images/back_sun.gif')"});
			}
			else if((item.fcstValue) == 1){		// 구름적음
				sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_sunClound.png" class="sky_img"> (구름적음)';
				$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5) ), url('${pageContext.request.contextPath}/resources/images/back_sun.gif')"});
			}
			else if((item.fcstValue) == 2){		// 구름많음
				sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_sunClound.png" class="sky_img"> (구름많음)';
				$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5) ), url('${pageContext.request.contextPath}/resources/images/back_cloud.gif')"});
			}
			else{	// 흐림
				sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_clound.png" class="sky_img"> (흐림)';
				$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5) ), url('${pageContext.request.contextPath}/resources/images/back_cloud.gif')"});
			}
			$("#weather-suggest").html("현재 날씨 &nbsp;&nbsp;" + sky_img);
		}
		
		// 기후상태
		if(item.category == 'PTY'){		// 하늘상태2 (강수형태에 따라 이미지 덮어씌우기)
			
			if((item.fcstValue) == 0){	// 강수 없을 경우 (맑음)
				
			}
			else {	// 강수가 있을 경우에만 동작 (맑음이 아닐경우)
				let sky_img = "";
				if((item.fcstValue) == 1){		// 비
					sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_rain.png" class="sky_img"> (비)';
					$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3) ), url('${pageContext.request.contextPath}/resources/images/back_rain.gif')"});
				
					// 설정한 광고에 맞춰서 이미지를 띄움 // rain
					<c:forEach var="i" begin="0" end="3">
						<c:choose>
							<c:when test="${advermtRain[i] eq null}">
								$("#product${i}Div").html("");
							</c:when>
							<c:otherwise>
								$("#product${i}Div").html('<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${advermtRain[i].product_code}">'
										+'<img src="${pageContext.request.contextPath}/product_img/${advermtRain[i].product_img}" class="d-block w-100">'
									+'</a>');
							</c:otherwise>
						</c:choose>
		       		</c:forEach>
				}
				else if((item.fcstValue) == 2){		// 비/눈
					sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_snow.png" class="sky_img"> (비/눈)';
					$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5) ), url('${pageContext.request.contextPath}/resources/images/back_snow.gif')"});
					
				}
				else if((item.fcstValue) == 3) {	// 눈
					sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_snow.png" class="sky_img"> (눈)';
					$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5) ), url('${pageContext.request.contextPath}/resources/images/back_snow.gif')"});
					
				}
				else if((item.fcstValue) == 4){	// 소나기
					sky_img = '<img src="${pageContext.request.contextPath}/resources/images/sky_rain.png" class="sky_img"> (소나기)';
					$("#section-5Back").css({"background-image": "linear-gradient( rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3) ), url('${pageContext.request.contextPath}/resources/images/back_rain.gif')"});
				
					// 설정한 광고에 맞춰서 이미지를 띄움 // rain
					<c:forEach var="i" begin="0" end="3">
						<c:choose>
							<c:when test="${advermtRain[i] eq null}">
								$("#product${i}Div").html("");
							</c:when>
							<c:otherwise>
								$("#product${i}Div").html('<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${advermtRain[i].product_code}">'
										+'<img src="${pageContext.request.contextPath}/product_img/${advermtRain[i].product_img}" class="d-block w-100">'
									+'</a>');
							</c:otherwise>
						</c:choose>
		       		</c:forEach>
				}
				$("#weather-suggest").html("현재 날씨 &nbsp;&nbsp;" + sky_img);
			}
		}
		

	}
	

</script>

</body>
</html>