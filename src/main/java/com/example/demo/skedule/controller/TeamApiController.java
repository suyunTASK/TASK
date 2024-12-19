package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.Team;
import com.example.demo.skedule.TeamDAO;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/api/teams")
public class TeamApiController {
    final TeamDAO teamDAO;

    @Autowired
    public TeamApiController(TeamDAO teamDAO) {
        this.teamDAO = teamDAO;
    }

    // 팀 등록
    @PostMapping
    public String addTeam(@RequestBody Team team) {
        try {
            teamDAO.addTeam(team);
        } catch (Exception e) {
            e.printStackTrace();
            return "Team API: 팀 등록 실패!";
        }
        return "Team API: 팀 등록됨!";
    }

    // 팀 삭제
    @DeleteMapping("/{id}")
    public String deleteTeam(@PathVariable("id") int teamId) {
        try {
            teamDAO.deleteTeam(teamId);
        } catch (Exception e) {
            e.printStackTrace();
            return "Team API: 팀 삭제 실패!";
        }
        return "Team API: 팀 삭제됨!";
    }

    // 팀 목록 조회
    @GetMapping
    public List<Team> getAllTeams() throws Exception {
        return teamDAO.getAllTeamsById(1);
    }

    // 특정 팀 상세 정보
    @GetMapping("/{id}")
    public Team getTeamById(@PathVariable("id") int teamId) throws SQLException {
        return teamDAO.getTeam(teamId);
    }
}
