package com.gdu.movie.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gdu.movie.service.MovieService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MovieController {
  
  private final MovieService movieService;

  @GetMapping(value="/searchAllMovies", produces="application/json")
  public Map<String, Object> searchAllMovies() {
    return movieService.getMovieList();
  }
  
  @GetMapping(value="/searchMovie", produces="application/json")
  public Map<String, Object> searchMovie(@RequestParam Map<String, Object> param){
    String column = (String)param.get("column");
    String searchText = (String)param.get("searchText");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("searchText", searchText);
    return movieService.getSearchList(map);
  }
  
}
