<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>새 업무 추가</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	min-height: 100vh;
	background: #f5f7fa;
}

/* 사이드바 기본 스타일 */
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

/* 메인 콘텐츠 영역 */
.main-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	padding: 20px;
}

.add-task-container {
	background: white;
	border-radius: 10px;
	padding: 30px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	max-width: 600px;
	width: 100%;
	margin: 0 auto;
	animation: fadeIn 0.5s ease-out;
}

.form-title {
	text-align: center;
	margin-bottom: 30px;
	color: #2c3e50;
	font-size: 1.5em;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	color: #34495e;
	font-weight: 500;
}

.form-group input, .form-group select, .form-group textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 1em;
}

.form-group textarea {
	min-height: 100px;
	resize: vertical;
}

/* 우선순위 선택 스타일 */
.priority-selection {
	display: flex;
	gap: 10px;
	margin-bottom: 10px;
}

.priority-badge {
	padding: 8px 15px;
	border-radius: 20px;
	cursor: pointer;
	transition: all 0.3s ease;
	opacity: 0.6;
}

.priority-badge.selected {
	opacity: 1;
	transform: scale(1.05);
}

.priority-high {
	background: #ff7675;
	color: white;
}

.priority-medium {
	background: #fdcb6e;
	color: white;
}

.priority-low {
	background: #81ecec;
	color: white;
}

