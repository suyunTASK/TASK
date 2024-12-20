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
public class TeamUsersDAO {
	final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    final String JDBC_URL = "jdbc:mariadb://localhost:3306/task";
 
    // DB 연결 메서드
    public Connection open() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // 모든 팀 사용자 목록 가져오기
    public List<TeamUsers> getAllTeamUsers() throws Exception {
        Connection conn = open();
        List<TeamUsers> teamUsersList = new ArrayList<>();

        String sql = "SELECT team_id, user_id, role, Leader FROM team_users";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                TeamUsers teamUser = new TeamUsers();
                teamUser.setTeamId(rs.getInt("team_id"));
                teamUser.setUserId(rs.getInt("user_id"));
                teamUser.setRole(rs.getString("role"));
                teamUser.setLeader(rs.getBoolean("Leader"));
                teamUsersList.add(teamUser);
            }
            return teamUsersList;
        }
    }

    // 특정 팀 사용자 정보 가져오기
    public TeamUsers getTeamUser(int teamId, int userId) throws SQLException {
        Connection conn = open();
        TeamUsers teamUser = new TeamUsers();
        String sql = "SELECT team_id, user_id, role, Leader FROM team_users WHERE team_id = ? AND user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, teamId);
        pstmt.setInt(2, userId);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            if (rs.next()) {
                teamUser.setTeamId(rs.getInt("team_id"));
                teamUser.setUserId(rs.getInt("user_id"));
                teamUser.setRole(rs.getString("role"));
                teamUser.setLeader(rs.getBoolean("Leader"));
            }
            return teamUser;
        }
    }

    // 팀 사용자 추가 메서드
    public void addTeamUser(TeamUsers teamUser) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO team_users (team_id, user_id, role, Leader) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, teamUser.getTeamId());
            pstmt.setInt(2, teamUser.getUserId());
            pstmt.setString(3, teamUser.getRole());
            pstmt.setBoolean(4, teamUser.isLeader());
            pstmt.executeUpdate();
        }
    }

    // 팀 사용자 삭제 메서드
    public void deleteTeamUser(int teamId, int userId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM team_users WHERE team_id = ? AND user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, teamId);
            pstmt.setInt(2, userId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 오류: 삭제할 팀 사용자가 없습니다.");
            }
        }
    }

    // 팀 사용자 역할 수정 메서드
    public void editTeamUser(TeamUsers teamUser) throws Exception {
        Connection conn = open();
        String sql = "UPDATE team_users SET role = ?, Leader = ? WHERE team_id = ? AND user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, teamUser.getRole());
            pstmt.setBoolean(2, teamUser.isLeader());
            pstmt.setInt(3, teamUser.getTeamId());
            pstmt.setInt(4, teamUser.getUserId());
            pstmt.executeUpdate();
        }
    }
}