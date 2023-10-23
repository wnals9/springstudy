package com.gdu.app.service;

import java.util.List;

import com.gdu.app.dto.BoardDto;

public interface BoardService {
  public List<BoardDto> getBoardList();
  public int addBoard(BoardDto boardDto);
  public BoardDto getBoard(int no);
  public int deleteBoard(int no);
}
