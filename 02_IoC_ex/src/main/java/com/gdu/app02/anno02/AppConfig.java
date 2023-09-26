package com.gdu.app02.anno02;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
  
  @Bean
  public MyJdbcConnection myJdbcConnection() {
    MyJdbcConnection jc = new MyJdbcConnection();
    jc.setDriver("oracle.jdbc.OracleDriver");
    jc.setUrl("jdbc:oracle:thin:@127.0.0.1:1521:xe");
    jc.setUser("GD");
    jc.setPassword("1111");
    return jc;
  }
  
  @Bean
  public MyJdbcDao myJdbcDao() {
    return new MyJdbcDao();
  }
  
  @Bean 
  public MyJdbcService myJdbcService() {
   return new MyJdbcService(myJdbcDao());
    
  }

}
