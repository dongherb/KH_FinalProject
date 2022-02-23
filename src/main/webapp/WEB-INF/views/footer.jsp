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
* {
  box-sizing: border-box;
}

.site-footer
{
  background-color:#faf8f8;
  padding:10px 0 10px;
  font-size:13.5px;
  line-height:24px;
  color:#737373;
}
.site-footer hr
{
  border-top-color:#bbb;
  opacity:0.5
}
.site-footer hr.small
{
  margin:20px 0
}
.site-footer h6
{
  color:black;
  font-size:16px;
  text-transform:uppercase;
  margin-top:5px;
  letter-spacing:2px
}
.site-footer a
{
  color:#737373;
}
.site-footer a:hover
{
  color:#3366cc;
  text-decoration:none;
}
.footer-links
{
  padding-left:0;
  list-style:none
}
.footer-links li
{
  display:block
}
.footer-links a
{
  color:#737373
}
.footer-links a:active,.footer-links a:focus,.footer-links a:hover
{
  color:#3366cc;
  text-decoration:none;
}
.footer-links.inline li
{
  display:inline-block
}

.copyright-text
{
  margin:0
}

.decoLine{
margin:0px;
}

</style>
</head>
<body>
<footer class="site-footer section-9">
  <div class="container">
    <div class="row">
      <div class="col-sm-12 col-md-6">
        <h6>About</h6>
        <p class="text-justify">
          COMPANY: MOOD&STYLE <br>
          OWNER : 이윤수 외 4명<br>
          BUSINESS LICENSE : 123-45-67890<br>
          ADDRESS : 경기 성남시 분당구 삼평동 판교역로 235<br>
          TEL : 070-1233-5678
        </p>
      </div>

      <div class="col-xs-6 col-md-3">
        <h6>MEMBER</h6>
        <ul class="footer-links">
          <li><a id="mypageBtn-f" href="${pageContext.request.contextPath}/mypageHome/toMypageHome">MYPAGE</a></li>
          <li><a id="cartBtn-f" href="${pageContext.request.contextPath}/order/toBasket">CART</a></li>
          <li><a id="orderBtn-f" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=&currentPage=1">ORDER</a></li>
          <li><a id="checkBtn-f" href="${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=0">CHECK</a></li>
        </ul>
      </div>

      <div class="col-xs-6 col-md-3">
        <h6>COMMUNITY </h6>
        <ul class="footer-links">
          <li><a id="noticeBtn-f" href="${pageContext.request.contextPath}/notice/toNoticeList_user?currentPage=1">NOTICE</a></li>
          <li><a id="qnaBtn-f" href="${pageContext.request.contextPath}/enquiry/toEnquiryList">Q&A</a></li>
        </ul>
      </div>
    </div>
    <hr class="decoLine">
  </div>
  <div class="container">
    <div class="row">
      <div class="col-md-8 col-sm-6 col-xs-12">
        <p class="copyright-text">Copyright &copy; 2022 All Rights Reserved by 
     <a href="${pageContext.request.contextPath}/">MOOD&STYLE</a>.
        </p>
      </div>
    </div>
  </div>
</footer>

</body>
</html>