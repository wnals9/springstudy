package com.gdu.app.service;

import java.util.List;

import com.gdu.app.dto.NoticeDto;

public interface NoticeService {
  public List<NoticeDto> getNoticeList();
  public int addNotice(NoticeDto noticeDto);
  public NoticeDto getNotice(int noticeNo);
  public int modifyNotice(NoticeDto noticeDto);
}
