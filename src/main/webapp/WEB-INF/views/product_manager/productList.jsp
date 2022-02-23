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
<title>제품 목록</title>
<style>
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

#deleteBtn {
	border: 1px solid red;
	background-color: white;
	color: red;
	border-radius: 5px;
	height: 38px;
}

#deleteBtn:hover {
	background-color: red;
	color: white;
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

.table-title {        
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-product{
	padding:50px;
	font-size:40px;
	font-weight: bold;
}

.product-List, .product-search{
	padding: 20px;
}

thead > th{
text-align: center;
}

img {
	width: 150px;
	height: 100px;
}

table{
    table-layout: fixed;
}

* {
	box-sizing: border-box;
}

.dynamic-tr > td{
	vertical-align : middle;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<div class="container">
		<div class="table-title">
			<div class="row">
				<div class="col title-product">
					<div>제품 목록</div>
				</div>
			</div>

			<div class="row justify-content-end product-search">
				<div class="col col-6"></div>
				<div class="col-1">
					<select id="searchOption" class="form-select"
						style="width: 100px; float: right;">
						<option value="all" selected>전체</option>
						<option value="product_code">제품코드</option>
						<option value="product_name">제품명</option>
						<option value="price">가격</option>
						<option value="discount">할인율</option>
					</select>
				</div>
				<div class="col-1">
					<select id="productCategory" class="form-select"
						style="width: 100px;">
						<option value="All" selected>전체</option>
						<option value="아우터">아우터</option>
						<option value="상의">상의</option>
						<option value="하의">하의</option>
						<option value="신발">신발</option>
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

			<div class="row product-List">
				<div class="col-4" style="text-align: left;">
					<button type="button" id="deleteBtn" class="btn btn-danger">선택삭제</button>
				</div>
				<div class="col-8" style="text-align: right">
					<button type="button" class="btn btn-dark categoryBtn" value="All">전체</button>
					<button type="button" class="btn btn-dark categoryBtn" value="아우터">아우터</button>
					<button type="button" class="btn btn-dark categoryBtn" value="상의">상의</button>
					<button type="button" class="btn btn-dark categoryBtn" value="하의">하의</button>
					<button type="button" class="btn btn-dark categoryBtn" value="신발">신발</button>
				</div>
			</div>
		</div>
		<!-- 컨테이너 끝 -->

		<table class="table table-hover dynamic-table"
			style="text-align: center">
			<thead class="table-light">
				<tr class="text-center">
					<th class="col-1"><input type="checkbox" id="checkAll"></th>
					<th class="col-1">제품코드</th>
					<th class="col-1">카테고리</th>
					<th class="col-1">제품명</th>
					<th class="col-2">제품 이미지</th>
					<th class="col-1">가격</th>
					<th class="col-1">할인율</th>
					<th class="col-1">별점</th>
					<th class="col-1">수정</th>
					<th class="col-1">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="10">현재 등록된 상품이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${list}" var="dto">
					<tr class="text-center dynamic-tr">
						<td><input type="checkbox" value="${dto.product_code}"
							name="chk"></td>
						<td>${dto.product_code}</td>
						<td>${dto.product_category}</td>
						<td>${dto.product_name}</td>
						<td><a
							href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${dto.product_code}"><img
								src="${pageContext.request.contextPath}/product_img/${dto.product_img}"></a></td>
						<td>${dto.price}</td>
						<td>${dto.discount}</td>
						<td>${dto.avg_score}</td>
						<td><button type="button" class="btn toModify"
								value="${dto.product_code}">✏️</button>
						<td><button type="button" class="btn toDelete"
								value="${dto.product_code}" productValue="${dto.product_name}">❌</button>
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
									href="${pageContext.request.contextPath}/product/toProductList?product_category=${product_category}&currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/product/toProductList?product_category=${product_category}&currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${naviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/product/toProductList?product_category=${product_category}&currentPage=${naviMap.endNavi + 1}">다음</a></li>
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
								href="${pageContext.request.contextPath}/product/toSearchList?product_category=${product_category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.startNavi - 1}">이전</a></li>
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
									href="${pageContext.request.contextPath}/product/toSearchList?product_category=${product_category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/product/toSearchList?product_category=${product_category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/product/toSearchList?product_category=${product_category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.endNavi + 1}">다음</a></li>
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
		// 제품 수정 페이지 이동
		$(".toModify")
				.on(
						"click",
						function(e) {
							let product_code = $(e.target).val();
							location.href = "${pageContext.request.contextPath}/product/toModifyProduct?product_code="
									+ product_code;
						})

		// 제품 삭제
		$(".toDelete")
				.on(
						"click",
						function(e) {
							let product_code = $(e.target).val();
							let product_name = (e.target)
									.getAttribute('productValue');

							if (confirm("정말로 삭제하시겠습니까?\n" + "제품 코드 : "
									+ product_code + "\n" + "제품명 : "
									+ product_name + "\n")) {
								location.href = "${pageContext.request.contextPath}/product/deleteProduct.do?product_code="
										+ product_code;
							}
						})

		// 카테고리 버튼 별 제품 목록
		$(".categoryBtn").on(
				"click",
				function(e) {
					$(location).attr(
							"href",
							"${pageContext.request.contextPath}/product/toProductList?product_category="
									+ $(e.target).val() + "&currentPage=1");
				})

		// 체크박스 전체 선택
		$("#checkAll").click(function() {
			if ($("#checkAll").prop("checked")) {
				$("input[name=chk]").prop("checked", true);
			} else {
				$("input[name=chk]").prop("checked", false);
			}
		})

		// 체크된 목록 삭제
		$("#deleteBtn")
				.click(
						function() {
							if ($("input:checkbox[name='chk']:checked").length == 0) {
								alert("선택된 제품이 없습니다.");
								return;
							}

							let chk_Val = [];

							if (confirm("선택된 "
									+ $("input:checkbox[name='chk']:checked").length
									+ "개의 제품을 정말로 삭제하시겠습니까?")) {
								$("input:checkbox[name='chk']:checked").each(
										function(e, eVal) {
											chk_Val.push(eVal.value);
										});
								location.href = "${pageContext.request.contextPath}/product/deleteChecked.do?chk_Val="
										+ chk_Val;
							}
						})

		// 검색
		$("#searchBtn").on("click", function() {
			let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;

			if (!searchRegx.test($("#keyword").val())) {
				if ($("#keyword").val != "") {
					let searchOption = $("#searchOption").val();
					let product_category = $("#productCategory")
							.val();
					let keyword = $("#keyword").val();
					console.log(product_category + " : "
							+ searchOption + " : " + keyword);

					let url = "${pageContext.request.contextPath}/product/toSearchList?product_category="
							+ product_category
							+ "&searchOption="
							+ searchOption
							+ "&keyword="
							+ keyword
							+ "&currentPage=1";
					$(location).attr("href", url);
				}
			} else {
				alert("특수문자를 포함할 수 없습니다.");
				$("#keyword").val("");
			}
		})

		// 검색 (엔터키 입력시)
		function enterkey() {
			if (window.event.keyCode == 13) {
				let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;

				if (!searchRegx.test($("#keyword").val())) {
					if ($("#keyword").val != "") {
						let searchOption = $("#searchOption").val();
						let product_category = $("#productCategory")
								.val();
						let keyword = $("#keyword").val();
						console.log(product_category + " : "
								+ searchOption + " : " + keyword);

						let url = "${pageContext.request.contextPath}/product/toSearchList?product_category="
								+ product_category
								+ "&searchOption="
								+ searchOption
								+ "&keyword="
								+ keyword
								+ "&currentPage=1";
						$(location).attr("href", url);
					}
				} else {
					alert("특수문자를 포함할 수 없습니다.");
					$("#keyword").val("");
				}
			}
		}
	</script>
</body>
</html>