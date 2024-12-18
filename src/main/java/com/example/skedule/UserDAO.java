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

    // 로그인 메서드
    public boolean checkLogin(String name, String password) {
        Connection conn = open();
        String sql = "SELECT * FROM user WHERE name = ? AND passward = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true; // 로그인 성공
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 로그인 실패
    }

    // 회원가입 메서드 (아이디 중복 검사 후 회원 등록)
    public boolean registerUser(User user) {
        if (isNameExists(user.getName())) {
            return false; // 중복된 이름 존재
        }
        Connection conn = open();
        String sql = "INSERT INTO user (passward, name) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getPassward());
            pstmt.setString(2, user.getName());
            pstmt.executeUpdate();
            return true; // 회원가입 성공
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 회원가입 실패
    }

    // 아이디 중복 검사 메서드
    private boolean isNameExists(String name) {
        Connection conn = open();
        String sql = "SELECT * FROM user WHERE name = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true; // 중복된 아이디 존재
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 기존 코드 (모든 사용자 가져오기)
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
}
