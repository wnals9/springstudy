package com.gdu.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gdu.app.dao.BoardMapper;
import com.gdu.app.dto.BoardDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

  private final BoardMapper boardMapper;
  
  @Override
  public List<BoardDto> getBoardList() {
    return boardMapper.getBoardList();
  }
  
  @Override
  public int addBoard(BoardDto boardDto) {
    return boardMapper.addBoard(boardDto);
  }
  
  @Override
  public BoardDto getBoard(int no) {
    return boardMapper.getBoard(no);
  }
  
  @Override
  public int deleteBoard(int no) {
    return boardMapper.deleteBoard(no);
  }
}
