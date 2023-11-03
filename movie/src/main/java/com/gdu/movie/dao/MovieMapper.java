package com.gdu.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.movie.dto.MovieDto;

@Mapper
public interface MovieMapper {
  public int getMovieCount();
  public int getSearchCount(Map<String, Object> map);
  public List<MovieDto> getMovieList();
  public List<MovieDto> getSearchList(Map<String, Object> map);
}
