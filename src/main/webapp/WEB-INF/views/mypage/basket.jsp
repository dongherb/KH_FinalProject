<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<!-- 부트페이 CDN -->     
<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.2.min.js" type="application/javascript"></script>

<style>
        * {
            box-sizing: border-box;
        }
        
        .container{
        margin-bottom:50px;
        }
        
        .payBtnDiv{
        margin-bottom:100px;
        }

        #pageName {
            text-align: center;
        }

        #navbarNavDropdown>ul {
            width: 100%;
        }

        #navbarNavDropdown>ul>li {
            width: 20%;
        }

        #line {
            border-bottom :1px solid grey;
        }

        .payTable{
            text-align:center;
            border:1px solid black;
        }

        .productTable{
           text-align :center;
           border:1px solid gray;
        }

        img{
            height:100px;
            width:100px;
            
        }

        th,td{
            border-right:1px solid gray;
        }

        td{
            width:20%;
            height:100%;
            vertical-align: middle;
        }

        td>span{
            align-items:center;
            margin:auto;
            padding-top: 50px;
        }

        #payExpec{
            text-align:center;
        }

        .payBtnDiv{
            text-align:right;
        }
        
        .deleteBtn{
        	background-color = white;
        	width:100px;
        }
        #btnOrder{
            font-weight : bold;
	        background-color: #e5eaee;
	        color: black;
	        border-radius: 5px;
         	height: 38px;
        }
        #btnOrder:hover{
            background-color : white;
        }
    </style>
</head>
<body>
	<%@include file="../header.jsp" %>
	<!-- 마이페이지 헤더 -->
	<%@include file="mypageNavi.jsp" %>
    <!-- 기본 틀 -->

    <div class="container" id="pageName">
        <div class="row">
            <div class="col">
                <h2>주문 결제</h2>
            </div>
        </div>
    <br>
    <br>

    <table class="table productTable">
        <thead>
            <tr>
                <th scope="col">제품 사진</th>
                <th scope="col">제품명</th>
                <th scope="col">가격</th>
                <th scope="col">수량</th>
                <th scope="col">합계</th>
                <th scope="col">주문 관리</th>
            </tr>
        </thead>
        <tbody id="basketList">
        	<c:if test="${empty list}">
        		<tr>
        			<td colspan="12">장바구니에 물건이 담겨있지 않습니다.</td>
        		</tr>
        	</c:if>
        
        	 <c:forEach items="${list}" var="order">
        	    <tr>
        	    
                <td scope="col">
					<c:forEach items="${product_list}" var="product">
                		<c:if test="${order.product_code eq product.product_code}">
							<img src = "${pageContext.request.contextPath}/product_img/${product.product_img}" height = "100%">
                		</c:if>
                	</c:forEach>
                </td>
                <td scope="col">
                	<c:forEach items="${product_list}" var="product">
                		<c:if test="${order.product_code eq product.product_code}">
                			<c:choose>
                				<c:when test = "${order.color eq 'undefined'}">
                					${product.product_name}/사이즈:${order.cloth_size}mm
                				</c:when>
                			<c:otherwise>
                				${product.product_name}/색상:${order.color}/사이즈:${order.cloth_size}	
                			</c:otherwise>
                		</c:choose>
                		</c:if>
                	</c:forEach>
                </td>
               <td scope="col">
                <c:forEach items="${product_list}" var="product">
                	<c:if test="${order.product_code eq product.product_code}">${Math.round(product.price - ((product.discount/100) * product.price))}원</c:if>
                </c:forEach>
               </td>
 
                <td scope="col">
				<input type="text" id="quantity" onKeyPress="return checkNum(event)" class="quantity" name="quantity" origin_quantity="${order.quantity}" order_seq="${order.order_seq}" value="${order.quantity}" size="3">
                	<c:choose>
                		<c:when test="${order.quantity >= 99}">
							<button type="button" class= "plusBtn" value= "${order.order_seq}" disabled>➕</button>
                		</c:when>
                		<c:otherwise>
                			<button type="button" class= "plusBtn" value= "${order.order_seq}" >➕</button>
                		</c:otherwise>
                	</c:choose>
                	
                	<c:choose>
                		<c:when test="${order.quantity <= 1}">
                	<button type="button" class = "minusBtn" value= "${order.order_seq}" disabled>➖</button>	
                		</c:when>
                		<c:otherwise>
                	<button type="button" class = "minusBtn" value= "${order.order_seq}">➖</button>	
                		</c:otherwise>
                	</c:choose>
                </td>
            <td scope="col">
              <c:forEach items="${product_list}" var="product">
                <c:if test="${order.product_code eq product.product_code}">
                	<span class="totalPrice" total_price="${order.quantity * Math.round(product.price - ((product.discount/100) * product.price))}">
                		${order.quantity * Math.round(product.price - ((product.discount/100) * product.price))}원
                	</span>
                </c:if>
              </c:forEach>
            </td>
            
            <td scope="col">
            	<c:forEach items ="${product_list}" var="product">
            		<c:if test="${order.product_code eq product.product_code}">
            			<button type="button" order_seq = "${order.order_seq}" class="btn btn-light deleteBtn">❌</button>
            		</c:if>
            	</c:forEach>
            </td>
            </tr>
           </c:forEach>	
        </tbody>
    </table>
