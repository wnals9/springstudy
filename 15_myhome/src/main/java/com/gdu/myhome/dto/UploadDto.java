package com.gdu.myhome.dto;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class UploadDto {
  
  private int uploadNo;
  private String title;
  private String contents;
  private String createdAt;
  private String modifiedAt;
  private UserDto userDto;  // private int userNo;
}
