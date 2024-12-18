package com.example.demo.skedule;

public class User{
	int user_id;
	String password;
	String name;
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String passward) {
		this.password = passward;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}