</div>
    <br>
    <br>
	<c:if test="${!empty list}">
    	    <div class="container" id="payExpec">
        <div class="row">
            <div class="col">
                <h2>주문 예상 금액</h2>
            </div>
        </div>
    <br>
    <br>

    <table class="table payTable">
        <thead>
            <tr>
                <th>총 주문 금액</th>
                <th>배송비</th>
                <th>총 결제 예정 금액</th>
            </tr>
        </thead>
        
        <tbody>
            <tr>
                <td id="finalOrderPrice"></td>
                <td id="deliveryPrice"></td>
                <td id="finalPrice"></td>
            </tr>
        </tbody>
    </table>
</div>
    <br>

    <div class="container payBtnDiv">
        <div class="row" style="padding-bottom : 20px;">
            <div class="col" >
                <button type="button" id="btnOrder">주문하기</button>
            </div>
        </div>
    </div>
   </c:if>
    <%@include file="../footer.jsp" %>
   <script>
 
   function checkNum(e) {
       var keyVal = event.keyCode;
       if(((keyVal >= 48) && (keyVal <= 57))){
           return true;
       }
       else{
           alert("숫자만 입력가능합니다");
           return false;
       }
   }

   $(".deleteBtn").on("click",function(e){
	   
	   let result = confirm("정말 삭제하시겠습니까?");
	   if(result){
		   location.href="${pageContext.request.contextPath}/order/deleteOrder?order_seq=" +(e.target).getAttribute('order_seq');   
	   }else{
		   location.href="${pageContext.request.contextPath}/order/toBasket";
	   }
	   
   })

   let totalPrice = 0;
   for (let total_price of $(".totalPrice")) {
	totalPrice += (Number)((total_price).getAttribute('total_price'));
	}
   $("#finalOrderPrice").html(totalPrice);
   	
   let deliveryPrice = 2500;
   $("#deliveryPrice").html(deliveryPrice);
   
   let finalPrice = totalPrice + deliveryPrice;
   $("#finalPrice").html(finalPrice);
   
   // 수량이 변했을 시 작업
   $(".quantity").change(function(e){
	   if(isNaN($(e.target).val())){
		    alert("숫자만 입력가능합니다");
			$(e.target).val((e.target).getAttribute('origin_quantity'));
		   return;
	   }
	   
	  if($(e.target).val() > 99){
			alert("최대 99개까지만 선택 가능합니다.");
			$(e.target).val((e.target).getAttribute('origin_quantity'));
			return;
		}
	
	  if($(e.target).val() <= 0){
			alert("최소 1개는 선택해주세요");
			$(e.target).val((e.target).getAttribute('origin_quantity'));
			return;
		}
		  location.href= "${pageContext.request.contextPath}/order/inputQuantity?order_seq="+(e.target).getAttribute('order_seq')+"&quantity=" + $(e.target).val();
	   });
   
   
   $(".plusBtn").on("click",function(e){
		  //console.log($(e.target).val());
		  alert("수량이 변경되었습니다.");
		  location.href="${pageContext.request.contextPath}/order/plusQuantity?order_seq="+$(e.target).val();
	   });
   
   $(".minusBtn").on("click",function(e){
	   alert("수량이 변경되었습니다.");
	   location.href="${pageContext.request.contextPath}/order/minusQuantity?order_seq="+$(e.target).val();
	   //location.href="${pageContext.request.contextPath}/order/minusQuantity";
   });
   
   // 주문하기 페이지로 이동
   $("#btnOrder").on("click",function(){
	   location.href="${pageContext.request.contextPath}/order/toOrder";
   });
   
	</script>
</body>
</html>