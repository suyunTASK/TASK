package com.example.demo.skedule;

public class PrivateTodo {
	int private_todo_id;
	String todo_name;
	String st_time;
	String ed_time;
	String day;
	String color;
	int user_id;
	public int getPrivateTodoId() {
		return private_todo_id;
	}
	public void setPrivateTodoId(int private_todo_id) {
		this.private_todo_id = private_todo_id;
	}
	public String getTodoName() {
		return todo_name;
	}
	public void setTodoName(String todo_name) {
		this.todo_name = todo_name;
	}
	public String getStTime() {
		return st_time;
	}
	public void setStTime(String st_time) {
		this.st_time = st_time;
	}
	public String getEdTime() {
		return ed_time;
	}
	public void setEdTime(String ed_time) {
		this.ed_time = ed_time;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
}
