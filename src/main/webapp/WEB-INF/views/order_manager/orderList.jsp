
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
<title>주문 내역 관리</title>
<style>
* {
	box-sizing: border-box;
}

.table-title {
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-order {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
}

.order-List, .order-search {
	padding: 20px;
}

thead>th {
	text-align: center;
}

img {
	width: 150px;
	height: 100px;
}

select.deal_status {
	width: 125px;
	margin: auto;
	text-align: center;
}

a.toProductDetail {
	color: black;
	text-decoration: none;
}

a.toProductDetail:hover {
	color: gray;
}

select.deal_status {
	width: 125px;
	margin: auto;
	font-weight: bold
}

a.toProductDetail {
	color: black;
	text-decoration: none;
}

a.toProductDetail:hover {
	color: gray;
}

.num_box {
	margin: 0 7px 0 7px;
	border-width: 0px;
	font-weight: bold;
	color: black;
	font-size: 18px;
	text-decoration: none;
}

.num_box:hover {
	color: gray;
}

.txt_point {
	-ms-transform: scale(1.5); /* IE */
	-moz-transform: scale(1.5); /* FF */
	-webkit-transform: scale(1.5); /* Safari and Chrome */
	-o-transform: scale(1.5); /* Opera */
	background-color: smokewhite;
	-webkit-border-top-left-radius: 3px;
	-moz-border-radius-topleft: 3px;
	border-top-left-radius: 3px;
	-webkit-border-top-right-radius: 3px;
	-moz-border-radius-topright: 3px;
	border-top-right-radius: 3px;
	-webkit-border-bottom-right-radius: 3px;
	-moz-border-radius-bottomright: 3px;
	border-bottom-right-radius: 3px;
	-webkit-border-bottom-left-radius: 3px;
	-moz-border-radius-bottomleft: 3px;
	border-bottom-left-radius: 3px;
	text-indent: 0;
	border: 1px solid black;
	display: inline-block;
	color: blue;
	font-size: 12px;
	width: 16px;
	height: 16px;
	line-height: 16px;
	text-decoration: none;
	text-align: center;
	padding-bottom: 15px;
	text-shadow: 1px 1px 0px #ffffff;
}

.txt_point, .txt_point a:link, .txt_point a:visited, .txt_point a:active,
	a.txt_point:link, a.txt_point:visited, a.txt_point:hover, a.txt_point:active
	{
	color: blue;
}

table {
	background-color: rgb(245, 245, 245);
}

#searchBtn {
	border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
}

#searchBtn:hover {
	color: white;
	background-color: black;
}

#during_delivery {
	border: 1px solid #ff7f00;
	background-color: white;
	color: #ff7f00;
	border-radius: 5px;
	height: 38px;
}

#during_delivery:hover {
	background-color: #ff7f00;
	color: white;
}

#finish_delivery {
	border: 1px solid green;
	background-color: white;
	color: green;
	border-radius: 5px;
	height: 38px;
}

#finish_delivery:hover {
	background-color: green;
	color: white;
}

#changeBtn {
	border: 1px solid blue;
	background-color: white;
	color: blue;
	border-radius: 5px;
	height: 38px;
}

