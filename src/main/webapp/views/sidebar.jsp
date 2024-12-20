<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>TASK</title>
<style>
.sidebar {
	width: 280px;
	background: linear-gradient(180deg, #2c3e50, #3498db);
	color: white;
	padding: 24px 20px;
	animation: slideIn 0.5s ease-out;
	display: flex;
	flex-direction: column;
	gap: 20px;
}

/* 로고 스타일 */
.logo {
	font-size: 1.7em;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	padding: 8px 0;
}

/* 팀 리더 정보 섹션 */
.team-leader {
	display: flex;
	align-items: center;
	padding: 16px;
	background: linear-gradient(145deg, rgba(255, 255, 255, 0.15));
	border-radius: 16px;
	border: 1px solid rgba(255, 255, 255, 0.2); /* 테두리 색상 밝게 */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1), inset 0 1px 1px
		rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(5px);
	transition: all 0.3s ease;
}

.team-leader:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15), inset 0 1px 1px
		rgba(255, 255, 255, 0.2);
	background: linear-gradient(145deg, rgba(255, 255, 255, 0.18),
		rgba(255, 255, 255, 0.1));
	border: 1px solid rgba(255, 255, 255, 0.3); /* Hover 시 테두리 색상 밝게 */
}

.team-leader img {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	margin-right: 16px;
	border: 2px solid rgba(255, 255, 255, 0.2);
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
}

.team-leader:hover img {
	border-color: rgba(255, 255, 255, 0.3);
	transform: scale(1.05);
}

.team-leader div {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.team-leader div>div {
	font-size: 1.1em;
	font-weight: 500;
	color: rgba(255, 255, 255, 0.95);
	letter-spacing: 0.3px;
}

.team-leader small {
	color: rgba(255, 255, 255, 1);
	font-size: 0.85em;
	font-weight: 400;
	letter-spacing: 0.5px;
	text-transform: uppercase;
	background: rgba(243, 156, 18, 1);
	padding: 3px 8px;
	border-radius: 12px;
	align-self: flex-start;
	transition: all 0.3s ease;
}

.team-leader:hover small {
	background: rgba(243, 156, 18, 0.8);
	color: rgba(255, 255, 255, 0.8);
}

/* 프로젝트 카테고리 섹션 */
.project-category {
	margin-bottom: 24px;
}

.category-header {
	font-weight: 500;
	color: #ecf0f1;
	margin-bottom: 16px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1.1em;
	padding: 0 8px;
}

.project-list {
	margin-left: 8px;
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.project-item {
	padding: 12px 16px;
	border-radius: 8px;
	cursor: pointer;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
}

.project-item:hover {
	background: rgba(255, 255, 255, 0.15);
	transform: translateX(4px);
}

.project-item.active {
	background: rgba(255, 255, 255, 0.2);
	font-weight: 500;
}

/* 프로젝트 추가 버튼 */
.add-project-btn {
	background: none;
	border: 1.5px dashed rgba(255, 255, 255, 0.4);
	color: #ecf0f1;
	cursor: pointer;
	padding: 10px 16px;
	border-radius: 8px;
	font-size: 1.0em;
	transition: all 0.3s ease;
	width: 100%;
	margin-top: 16px;
}

.add-project-btn:hover {
	background: rgba(255, 255, 255, 0.1);
	border-color: rgba(255, 255, 255, 0.6);
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 로그인한 사용자 ID를 세션에서 가져와서 Ajax 요청에 포함시킴
$(document).ready(function() {
    let userId = <%= session.getAttribute("user_id") %>;  // 세션에서 user_id 가져오기

    $.get('/teams?user_id=' + userId, function(data) {
        let teamProjectsContainer = $('#team-projects');
        data.forEach(function(team) {
            let projectItem = "<div class="project-item">${team.teamName}</div>"";
            teamProjectsContainer.append(projectItem);
        });
    });
});
</script>
</head>
<body>
	<div class="sidebar">
		<div class="logo" onClick="location.href='main'">TASK</div>

		<div class="team-leader">
			<img src="/images/user.png" alt="Team Leader">
			<div>
				<div>${userName}</div>
				<small>팀장</small>
			</div>
		</div>

		<div class="project-category">
			<div class="category-header">개인 프로젝트</div>
			<div class="project-list" id="personal-projects">
				<div class="project-item active">개인 프로젝트</div>
			</div>
		</div>

		<div class="project-category">
			<div class="category-header">팀 프로젝트</div>
			<div class="project-list" id="team-projects">
				<!-- 동적으로 팀 목록 추가됨 -->
			</div>
			<div class="project-category">
				<button class="add-project-btn" onclick="location.href='addProject'">+ 프로젝트 추가</button>
			</div>
		</div>
	</div>
</body>
</html>
