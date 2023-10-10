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
	fnModifyResult();
	fnDeleteContact();
	fnListContact();
  })
  
  function fnModifyResult(){
	var modifyResult = '${modifyResult}';
	if(modifyResult !== ''){
	  if(modifyResult === '1'){
		alert('연락처가 수정되었습니다.');
	  } else{
		alert('연락처 수정이 실패했습니다.');
	  }
	}
  }
  
  function fnDeleteContact(){
	$('#btn_delete').click(function(){
	  if(confirm('연락처를 삭제할까요?')){
		location.href = '${contextPath}/contact/delete.do?contact_no=${contact.contact_no}';
	  }
	})
  }
  
  function fnListContact(){
    $('#btn_list').click(function(){
      location.href = '${contextPath}/contact/list.do';
    })
  }

</script>
</head>
<body>

  <div>
    <h3>연락처관리</h3>
    <form method="post" action="${contextPath}/contact/modify.do">
      <div>
        <label for="name">이름</label>
        <input type="text" id="name" name="name" value="${contact.name}">
      </div>
      <div>
        <label for="name">전화번호</label>
        <input type="text" id="tel" name="tel" value="${contact.tel}">
      </div>
      <div>
        <label for="name">이메일</label>
        <input type="text" id="email" name="email" value="${contact.email}">
      </div>
      <div>
        <label for="name">주소</label>
        <input type="text" id="address" name="address" value="${contact.address}">
      </div>
      <div>
        <input type="hidden" name="contact_no" value="${contact.contact_no}">
        <button type="submit">수정</button>
        <button type="button" id="btn_delete">삭제</button>
        <button type="button" id="btn_list">목록</button>
        <button type="reset">입력초기화</button>
      </div>
    </form>
  </div>

</body>
</html>