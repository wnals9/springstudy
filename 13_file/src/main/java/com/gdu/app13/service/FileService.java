package com.gdu.app13.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public interface FileService {
  public int upload(MultipartHttpServletRequest multipartRequest);
}
