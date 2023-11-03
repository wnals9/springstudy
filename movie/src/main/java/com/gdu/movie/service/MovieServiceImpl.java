package com.gdu.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gdu.movie.dao.MovieMapper;
import com.gdu.movie.dto.MovieDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {

  private final MovieMapper movieMapper;
  
  @Override
  public Map<String, Object> getMovieList() {
    
    int movieCount = movieMapper.getMovieCount();
    List<MovieDto> list = movieMapper.getMovieList();
    
    return Map.of("message", "전체 " + movieCount + "개의 목록을 가져왔습니다."
                , "list", list
                , "status", 200);
  }
  
  @Override
  public Map<String, Object> getSearchList(Map<String, Object> map) {
    
    String searchText = (String)map.get("searchText");
    int searchCount = movieMapper.getSearchCount(map);
    List<MovieDto> list = movieMapper.getSearchList(map);
    
    if(searchCount == 0) {
      return Map.of("message", searchText + " 검색 결과가 없습니다."
          , "list", list
          , "status", 500);
    } else {
      return Map.of("message", searchCount + "개의 검색 결과가 있습니다."
          , "list", list
          , "status", 200);
    }
    
  }
  
}
