package com.example.skedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class UserDAO {
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

    // 모든 사용자 목록 가져오기
    public List<User> getAllUsers() throws Exception {
        Connection conn = open();
        List<User> userList = new ArrayList<>();

        String sql = "SELECT user_id, passward, name FROM user";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setPassward(rs.getString("passward"));
                user.setName(rs.getString("name"));
                userList.add(user);
            }
            return userList;
        }
    }

    // 특정 사용자 정보 가져오기
    public User getUser(int userId) throws SQLException {
        Connection conn = open();
        User user = new User();
        String sql = "SELECT user_id, passward, name FROM user WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            if (rs.next()) {
                user.setUserId(rs.getInt("user_id"));
                user.setPassward(rs.getString("passward"));
                user.setName(rs.getString("name"));
            }
            return user;
        }
    }

    // 사용자 추가 메서드
    public void addUser(User user) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO user (passward, name) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, user.getPassward());
            pstmt.setString(2, user.getName());
            pstmt.executeUpdate();
        }
    }

    // 사용자 삭제 메서드
    public void deleteUser(int userId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM user WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, userId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 오류: 삭제할 사용자가 없습니다.");
            }
        }
    }

    // 사용자 정보 수정 메서드
    public void editUser(User user) throws Exception {
        Connection conn = open();
        String sql = "UPDATE user SET passward = ?, name = ? WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, user.getPassward());
            pstmt.setString(2, user.getName());
            pstmt.setInt(3, user.getUserId());
            pstmt.executeUpdate();
        }
    }
}
