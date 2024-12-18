package com.example.skedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    private static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://192.168.162.187/task";
    private static final String DB_USER = "kdk";
    private static final String DB_PASSWORD = "1234";
    
    public boolean registerUser(User user) throws SQLException {
    	String sql = "INSERT INTO user (name, password) VALUES (?, ?)";
    	
    	try(Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    			PreparedStatement statement = connection.prepareStatement(sql)) {
    				
    		if(isNameTaken(user.getName())) {
    			return false;
    		}
    		
    		statement.setString(1,  user.getName());
    		statement.setString(2,  user.getPassword());
    		int rowsInserted = statement.executeUpdate();
    		
    		return rowsInserted > 0;
    	
    	} catch (Exception e) {
    		e.printStackTrace();
    		return false;
    	}
    }
    
    public boolean checkLogin(String name, String password) {
    	String sql = "SELECT * FROM user WHERE name = ? AND password = ?";
    	
    	try(Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    			PreparedStatement statement = connection.prepareStatement(sql)) {
    		
    		statement.setString(1,  name);
    		statement.setString(2,  password);
    		ResultSet resultSet = statement.executeQuery();
    		
    		return resultSet.next();
    		
    	} catch(Exception e) {
    		e.printStackTrace();
    		return false;
    	}
    }

    private boolean isNameTaken(String name) throws SQLException {
    	String sql = "SELECT * FROM user WHERE name = ?";
    	
    	try(Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    			PreparedStatement statement = connection.prepareStatement(sql)) {
    		
    		statement.setString(1, name);
    		ResultSet resultSet = statement.executeQuery();
    		
    		return resultSet.next();
    		
    	} catch(Exception e) {
    		e.printStackTrace();
    		return true;
    	}
    }

}
