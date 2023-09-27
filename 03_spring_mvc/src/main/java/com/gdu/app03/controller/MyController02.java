package com.gdu.app03.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyController02 {

  // Spring 4 버전 이후 사용 가능한 @RequestMapping
  // 1. @GetMapping
  // 2. @PostMapping
  
  @GetMapping(value="/notice/list.do")  // MyController1에 Mapping과 같은 주소이기때문에 오류발생, @PostMapping으로 하면 오류X (같은 주소여도 method가 다르면 다른 요청이다.)
  public String noticeList() {
    // ViewResolver의 prefix : /WEB-INF/views/
    // ViewResolver의 suffix : .jsp
    return "notice/list";  //  /WEB-INF/views/notice/list.jsp
  }
  
  // 반환이 없는 경우에는 요청 주소를 Jsp 경로로 인식한다.
  // /member/list.do 요청을 /member/list.jsp 경로로 인식한다.
  // /member/list    요청을 /member/list.jsp 경로로 인식한다.
  @GetMapping(value={"/member/list.do", "/member/list"})
  public void memberList() {
    
  }
  
}
