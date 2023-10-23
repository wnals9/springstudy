package com.gdu.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.app.dto.BoardDto;

@Mapper
public interface BoardMapper {
  public List<BoardDto> getBoardList();
  public int addBoard(BoardDto boardDto);
  public BoardDto getBoard(int no);
  public int deleteBoard(int no);

}
