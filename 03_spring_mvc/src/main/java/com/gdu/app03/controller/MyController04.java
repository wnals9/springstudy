package com.gdu.app03.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

@SessionAttributes("title")  // Model에 title이 저장되면 HttpSession에도 같은 값을 저장한다.
@Controller
public class MyController04 {
  
  /************************** 세션에 저장하기 **************************/
  
  /*
   * 1. HttpServletRequest로부터 HttpSession 얻기
   */
  // @GetMapping("/article/add.do")
  public String articleAdd(HttpServletRequest request) {
    
    HttpSession session = request.getSession();
    session.setAttribute("title", request.getParameter("title"));
    
    return "article/result";  //  /WEB-INF/views/article/result.jsp
  }
  
  
  
  /*
   * 2. HttpSession 선언하기
   */
  // @GetMapping("/article/add.do")
  public String add2(HttpSession session, HttpServletRequest request) {
    session.setAttribute("title", request.getParameter("title"));
    return "article/result";
  }
  
  
  
  /*
   * 3. @SessionAttributes
   *  1) 클래스 레벨의 annotation이다.
   *  2) Model에 값을 저장하면 HttpSession에 함께 저장된다.
   */
  @GetMapping("/article/add.do")
  public String add3(HttpServletRequest request, Model model) {
    model.addAttribute("title", request.getParameter("title"));
    return "article/result";
  }
  
  /************************** 세션 정보 삭제하기 **************************/
  
  /*
   * 1. HttpSession 의 invalidate() 메소드
   */
  
  // @GetMapping("/article/main.do")
  public String main(HttpSession session) {
    
    // session 정보 초기화
    session.invalidate();
    
    return "index";
  }
  
  
  
  /*
   * 2. SessionStatus의 setComplete() 메소드
   */
  @GetMapping("/article/main.do")
  public String main2(SessionStatus sessionStatus) {
    // session attribute의 삭제
    sessionStatus.setComplete();
    return "index";
    
  }

}
