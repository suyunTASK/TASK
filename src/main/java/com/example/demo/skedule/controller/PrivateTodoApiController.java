package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.PrivateTodo;
import com.example.demo.skedule.PrivateTodoDAO;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/api/private-todos")
public class PrivateTodoApiController {
    final PrivateTodoDAO privateTodoDAO;

    @Autowired
    public PrivateTodoApiController(PrivateTodoDAO privateTodoDAO) {
        this.privateTodoDAO = privateTodoDAO;
    }

    // 개인 할일 등록
    @PostMapping
    public String addPrivateTodo(@RequestBody PrivateTodo privateTodo) {
        try {
            privateTodoDAO.addPrivateTodo(privateTodo);
        } catch (Exception e) {
            e.printStackTrace();
            return "PrivateTodo API: 할일 등록 실패!";
        }
        return "PrivateTodo API: 할일 등록됨!";
    }

    // 개인 할일 삭제
    @DeleteMapping("/{id}")
    public String deletePrivateTodo(@PathVariable("id") int privateTodoId) {
        try {
            privateTodoDAO.deletePrivateTodo(privateTodoId);
        } catch (Exception e) {
            e.printStackTrace();
            return "PrivateTodo API: 할일 삭제 실패!";
        }
        return "PrivateTodo API: 할일 삭제됨!";
    }

    // 개인 할일 목록 조회
    @GetMapping
    public List<PrivateTodo> getAllPrivateTodos() throws Exception {   
    	return privateTodoDAO.getAllPrivateTodos();
    }

    // 특정 할일 상세 정보
    @GetMapping("/{id}")
    public PrivateTodo getPrivateTodoById(@PathVariable("id") int privateTodoId) throws SQLException {
        return privateTodoDAO.getPrivateTodo(privateTodoId);
    }
}

