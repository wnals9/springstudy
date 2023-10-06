package com.gdu.app07.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gdu.app07.dto.AjaxDto;
import com.gdu.app07.service.AjaxService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AjaxController3 {
  
  private final AjaxService ajaxService;
  
  @GetMapping(value="/ajax3/list.do", produces="application/json; charset=UTF-8")
  public ResponseEntity<List<AjaxDto>> list(){
    return new ResponseEntity<List<AjaxDto>>(  // ResponseEntity는 @ResponseBody를 작성하지 않는다.
                 ajaxService.getDtoList()      // 실제 응답 데이터
               , HttpStatus.OK);               // 응답 코드 (200)
  }

}
