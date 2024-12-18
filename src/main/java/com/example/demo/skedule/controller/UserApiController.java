package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.User;
import com.example.demo.skedule.UserDAO;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserApiController {
    final UserDAO userDAO;

    @Autowired
    public UserApiController(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    // 사용자 등록
    @PostMapping
    public String addUser(@RequestBody User user) {
        try {
            userDAO.addUser(user);
        } catch (Exception e) {
            e.printStackTrace();
            return "User API: 사용자 등록 실패!";
        }
        return "User API: 사용자 등록됨!";
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
    @GetMapping("/{id}")
    public User getUserById(@PathVariable("id") int userId) throws SQLException {
        return userDAO.getUser(userId);
    }
}
