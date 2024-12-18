package com.example.demo.skedule;

public class TeamUsers {
	int team_id;
	int user_id;
	String role;
	boolean Leader;
	public int getTeamId() {
		return team_id;
	}
	public void setTeamId(int team_id) {
		this.team_id = team_id;
	}
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public boolean isLeader() {
		return Leader;
	}
	public void setLeader(boolean leader) {
		Leader = leader;
	}
}
