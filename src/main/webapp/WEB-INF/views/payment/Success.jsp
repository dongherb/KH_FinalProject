<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>결제 완료</title>
<style>
	.successContainer{
		margin-top: 100px;
		margin-bottom: 100px;
	}
 	.explainRow{
           text-align:center;
           margin-bottom: 50px;
           margin: 10px;
      }
</style>
</head>
<body>
 <%@include file="../header.jsp" %>
	<div class="container successContainer">
        <div class="row explainRow">
            <div class="col">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcA7hTKl2_6RewsRJssULsgdGcYaZ7XlCfvA&usqp=CAU">
            </div>
        </div>

        <div class="row explainRow">
            <span>결제가 완료되었습니다.</span>
            <span>주문 배송 현황은 <a href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=&currentPage=1" >여기</a>에서 확인하실 수 있습니다.</span>
        </div>
    </div>
    
    <br>
  <%@include file="../footer.jsp" %>
    
</body>
</html>