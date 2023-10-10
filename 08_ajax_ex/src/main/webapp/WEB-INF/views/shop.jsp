<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<style>
	table, td {
		border: 1px solid gray;
	}
</style>
</head>
<body>

  <div>검색결과건수
    <select>
      <option>10</option>
    </select>
  </div>
  
  <div>
    <input type="radio" name="search" value="sim" id="serch_sim">
    <label for="serch_sim">유사도순</label>
    <input type="radio" name="search" value="date" id="serch_date">
    <label for="serch_date">날짜순</label>
    <input type="radio" name="search" value="lprice" id="serch_lprice">
    <label for="serch_lprice">낮은가격순</label>
    <input type="radio" name="search" value="hprice" id="serch_hprice">
    <label for="serch_hprice">높은가격순</label>
  </div>
  
  <form>
    <div>검색어 입력
      <input type="text">
      <button id="serch">검색</button>
    </div>
  </form>
  
  <hr>
  
  <div id="result">
    <table>
      <td>상품명</td>
      <td>썸네일</td>
      <td>최저가</td>
      <td>판매처</td>
    </table>
  </div>


</body>
</html>