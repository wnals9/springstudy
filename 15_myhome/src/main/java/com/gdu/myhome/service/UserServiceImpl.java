package com.gdu.myhome.service;

import org.springframework.stereotype.Service;

import com.gdu.myhome.dao.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

  private final UserMapper userMapper;
  
}
