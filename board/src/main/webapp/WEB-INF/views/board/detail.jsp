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
</head>
<script>
  $(function(){
	  fnListBoard();
	  fnDelete();
  })
  
  function fnDelete(){
 	$('#btn_delete').click(function(){
  	  if(!confirm('공지사항을 삭제할까요?')){
  		return;
  	  } else {
  		$('#frm_detail').submit();
  	  }
  	})
  }
  
  
   function fnListBoard(){
    $('#btn_list').click(function(){
      location.href = '${contextPath}/board/list.do';
    })
  }
  

</script>
<body>
  <form id="frm_detail" method="post" action="${contextPath}/board/delete.do">
    <div>
      <h1>MvcBoard 게시글 상세보기</h1>
      <h3>${board.no}번 게시글</h3>
      <h3>작성자 : ${board.author}</h3>
      <h3>작성일 : ${board.postDate}</h3>
      <h3>작성IP : ${board.ip}</h3>
      <h3>조회수 : ${board.hit}</h3>
      <h3>제목 : ${board.title}</h3>
      <h3>내용</h3>
      <div>${board.content}</div>
      <div>
        <input type="hidden" name="no" value="${board.no}">
        <button type="button" id="btn_delete">삭제하기</button>
        <button type="button" id="btn_list">목록보기</button>
      </div>
    </div>
  </form>
    
</body>
</html>