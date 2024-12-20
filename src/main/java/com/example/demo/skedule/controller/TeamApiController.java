package com.example.demo.skedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo.skedule.Team;
import com.example.demo.skedule.TeamDAO;
import com.example.demo.skedule.User;
import com.example.demo.skedule.UserDAO;

import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/teams")
public class TeamApiController {
    final TeamDAO teamDAO;
    final UserDAO userDAO;

    @Autowired
    public TeamApiController(TeamDAO teamDAO) {
        this.teamDAO = teamDAO;
		this.userDAO = new UserDAO();
    }

    // 팀 등록
    @PostMapping(consumes = "multipart/form-data")
    public String addTeam(@RequestParam("team_name") String team_name) {
        Team team = new Team();
        team.setTeamName(team_name);
    	
    	try {
            teamDAO.addTeam(team);
        } catch (Exception e) {
            e.printStackTrace();
            return "Team API: 팀 등록 실패!";
        }
        return "redirect:/views/main.jsp";
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
    @GetMapping("/teams")
    public List<Team> getAllTeams(HttpSession session) throws Exception {
        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("user_id");
        if (username == null || userId == null) {
            throw new IllegalStateException("로그인 정보가 없습니다.");
        }
        User user = userDAO.getUserByName(username);
        return teamDAO.getAllTeamsById(user.getUserId());
    }

    // 특정 팀 상세 정보
    @GetMapping("/{id}")
    public Team getTeamById(@PathVariable("id") int teamId) throws SQLException {
        return teamDAO.getTeam(teamId);
    }
}
