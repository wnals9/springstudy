<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="업로드게시글작성" name="title"/>
</jsp:include>

<div>

  <h1 style="text-align: center;">Upload 게시글 작성하기</h1>
  <form method="post" action="${contextPath}/upload/add.do" enctype="multipart/form-data">
    <div>
      <label for="email">작성자</label>
      <input type="text" class="form-control-plaintext" id="email" value="${sessionScope.user.email}" readonly>
    </div>
    <div>
      <label for="title">제목</label>
      <input type="text" class="form-control" id="title" name="title">
    </div>
    <div>
      <label for="contents">내용</label>
      <textarea rows="12" cols="50" class="form-control" name="contents" id="contents"></textarea>
    </div>
    <div>
      <label for="files">첨부</label>
      <input class="form-control" type="file" name="files"  id="files" multiple>
    </div>
    <div class="d-grid gap-3" style="margin-top: 24px;">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit" class="btn btn-primary">작성완료</button>
    </div>
  </form>
  
  <div id="file_list"></div>
  
</div>
  
<script>

  const fnFileCheck = () => {
    $('#files').change((ev) => {
      $('#file_list').empty();
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          $('#file_list').empty();
          return;
        }
        $('#file_list').append('<div>' + files[i].name + '</div>');
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        $('#file_list').empty();
        return;
      }
    })
  }
  
  fnFileCheck();
  
</script>

<%@ include file="../layout/footer.jsp" %>