package com.gdu.app02.anno02;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class MyJdbcService {
  
  private MyJdbcDao myJdbcDao;
  
  public void add() {
    myJdbcDao.add();
  }
  public void remove() {
    myJdbcDao.remove();
  }
  public void modify() {
    myJdbcDao.modify();
  }
  public void select() {
    myJdbcDao.select();
  }

}
