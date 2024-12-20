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
public class TeamTodoDAO {
    
	final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    final String JDBC_URL = "jdbc:mariadb://192.168.162.24/task";
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

    // 전체 팀 TODO 목록 가져오기
    public List<TeamTodo> getAllTeamTodos() throws Exception {
        Connection conn = open();
        List<TeamTodo> todoList = new ArrayList<>();

        String sql = "SELECT team_todo_id, todo_name, st_time, ed_time, day, color, user_id, team_id FROM team_todo";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            while (rs.next()) {
                TeamTodo todo = new TeamTodo();
                todo.setTeamTodoId(rs.getInt("team_todo_id"));
                todo.setTodoName(rs.getString("todo_name"));
                todo.setStTime(rs.getString("st_time"));
                todo.setEdTime(rs.getString("ed_time"));
                todo.setDay(rs.getString("day"));
                todo.setColor(rs.getString("color"));
                todo.setUserId(rs.getInt("user_id"));
                todo.setTeamId(rs.getInt("team_id"));
                todoList.add(todo);
            }
            return todoList;
        }
    }

    // 특정 팀 TODO 조회하기
    public TeamTodo getTeamTodo(int teamTodoId) throws SQLException {
        Connection conn = open();
        TeamTodo todo = new TeamTodo();
        String sql = "SELECT team_todo_id, todo_name, st_time, ed_time, day, color, user_id, team_id FROM team_todo WHERE team_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, teamTodoId);
        ResultSet rs = pstmt.executeQuery();

        try (conn; pstmt; rs) {
            if (rs.next()) {
                todo.setTeamTodoId(rs.getInt("team_todo_id"));
                todo.setTodoName(rs.getString("todo_name"));
                todo.setStTime(rs.getString("st_time"));
                todo.setEdTime(rs.getString("ed_time"));
                todo.setDay(rs.getString("day"));
                todo.setColor(rs.getString("color"));
                todo.setUserId(rs.getInt("user_id"));
                todo.setTeamId(rs.getInt("team_id"));
            }
            return todo;
        }
    }

    // 새로운 팀 TODO 추가하기
    public void addTeamTodo(TeamTodo todo) throws Exception {
        Connection conn = open();
        String sql = "INSERT INTO team_todo (todo_name, st_time, ed_time, day, color, user_id, team_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, todo.getTodoName());
            pstmt.setString(2, todo.getStTime());
            pstmt.setString(3, todo.getEdTime());
            pstmt.setString(4, todo.getDay());
            pstmt.setString(5, todo.getColor());
            pstmt.setInt(6, todo.getUserId());
            pstmt.setInt(7, todo.getTeamId());
            pstmt.executeUpdate();
        }
    }

    // 팀 TODO 수정하기
    public void editTeamTodo(TeamTodo todo) throws Exception {
        Connection conn = open();
        String sql = "UPDATE team_todo SET todo_name = ?, st_time = ?, ed_time = ?, day = ?, color = ?, user_id = ?, team_id = ? WHERE team_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setString(1, todo.getTodoName());
            pstmt.setString(2, todo.getStTime());
            pstmt.setString(3, todo.getEdTime());
            pstmt.setString(4, todo.getDay());
            pstmt.setString(5, todo.getColor());
            pstmt.setInt(6, todo.getUserId());
            pstmt.setInt(7, todo.getTeamId());
            pstmt.setInt(8, todo.getTeamTodoId());
            pstmt.executeUpdate();
        }
    }

    // 팀 TODO 삭제하기
    public void deleteTeamTodo(int teamTodoId) throws SQLException {
        Connection conn = open();
        String sql = "DELETE FROM team_todo WHERE team_todo_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        try (conn; pstmt) {
            pstmt.setInt(1, teamTodoId);
            if (pstmt.executeUpdate() == 0) {
                throw new SQLException("DB 오류: 삭제할 팀 TODO가 없습니다.");
            }
        }
    }
}