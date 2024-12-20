package com.example.skedule;

public class User {
	private int userId;
	private String password;
	private String name;

	public User() {
	}

	public User(String name, String password) {
		this.name = name;
		this.password = password;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}