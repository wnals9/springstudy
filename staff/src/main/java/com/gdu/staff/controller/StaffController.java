package com.gdu.staff.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.staff.dto.StaffDto;
import com.gdu.staff.service.StaffService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StaffController {

  private final StaffService staffService;
  
  @PostMapping(value="/add.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> add(StaffDto staff) {
    return staffService.registerStaff(staff);
  }
  
  @GetMapping(value="/list.json", produces="application/json")
  @ResponseBody
  public List<StaffDto> getStaffList() {
    return staffService.getStaffList();
  }
  
  @GetMapping(value="/query.json", produces="application/json")
  @ResponseBody
  public Map<String, Object> getStaff(@RequestParam(value="query") String sno) {
    return staffService.getStaff(sno);
  }
  
  
}
