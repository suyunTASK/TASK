package com.example.demo.skedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class TeamDAO {
	final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    final String JDBC_URL = "jdbc:mariadb://192.168.162.187/task";


    // DB 연결 메서드
    public Connection open() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "kdk", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // 팀 목록 전체를 가져오는 메서드
    public List<Team> getAllTeams() throws Exception {
        Connection conn = open();
        List<Team> teamList = new ArrayList<>();

        String sql = "SELECT team_id, team_todo_id, team_name FROM team";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                Team team = new Team();
                team.setTeamId(rs.getInt("team_id"));
                team.setTeamTodoId(rs.getInt("team_todo_id"));
                team.setTeamName(rs.getString("team_name"));
                teamList.add(team);
            }
            return teamList;
        }
    }

    // 팀 세부 정보 가져오는 메서드
    public Team getTeam(int teamId) throws SQLException {
        Connection conn = open();
        Team team = new Team();
        String sql = "SELECT team_id, team_todo_id, team_name FROM team WHERE team_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, teamId);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            if (rs.next()) {
                team.setTeamId(rs.getInt("team_id"));
                team.setTeamTodoId(rs.getInt("team_todo_id"));
                team.setTeamName(rs.getString("team_name"));
            }
            return team;
        }
    }

    // 팀 추가 메서드
    public void addTeam(Team team) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO team (team_todo_id, team_name) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, team.getTeamTodoId());
            pstmt.setString(2, team.getTeamName());
            pstmt.executeUpdate();
        }
    }

    // 팀 삭제 메서드
    public void deleteTeam(int teamId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM team WHERE team_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, teamId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 오류: 삭제할 팀이 없습니다.");
            }
        }
    }

    // 팀 수정 메서드
    public void editTeam(Team team) throws Exception {
        Connection conn = open();
        String sql = "UPDATE team SET team_name = ? WHERE team_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, team.getTeamName());
            pstmt.setInt(2, team.getTeamId());
            pstmt.executeUpdate();
        }
    }
}
