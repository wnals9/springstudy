<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="약관동의" name="title"/>
</jsp:include>
<script>

  $(() => {
	fnChkAll();
	fnChkEach();
	fnJoinForm();
  })


  //전체 선택을 클릭하면 개별 선택에 영향을 미친다.
  const fnChkAll = () => {
    $('#chk_all').click((ev) => {
       $('.chk_each').prop('checked', $(ev.target).prop('checked'));
    })
  }
  
  // 개별 선택을 클릭하면 전체 선택에 영향을 미친다.
  const fnChkEach = () => {
  	$(document).on('click', '.chk_each', () => {
      var total = 0;
      $.each($('.chk_each'), (i, elem) => {
    	total += $(elem).prop('checked');
      })
      $('#chk_all').prop('checked', total === $('.chk_each').length);
  	})
  }
  
  // 필수 동의를 해야만 가입 페이지로 이동할 수 있다.
  const fnJoinForm = () => {
	$('#frm_agree').submit((ev) => {
	  if(!$('#service').is(':checked')) {
		alert('필수 약관에 동의하세요.');
		ev.preventDefault();
		return;
	  }
	})
  }

</script>

<div>
  <form id="frm_agree" action="${contextPath}/user/join.form">
    
    <h1>약관 동의하기</h1>
    
    <div>
      <input type="checkbox" id="chk_all">
      <label for="chk_all">모두 동의합니다</label>
    </div>
    
    <hr>
    
    <div>
      <input type="checkbox" id="service" class="chk_each">
      <label for="service">서비스 이용약관 동의(필수)</label>
    </div>
    <div>
      <textarea>본 약관은 ...</textarea>
    </div>
    
    <div>
      <input type="checkbox" id="event" class="chk_each">
      <label for="event">이벤트 알림 동의(선택)</label>
    </div>
    <div>
      <textarea>본 약관은 ...</textarea>
    </div>
    
    <div>
      <button type="submit">다음</button>
    </div>
    
  </form>
</div>

<%@ include file="../layout/footer.jsp" %>