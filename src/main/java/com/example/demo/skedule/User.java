package com.example.demo.skedule;

public class User{
	int user_id;
	String username;
	String password;

	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String name) {
		this.username = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String passward) {
		this.password = passward;
	}
}