#changeBtn:hover {
	background-color: blue;
	color: white;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<div class="container">
		<div class="table-title">
			<div class="row">
				<div class="col title-order">
					<div>주문 내역 관리</div>
				</div>
			</div>

			<div class="row justify-content-end order-search">
				<div class="col col-6"></div>
				<div class="col-1">
					<select id="searchOption" class="form-select"
						style="width: 100px; height: 100%; float: right;">
						<option value="all" selected>전체</option>
						<option value="id">주문자 아이디</option>
						<option value="product_name">제품명</option>
						<option value="cloth_size">사이즈</option>
						<option value="color">색상</option>
						<option value="quantity">수량</option>
						<option value="deal_status">배송 현황</option>
					</select>
				</div>
				<div class="col-2">
					<div class="input-group">
						<input type="text" class="form-control" id="keyword"
							name="keyword" onkeyup="enterkey()">
						<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
					</div>
				</div>
			</div>


			<div class="row order-List">
				<div class="col-4" style="text-align: left;">
					<button type="button" id="during_delivery" class="btn btn-info">배송중</button>
					<button type="button" id="finish_delivery" class="btn btn-success">배송완료</button>
				</div>
				<div class="col-8" style="text-align: right">
					<button type="button" id="changeBtn" class="btn btn-warning">배송
						현황 변경</button>
				</div>
			</div>
		</div>
		<table class="table table-hover" style="text-align: center">
			<thead class="table-light">
				<tr class="text-center">
					<th class="col-1"><input type="checkbox" id="checkAll"></th>
					<th class="col-1">주문자 아이디</th>
					<th class="col-2">제품</th>
					<th class="col-1">사이즈</th>
					<th class="col-1">색상</th>
					<th class="col-1">수량</th>
					<th class="col-2">결제 날짜</th>
					<th class="col-2">배송 현황</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty order_list and empty nameList}">
					<tr>
						<td colspan="12">현재 처리해야 할 주문이 없거나 검색된 내용이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${order_list}" var="dto" varStatus="status">
					<input type="text" class="order_seq" value="${dto.order_seq}"
						hidden>
					<tr class="tr_content">
						<td><input type="checkbox" name="chk"
							value="${dto.order_seq},${dto.deal_status}"></td>
						<td>${dto.id}</td>
						<td>
							<c:choose>
								<c:when test="${nameList[status.index].product_name ne null}">
									<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${dto.product_code}"
										class="toProductDetail">
										${nameList[status.index].product_name}
									</a>
								</c:when>
								<c:otherwise>
									삭제된 제품
								</c:otherwise>
							</c:choose>
						</td>
						<td>${dto.cloth_size}</td>
						<td>
							<c:choose>
								<c:when test="${dto.color eq 'undefined'}">
									-
								</c:when>
								<c:otherwise>${dto.color}</c:otherwise>
							</c:choose>
						</td>
						<td>${dto.quantity}</td>
						<td>${dto.deal_date}</td>
						<td><c:choose>
								<c:when test="${dto.deal_status eq '결제완료'}">
									<select class="form-select deal_status" style="color: red;">
										<option value="결제완료" selected>결제완료</option>
										<option value="배송중" style="color: #ff7f00;">배송중</option>
									</select>
								</c:when>
								<c:when test="${dto.deal_status eq '배송중'}">
									<select class="form-select deal_status" style="color: #ff7f00">
										<option value="배송중" selected>배송중</option>
										<option value="배송완료" style="color: green">배송완료</option>
									</select>
								</c:when>
								<c:when test="${dto.deal_status eq '배송완료'}">
									<input type="text" class="deal_status"
										value="${dto.deal_status}" hidden>
									<span style="color: green; font-weight: bold">${dto.deal_status}</span>
								</c:when>
								<c:when test="${dto.deal_status eq '구매확정'}">
									<input type="text" class="deal_status"
										value="${dto.deal_status}" hidden>
									<span style="color: blue; font-weight: bold">${dto.deal_status}</span>
								</c:when>
								<c:when test="${dto.deal_status eq '리뷰완료'}">
									<input type="text" class="deal_status"
										value="${dto.deal_status}" hidden>
									<span style="color: purple; font-weight: bold">${dto.deal_status}</span>
								</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">

				<c:if test="${naviMap ne null and searchNaviMap eq null}">
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${naviMap.needPrev eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/product/toProductList?product_category=${product_category}&currentPage=${naviMap.startNavi - 1}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">이전</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 번호버튼 -->
					<c:forEach var="i" begin="${naviMap.startNavi}"
						end="${naviMap.endNavi}">
						<c:choose>
							<c:when test="${naviMap.currentPage eq i}">
								<!-- 현재 페이지의 li 만 active 해줌 -->
								<li class="page-item active"><a class="num_box txt_point"
									href="${pageContext.request.contextPath}/order/toOrderList?currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/order/toOrderList?currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${naviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/order/toOrderList?currentPage=${naviMap.endNavi + 1}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${naviMap eq null and searchNaviMap ne null}">
					<!-- 검색시 페이징 버튼 -->
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needPrev eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/order/toSearchList?searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.startNavi - 1}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">이전</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 번호버튼 -->
					<c:forEach var="i" begin="${searchNaviMap.startNavi}"
						end="${searchNaviMap.endNavi}">
						<c:choose>
							<c:when test="${searchNaviMap.currentPage eq i}">
								<!-- 현재 페이지의 li 만 active 해줌 -->
								<li class="page-item active"><a class="num_box txt_point"
									href="${pageContext.request.contextPath}/order/toSearchList?searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/order/toSearchList?searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/order/toSearchList?searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.endNavi + 1}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</nav>
	</div>
	<%@include file="../footer.jsp"%>
	<script>
	// 배송 현황 변경 저장 버튼
    $("#changeBtn").click(function(){
    	let order_seq = [];
    	let deal_status = [];
    	
    	$(".order_seq").each(function(e, item){
    		order_seq.push(item.value);
    	})
    	$(".deal_status").each(function(e, item){
    		deal_status.push(item.value);
    	})
    	
    	location.href = "${pageContext.request.contextPath}/order/changeDealStatus.do?order_seq=" + order_seq + "&deal_status=" + deal_status;
    })
    
    // 체크된 주문들을 결제 완료에서 배송 중으로 변경
    $("#during_delivery").click(function(){
    	if($("input:checkbox[name='chk']:checked").length == 0){
			alert("선택된 주문이 없습니다.");
			return
		}
    	let order_seq = [];
    	let deal_status = [];
    	var count = 0;
    	
    	$("input:checkbox[name='chk']:checked").each(function(e, eVal){
			let data = eVal.value.split(",")
			order_seq.push(data[0]);
			deal_status.push(data[1]);
			console.log(deal_status[e]);
			
			if(deal_status[e] != "결제완료"){
				count += 1;
			}
		})
		if(count > 0){
			alert("배송 중 상태로는 결제 완료 상태에서만 변경이 가능합니다.");
		}else{
			location.href = "${pageContext.request.contextPath}/order/during_delivery.do?order_seq=" + order_seq;
		}
    })
    
    // 체크된 주문들을 배송 중에서 배송 완료로 변경
    $("#finish_delivery").click(function(){
    	if($("input:checkbox[name='chk']:checked").length == 0){
			alert("선택된 주문이 없습니다.");
			return
		}
    	let order_seq = [];
    	let deal_status = [];
    	var count = 0;
    	
    	$("input:checkbox[name='chk']:checked").each(function(e, eVal){
			let data = eVal.value.split(",")
			order_seq.push(data[0]);
			deal_status.push(data[1]);
			console.log(deal_status[e]);
			
			if(deal_status[e] != "배송중"){
				count += 1;
			}
		})
		if(count > 0){
			alert("배송 완료 상태로는 배송 중 상태에서만 변경이 가능합니다.");
		}else{
			location.href = "${pageContext.request.contextPath}/order/finish_delivery.do?order_seq=" + order_seq;
		}
    })
    
    // 체크박스 전체 선택
    $("#checkAll").click(function(){
    	if($("#checkAll").prop("checked")){
    		$("input[name=chk]").prop("checked", true);
    	}else{
    		$("input[name=chk]").prop("checked", false);
    	}
    })
    
    // 검색
    $("#searchBtn").on("click", function(){
    	let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
		
		if(!searchRegx.test($("#keyword").val())){
			if($("#keyword").val != ""){
	    		let searchOption = $("#searchOption").val();
	    		let keyword = $("#keyword").val();
	    		console.log(searchOption + " : " + keyword);
	    		
	    		let url = "${pageContext.request.contextPath}/order/toSearchList?searchOption=" + searchOption + "&keyword=" + keyword + "&currentPage=1";
	    		$(location).attr("href", url);
	    	}
		}
		else{
			alert("특수문자를 포함할 수 없습니다.");
			$("#keyword").val("");
		}
    })
    
    // 검색 (엔터키 입력시)
    function enterkey(){
    	if(window.event.keyCode == 13){
    		let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
    		
    		if(!searchRegx.test($("#keyword").val())){
    			if($("#keyword").val != ""){
    	    		let searchOption = $("#searchOption").val();
    	    		let keyword = $("#keyword").val();
    	    		console.log(searchOption + " : " + keyword);
    	    		
    	    		let url = "${pageContext.request.contextPath}/order/toSearchList?searchOption=" + searchOption + "&keyword=" + keyword + "&currentPage=1";
    	    		$(location).attr("href", url);
    	    	}
    		}
    		else{
    			alert("특수문자를 포함할 수 없습니다.");
    			$("#keyword").val("");
    		}
    	}
    }	
	</script>
</body>
</html>