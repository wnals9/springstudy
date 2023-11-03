package com.gdu.movie.service;

import java.util.Map;

public interface MovieService {
  public Map<String, Object> getMovieList();
  public Map<String, Object> getSearchList(Map<String, Object> map);
}
