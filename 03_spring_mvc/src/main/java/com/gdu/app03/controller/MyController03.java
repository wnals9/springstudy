package com.gdu.app03.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller  // 컨트롤러를 만드는 Annotation
public class MyController03 {
    
  @RequestMapping("/blog/detail.do")  // GET 방식의 method는 생략할 수 있다. value만 작성할 땐 value는= 부분도 생략할 수 있다.
  public String blogDetail(HttpServletRequest request) {
    String blogNo = request.getParameter("blogNo");
    // ViewResolver의 prefix : /WEB-INF/views/
    // ViewResolver의 suffix : .jsp
    request.setAttribute("blogNo", blogNo);
    return "blog/detail";  //  /WEB-INF/views/blog/detail.jsp  forward한다.
  }
  
}
