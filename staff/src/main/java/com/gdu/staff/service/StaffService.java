package com.gdu.staff.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.gdu.staff.dto.StaffDto;

public interface StaffService {
  public ResponseEntity<Map<String, Object>> registerStaff(StaffDto staff);
  public List<StaffDto> getStaffList();
  public Map<String, Object> getStaff(String sno);
  
}
