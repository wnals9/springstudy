<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  
  ${title}
  <br>
  ${sessionScope.title}
  <br>
  
  <a href="${contextPath}/article/main.do">세션 초기화하고 main 화면으로 가기</a>

</body>
</html>