/* 담당자 다중 선택 스타일 */
.assignee-selection {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.assignee-option {
	display: flex;
	align-items: center;
	background: #f1f3f5;
	padding: 8px 12px;
	border-radius: 20px;
	cursor: pointer;
	transition: all 0.3s ease;
	border: 1px solid transparent; /* 기본 테두리는 투명 */
}

.assignee-option input {
	display: none;
}

.assignee-option.selected {
	background: #3498db;
	color: white;
	border: 1px solid #2980b9; /* 선택된 경우 테두리 추가 */
	transform: scale(1.05); /* 선택 시 크기 변화 */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 */
}

.btn-group {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

.btn {
	padding: 10px 20px;
	border-radius: 6px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.btn-primary {
	background: #3498db;
	color: white;
	border: none;
}

.btn-secondary {
	background: #f1f3f5;
	color: #2c3e50;
	border: 1px solid #ddd;
}

.btn-primary:hover {
	background: #2980b9;
}

.btn-secondary:hover {
	background: #e9ecef;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes slideIn {from { transform:translateX(-100%);
	opacity: 0;
}

to {
	transform: translateX(0);
	opacity: 1;
}

}
.assignee-selected-list {
	margin-top: 10px;
	font-size: 0.9em;
	color: #2c3e50;
}
</style>
</head>
<body>
	<!-- 사이드바 -->
	<div class="sidebar">
		<div class="logo" onClick="location.href='main.jsp'">TASK</div>


		<!-- 팀 리더 정보 -->
		<div class="team-leader">
			<img src="/api/placeholder/40/40" alt="Team Leader">
			<div>
				<div>김지훈</div>
				<small>팀장</small>
			</div>
		</div>

		<!-- 개인 프로젝트 섹션 -->
		<div class="project-category">
			<div class="category-header">개인 프로젝트</div>
			<div class="project-list" id="personal-projects">
				<div class="project-item active">개인 프로젝트 1</div>
				<div class="project-item">개인 프로젝트 2</div>
			</div>
		</div>

		<!-- 팀 프로젝트 섹션 -->
		<div class="project-category">
			<div class="category-header">팀 프로젝트</div>
			<div class="project-list" id="team-projects">
				<div class="project-item">팀 프로젝트 1</div>
				<div class="project-item">팀 프로젝트 2</div>
			</div>
			<!-- 프로젝트 추가 섹션 -->
			<div class="project-category">
				<button class="add-project-btn" onclick="openModal('personal')">+
					프로젝트 추가</button>
			</div>
		</div>

	</div>

	<!-- 새 업무 추가 메인 콘텐츠 -->
	<div class="main-content">
		<div class="add-task-container">z
			<h2 class="form-title">새 업무 추가</h2>
			<form action="/Task/private?action=addTask" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="taskTitle">업무 제목</label> <input type="text"
						id="taskTitle" name="taskTitle" required
						placeholder="업무 제목을 입력하세요">
				</div>

				<div class="form-group">
					<label for="taskDescription">업무 설명</label>
					<textarea id="taskDescription" name="taskDescription"
						placeholder="업무에 대한 상세 설명을 입력하세요"></textarea>
				</div>

				<div class="form-group">
					<label>담당자</label>
					<div class="assignee-selection">
						<label class="assignee-option"> <input type="checkbox"
							name="assignees" value="김철수"> 김철수
						</label> <label class="assignee-option"> <input type="checkbox"
							name="assignees" value="이영희"> 이영희
						</label> <label class="assignee-option"> <input type="checkbox"
							name="assignees" value="박민수"> 박민수
						</label> <label class="assignee-option"> <input type="checkbox"
							name="assignees" value="정수진"> 정수진
						</label> <label class="assignee-option"> <input type="checkbox"
							name="assignees" value="최동훈"> 최동훈
						</label>
					</div>
					<div class="assignee-selected-list">
						선택된 담당자: <span id="selectedAssignees">없음</span>
					</div>
				</div>

				<div class="form-group">
					<label>우선순위</label> <input type="hidden" id="priorityInput"
						name="priority" required>
					<div class="priority-selection">
						<span class="priority-badge priority-high" data-priority="high">높음</span>
						<span class="priority-badge priority-medium"
							data-priority="medium">중간</span> <span
							class="priority-badge priority-low" data-priority="low">낮음</span>
					</div>
				</div>

				<div class="form-group">
					<label for="startDate">시작 날짜</label> <input type="date"
						id="startDate" name="startDate" required>
				</div>

				<div class="form-group">
					<label for="dueDate">마감 날짜</label> <input type="date" id="dueDate"
						name="dueDate" required>
				</div>

				<div class="btn-group">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='main.jsp'">취소</button>
					<button type="submit" class="btn btn-primary">업무 추가</button>
				</div>
			</form>
		</div>
	</div>

	<script>
        // 담당자 선택 및 선택된 목록 표시
        const assigneeOptions = document.querySelectorAll('.assignee-option');
        const selectedAssigneesElement = document.getElementById('selectedAssignees');

        assigneeOptions.forEach(option => {
            option.addEventListener('click', function () {
                const checkbox = this.querySelector('input[type="checkbox"]');
                checkbox.checked = !checkbox.checked;

                this.classList.toggle('selected', checkbox.checked);

                updateSelectedAssignees();
            });
        });

        function updateSelectedAssignees() {
            const selectedAssignees = [...document.querySelectorAll('.assignee-option.selected input')]
                .map(input => input.value);
            selectedAssigneesElement.textContent = selectedAssignees.length > 0 
                ? selectedAssignees.join(', ') 
                : '없음';
        }

        // 우선순위 선택
        document.querySelectorAll('.priority-badge').forEach(badge => {
            badge.addEventListener('click', function () {
                document.querySelectorAll('.priority-badge').forEach(b => b.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('priorityInput').value = this.dataset.priority;
            });
        });

        // 폼 제출 전 검증
        document.querySelector('form').addEventListener('submit', function (e) {
            const selectedAssignees = document.querySelectorAll('.assignee-option.selected input');
            const priorityValue = document.getElementById('priorityInput').value;

            if (selectedAssignees.length === 0) {
                e.preventDefault();
                alert('담당자를 최소 한 명 선택해주세요.');
                return;
            }

            if (!priorityValue) {
                e.preventDefault();
                alert('우선순위를 선택해주세요.');
                return;
            }
        });
    </script>
</body>
</html>
