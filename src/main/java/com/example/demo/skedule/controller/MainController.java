package com.example.demo.skedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@GetMapping("/main")
	public String showMainPage(HttpSession session, Model model) {
		String userName = (String) session.getAttribute("userName");
		
		if(userName == null) {
			return "redirect:/views/login.jsp";
		}
		
		model.addAttribute("userName", userName);
		return "redirect:/views/main.jsp";
	}
}
