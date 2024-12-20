package com.example.demo.skedule;

public class PrivateTodo {
	private int privateTodoId;
	private String todoName;
	private String stTime;
	private String edTime;
	private String stDay;
	private String edDay;
	private String color;
	private int userId;

	public int getPrivateTodoId() {
		return privateTodoId;
	}

	public void setPrivateTodoId(int privateTodoId) {
		this.privateTodoId = privateTodoId;
	}

	public String getTodoName() {
		return todoName;
	}

	public void setTodoName(String todoName) {
		this.todoName = todoName;
	}

	public String getStTime() {
		return stTime;
	}

	public void setStTime(String stTime) {
		this.stTime = stTime;
	}

	public String getEdTime() {
		return edTime;
	}

	public void setEdTime(String edTime) {
		this.edTime = edTime;
	}

	public String getStDay() {
		return stDay;
	}

	public void setStDay(String stDay) {
		this.stDay = stDay;
	}

	public String getEdDay() {
		return edDay;
	}

	public void setEdDay(String edDay) {
		this.edDay = edDay;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}