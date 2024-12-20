package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.User;
import com.example.demo.skedule.UserDAO;

import jakarta.servlet.http.HttpSession;

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
			@RequestParam("confirm-password") String confirmPassword) {
		if (!password.equals(confirmPassword)) {
			return "User API: 비밀번호가 일치하지 않습니다!";
		}

		User user = new User();
		user.setUsername(username);
		user.setPassword(password);

		try {
			userDAO.addUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			return "User API: 사용자 등록 실패!";
		}
		return "redirect:/views/login.jsp";
	}
	
	// 사용자 로그아웃
	@PostMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();  // 세션 무효화
	    return "redirect:/views/login.jsp";
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