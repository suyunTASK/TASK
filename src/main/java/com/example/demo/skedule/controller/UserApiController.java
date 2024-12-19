package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.User;
import com.example.demo.skedule.UserDAO;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserApiController {
	final UserDAO userDAO;

	@Autowired
	public UserApiController(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	// 사용자 등록
	@PostMapping(consumes = "multipart/form-data")
	public String signup(@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("confirm-password") String confirmPassword) throws Exception {
		if (!password.equals(confirmPassword)) {
			return "redirect:/views/signup.jsp";
		}

		User user = new User();
		user.setUsername(username);
		user.setPassword(password);

		try {
			userDAO.addUser(user);
		} catch (SQLException e) {
			e.printStackTrace();
			return "redirect:/views/signup.jsp";
		}
		return "redirect:/views/login.jsp";
	}

	// 사용자 로그인
	@PostMapping("/login")
	public String login(@RequestParam("username") String username, @RequestParam("password") String password) {
		try {
			User user = userDAO.getUserByName(username); // 사용자 이름으로 검색
			if (user != null && user.getPassword().equals(password)) {
				return "redirect:/views/main.jsp";
			} else {
				return "redirect:/views/login.jsp";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/views/login.jsp";
		}
	}

	// 사용자 삭제
	@DeleteMapping("/{id}")
	public String deleteUser(@PathVariable("id") int userId) {
		try {
			userDAO.deleteUser(userId);
		} catch (Exception e) {
			e.printStackTrace();
			return "User API: 사용자 삭제 실패!";
		}
		return "User API: 사용자 삭제됨!";
	}

	// 사용자 목록 조회
	@GetMapping
	public List<User> getAllUsers() throws Exception {
		return userDAO.getAllUsers();
	}

	// 특정 사용자 상세 정보
	@GetMapping("/{username}")
	public User getUserByName(@PathVariable("username") String username) throws SQLException {
		return userDAO.getUserByName(username);
	}
}
