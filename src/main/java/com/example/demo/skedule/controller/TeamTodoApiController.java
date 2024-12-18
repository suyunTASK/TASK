package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.TeamTodo;
import com.example.demo.skedule.TeamTodoDAO;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/api/team-todos")
public class TeamTodoApiController {
    final TeamTodoDAO teamTodoDAO;

    @Autowired
    public TeamTodoApiController(TeamTodoDAO teamTodoDAO) {
        this.teamTodoDAO = teamTodoDAO;
    }

    // 팀 할일 등록
    @PostMapping
    public String addTeamTodo(@RequestBody TeamTodo teamTodo) {
        try {
            teamTodoDAO.addTeamTodo(teamTodo);
        } catch (Exception e) {
            e.printStackTrace();
            return "TeamTodo API: 할일 등록 실패!";
        }
        return "TeamTodo API: 할일 등록됨!";
    }

    // 팀 할일 삭제
    @DeleteMapping("/{id}")
    public String deleteTeamTodo(@PathVariable("id") int teamTodoId) {
        try {
            teamTodoDAO.deleteTeamTodo(teamTodoId);
        } catch (Exception e) {
            e.printStackTrace();
            return "TeamTodo API: 할일 삭제 실패!";
        }
        return "TeamTodo API: 할일 삭제됨!";
    }

    // 팀 할일 목록 조회
    @GetMapping
    public List<TeamTodo> getAllTeamTodos() throws Exception {
        return teamTodoDAO.getAllTeamTodos();
    }

    // 특정 할일 상세 정보
    @GetMapping("/{id}")
    public TeamTodo getTeamTodoById(@PathVariable("id") int teamTodoId) throws SQLException {
        return teamTodoDAO.getTeamTodo(teamTodoId);
    }
}

