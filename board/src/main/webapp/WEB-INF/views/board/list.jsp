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
<script>
  $(function(){
	fnAddResult();
	fnDeleteResult();
  })
  
  function fnAddResult(){
	var addResult = '${addResult}';
	if(addResult !== ''){
	  if(addResult === '1'){
		alert('게시글이 등록되었습니다.');
	  } else {
		alert('게시글 등록이 실패했습니다.');
	  }
	}
  }
  
  function fnDeleteResult(){
    var deleteResult = '${deleteResult}';
  	if(deleteResult !== ''){
  	  if(deleteResult === '1'){
  		alert('게시글이 삭제되었습니다.');
  	  } else {
  		alert('게시글 삭제를 실패했습니다.');
  	  }
  	}
  }
</script>
</head>
<body>

  <div>
    <div>
      <a href="${contextPath}/board/write.do">새글작성</a>
    </div>
    
    <hr>
    
    <table border="1">
      <thead>
        <tr>
          <td>글번호</td>
          <td>제목</td>
          <td>작성자</td>
          <td>작성일</td>
          <td>조회수</td>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${boardList}" var="c">
          <tr>
            <td>${c.no}</td>
            <td><a href="${contextPath}/board/detail.do?no=${c.no}">${c.title}</a></td>
            <td>${c.author}</td>
            <td>${c.postDate}</td>
            <td>${c.hit}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</body>
</html>