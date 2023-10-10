package com.gdu.app09.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.app09.dto.ContactDto;
import com.gdu.app09.service.ContactService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor  // private final ContactService contactService;에 @Autowired를 하기 위한 코드이다.
@Controller
public class ContactController {

  private final ContactService contactService;
  
  @RequestMapping(value="/contact/list.do", method=RequestMethod.GET)
  public String list(Model model) {
    model.addAttribute("contactList", contactService.getContactList());
    return "contact/list";
  }
  
  @RequestMapping(value="/contact/write.do", method=RequestMethod.GET)
  public String write() {
    return "contact/write";
  }
  
  @RequestMapping(value="/contact/add.do", method=RequestMethod.POST)
  public String add(ContactDto contactDto, RedirectAttributes redirectAttributes) {
    int addResult = contactService.addContact(contactDto);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    return "redirect:/contact/list.do";
  }
  
  @RequestMapping(value="/contact/detail.do", method=RequestMethod.GET)
  public String detail(@RequestParam(value="contact_no", required=false, defaultValue="0") int contact_no, Model model) {
    model.addAttribute("contact", contactService.getContactByNo(contact_no));
    return "contact/detail";
  }
  
  @RequestMapping(value="/contact/modify.do", method=RequestMethod.POST)
  public String modify(ContactDto contactDto, RedirectAttributes redirectAttributes) {
    int modifyResult = contactService.modifyContact(contactDto);
    redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
    return "redirect:/contact/detail.do?contact_no=" + contactDto.getContact_no(); 
  }
  
  @RequestMapping(value="/contact/delete.do", method=RequestMethod.GET)
  public String delete(@RequestParam(value="contact_no", required=false, defaultValue="0") int contact_no, RedirectAttributes redirectAttributes) {
    int deleteResult = contactService.deleteContact(contact_no);
    redirectAttributes.addFlashAttribute("deleteResult", deleteResult);
    return "redirect:/contact/list.do";
  }
  
  
}