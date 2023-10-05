package com.gdu.app05.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gdu.app05.dao.BoardDao;
import com.gdu.app05.dto.BoardDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor  // final field 전용 생성자를 만들어주는 Annotation 
                          // @Autowired를 이용한 생성자 주입을 위해서 추가한다.

@Service  // 서비스 계층(Business Layer) 전용 @Component, Spring Container에 BoardService boardServiceImpl 객체를 생성해 둔다.
public class BoardServiceImpl implements BoardService {

  //주입된 boardDao 객체의 변경 방지를 위해 final 처리한다.
  private final BoardDao boardDao;
  
  @Override
  public List<BoardDto> getBoardList() {
    return boardDao.getBoardList();
  }

}
