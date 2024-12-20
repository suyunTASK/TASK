package com.example.demo.skedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
public class PrivateTodoDAO {
	
	final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    final String JDBC_URL = "jdbc:mariadb://172.30.1.16/task";

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

    // 전체 개인 TODO 목록 가져오기
    public List<PrivateTodo> getAllPrivateTodos() throws Exception {
        Connection conn = open();
        List<PrivateTodo> todoList = new ArrayList<>();

        String sql = "SELECT private_todo_id, todo_name, st_time, ed_time, day, color, user_id FROM private_todo";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                PrivateTodo todo = new PrivateTodo();
                todo.setPrivateTodoId(rs.getInt("private_todo_id"));
                todo.setTodoName(rs.getString("todo_name"));
                todo.setStTime(rs.getString("st_time"));
                todo.setEdTime(rs.getString("ed_time"));
                todo.setDay(rs.getString("day"));
                todo.setColor(rs.getString("color"));
                todo.setUserId(rs.getInt("user_id"));
                todoList.add(todo);
            }
            return todoList;
        }
    }

    // 특정 개인 TODO 조회하기
    public PrivateTodo getPrivateTodo(int privateTodoId) throws SQLException {
        Connection conn = open();
        PrivateTodo todo = new PrivateTodo();
        String sql = "SELECT private_todo_id, todo_name, st_time, ed_time, day, color, user_id FROM private_todo WHERE private_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, privateTodoId);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            if (rs.next()) {
                todo.setPrivateTodoId(rs.getInt("private_todo_id"));
                todo.setTodoName(rs.getString("todo_name"));
                todo.setStTime(rs.getString("st_time"));
                todo.setEdTime(rs.getString("ed_time"));
                todo.setDay(rs.getString("day"));
                todo.setColor(rs.getString("color"));
                todo.setUserId(rs.getInt("user_id"));
            }
            return todo;
        }
    }

    // 새로운 개인 TODO 추가하기
    public void addPrivateTodo(PrivateTodo todo) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO private_todo (todo_name, st_time, ed_time, day, color, user_id) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, todo.getTodoName());
            pstmt.setString(2, todo.getStTime());
            pstmt.setString(3, todo.getEdTime());
            pstmt.setString(4, todo.getDay());
            pstmt.setString(5, todo.getColor());
            pstmt.setInt(6, todo.getUserId());
            pstmt.executeUpdate();
        }
    }

    // 개인 TODO 수정하기
    public void editPrivateTodo(PrivateTodo todo) throws Exception {
        Connection conn = open();
        String sql = "UPDATE private_todo SET todo_name = ?, st_time = ?, ed_time = ?, day = ?, color = ?, user_id = ? WHERE private_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, todo.getTodoName());
            pstmt.setString(2, todo.getStTime());
            pstmt.setString(3, todo.getEdTime());
            pstmt.setString(4, todo.getDay());
            pstmt.setString(5, todo.getColor());
            pstmt.setInt(6, todo.getUserId());
            pstmt.setInt(7, todo.getPrivateTodoId());
            pstmt.executeUpdate();
        }
    }

    // 개인 TODO 삭제하기
    public void deletePrivateTodo(int privateTodoId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM private_todo WHERE private_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, privateTodoId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 오류: 삭제할 개인 TODO가 없습니다.");
            }
        }
    }
}