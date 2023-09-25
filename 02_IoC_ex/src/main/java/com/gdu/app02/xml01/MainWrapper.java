package com.gdu.app02.xml01;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class MainWrapper {

  public static void main(String[] args) {
    AbstractApplicationContext ctx = new GenericXmlApplicationContext("xml01/appCtx.xml");
    
    Person person = ctx.getBean("person", Person.class);
    
    System.out.println("이름: " + person.getName());
    System.out.println("핸드폰: " + person.getContact().getMobile());
    System.out.println("팩스: " + person.getContact().getFax());
    System.out.println("우편번호: " + person.getAddress().getPostcode());
    System.out.println("지번: " + person.getAddress().getJibun());
    System.out.println("도로명: " + person.getAddress().getRoad());
    
  }

}
