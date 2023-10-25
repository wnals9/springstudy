package com.gdu.staff.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.gdu.staff.dao.StaffMapper;
import com.gdu.staff.dto.StaffDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StaffServiceImpl implements StaffService {
  
  private final StaffMapper staffMapper;
  
  @Override
  public ResponseEntity<Map<String, Object>> registerStaff(StaffDto staff) {
    int addResult = 0;
    Map<String, Object> map = new HashMap<>();
    try {
      addResult = staffMapper.insertStaff(staff);
      map.put("addResult", addResult);
      return new ResponseEntity<>(map, HttpStatus.OK);
    } catch (Exception e) {
      map.put("addResult", addResult);
      return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
  
  @Override
  public List<StaffDto> getStaffList() {
    
    List<StaffDto> staffList = staffMapper.getStaffList();
    
    return staffList;
  }
  
  @Override
  public Map<String, Object> getStaff(String sno) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("staff" ,staffMapper.getStaff(sno));
    return map;
  }
  
}
