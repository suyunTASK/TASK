<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>TASK</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
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
@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes pulse { 0% {
	transform: scale(1);
}

50
%
{
transform
:
scale(
1.05
);
}
100
%
{
transform
:
scale(
1
);
}
}
body {
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	min-height: 100vh;
	background: #f5f7fa;
}

/* 프로젝트 추가 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 1000;
}

.modal.show {
	display: flex;
}

.modal-content {
	background: white;
	padding: 25px;
	border-radius: 10px;
	width: 400px;
	color: #333;
}

.modal-header {
	margin-bottom: 20px;
	font-size: 1.2em;
	font-weight: 500;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	color: #666;
}

.form-group input[type="text"] {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.form-group select {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.modal-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 20px;
}

.modal-btn {
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.3s ease;
}

.btn-cancel {
	background: #e0e0e0;
}

.btn-cancel:hover {
	background: #d0d0d0;
}

.btn-submit {
	background: #3498db;
	color: white;
}

.btn-submit:hover {
	background: #2980b9;
}

/* 메인 콘텐츠 영역 스타일 */
.main-content {
	flex: 1;
	display: flex;
	flex-direction: column;
}

/* 상단 네비게이션 스타일 */
.top-nav {
	background: white;
	padding: 15px 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	animation: fadeIn 0.5s ease-out;
}

.nav-links {
	display: flex;
	gap: 20px;
}

.nav-link {
	padding: 8px 15px;
	border-radius: 20px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.nav-link:hover {
	background: #f0f0f0;
}

.nav-link.active {
	background: #3498db;
	color: white;
}

.add-task-btn {
	background: #3498db;
	color: white;
	border: none;
	padding: 8px 16px;
	font-size: 1em;
	border-radius: 5px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.add-task-btn:hover {
	background: #2980b9;
	animation: pulse 1s infinite;
}

/* 칸반 보드 스타일 */
.board-container {
	flex: 1;
	padding: 20px;
	overflow-x: auto;
	animation: fadeIn 0.5s ease-out;
}

.board {
	display: flex;
	gap: 20px;
	min-height: 500px;
}

.column {
	min-width: 300px;
	background: white;
	border-radius: 10px;
	padding: 15px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.column-header {
	font-weight: bold;
	margin-bottom: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.task-card {
	background: white;
	border: 1px solid #eee;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 10px;
	cursor: move;
	transition: all 0.3s ease;
	animation: fadeIn 0.3s ease-out;
}

.task-card:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transform: translateY(-2px);
}

.task-title {
	font-weight: 500;
	margin-bottom: 10px;
}

.task-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 0.9em;
	color: #666;
}

.task-assignee {
	display: flex;
	align-items: center;
	gap: 5px;
}

.task-assignee img {
	width: 24px;
	height: 24px;
	border-radius: 50%;
}

.priority-badge {
	padding: 3px 8px;
	border-radius: 12px;
	font-size: 0.8em;
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

/* 드래그 중인 상태 스타일 */
.task-card.dragging {
	opacity: 0.5;
	transform: scale(0.95);
}

.column.drag-over {
	background: #f8f9fa;
	border: 2px dashed #3498db;
}
</style>
</head>
<body>
	<!-- 사이드바 -->
	<jsp:include page="sidebar.jsp" />

	<!-- 프로젝트 추가 모달 -->
	<div class="modal" id="projectModal">
		<div class="modal-content">
			<div class="modal-header">새 프로젝트 추가</div>
			<form id="projectForm">
				<div class="form-group">
					<label for="projectName">프로젝트 이름</label> <input type="text"
						id="projectName" required>
				</div>
				<div class="form-group">
					<label for="projectType">프로젝트 유형</label> <select id="projectType"
						required>
						<option value="personal">개인 프로젝트</option>
						<option value="team">팀 프로젝트</option>
					</select>
				</div>
				<div class="modal-buttons">
					<button type="button" class="modal-btn btn-cancel"
						onclick="closeModal()">취소</button>
					<button type="submit" class="modal-btn btn-submit">추가</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 메인 콘텐츠 -->
	<div class="main-content">
		<!-- 상단 네비게이션 -->
		<div class="top-nav">
			<div class="nav-links">
				<div class="nav-link active" onClick="location.href='main'">할
					일</div>
				<div class="nav-link" onClick="location.href='weekend'">주간 일정표</div>
				<div class="nav-link" onClick="location.href='calendar'">캘린더</div>
				<div class="nav-link" onClick="location.href='blockByTask'">업무
					별 블록</div>
			</div>
			<button class="add-task-btn" onClick="location.href='addTask'">+
				새 업무</button>
		</div>

		<!-- 칸반 보드 -->
		<div class="board-container">
			<div class="board">
				<div class="column">
					<div class="column-header">
						할 일 <span class="task-count">3</span>
					</div>
					<div class="task-card" draggable="true">
						<div class="task-title">로그인 페이지 디자인</div>
						<div class="task-meta">
							<div class="task-assignee">
								<img src="/api/placeholder/24/24" alt="Assignee"> 김철수
							</div>
							<span class="priority-badge priority-high">높음</span>
						</div>
					</div>
					<div class="task-card" draggable="true">
						<div class="task-title">데이터베이스 설계</div>
						<div class="task-meta">
							<div class="task-assignee">
								<img src="/api/placeholder/24/24" alt="Assignee"> 이영희
							</div>
							<span class="priority-badge priority-medium">중간</span>
						</div>
					</div>
				</div>

				<div class="column">
					<div class="column-header">
						진행중 <span class="task-count">2</span>
					</div>
					<div class="task-card" draggable="true">
						<div class="task-title">API 개발</div>
						<div class="task-meta">
							<div class="task-assignee">
								<img src="/api/placeholder/24/24" alt="Assignee"> 박민수
							</div>
							<span class="priority-badge priority-high">높음</span>
						</div>
					</div>
				</div>

				<div class="column">
					<div class="column-header">
						검토중 <span class="task-count">1</span>
					</div>
					<div class="task-card" draggable="true">
						<div class="task-title">메인 페이지 UI 검토</div>
						<div class="task-meta">
							<div class="task-assignee">
								<img src="/api/placeholder/24/24" alt="Assignee"> 정수진
							</div>
							<span class="priority-badge priority-low">낮음</span>
						</div>
					</div>
				</div>

				<div class="column">
					<div class="column-header">
						완료 <span class="task-count">2</span>
					</div>
					<div class="task-card" draggable="true">
						<div class="task-title">요구사항 분석</div>
						<div class="task-meta">
							<div class="task-assignee">
								<img src="/api/placeholder/24/24" alt="Assignee"> 최동훈
							</div>
							<span class="priority-badge priority-medium">중간</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
        // 프로젝트 모달 관련 함수
        const modal = document.getElementById('projectModal');
        const projectForm = document.getElementById('projectForm');
        const projectTypeSelect = document.getElementById('projectType');

        function openModal(type) {
            modal.classList.add('show');
            projectTypeSelect.value = type;
        }

        function closeModal() {
            modal.classList.remove('show');
            projectForm.reset();
        }

        projectForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const projectName = document.getElementById('projectName').value;
            const projectType = projectTypeSelect.value;
            
            // 새 프로젝트 아이템 생성
            const newProject = document.createElement('div');
            newProject.className = 'project-item';
            newProject.textContent = projectName;

            // 해당하는 프로젝트 리스트에 추가
            const targetList = document.getElementById(${projectType}-projects);
            targetList.appendChild(newProject);

            // 새로 추가된 프로젝트에 클릭 이벤트 리스너 추가
            newProject.addEventListener('click', function() {
                document.querySelectorAll('.project-item').forEach(p => {
                    p.classList.remove('active');
                });
                this.classList.add('active');
            });

            closeModal();
        });

        // 프로젝트 아이템 활성화 처리
        document.querySelectorAll('.project-item').forEach(item => {
            item.addEventListener('click', function() {
                // 모든 프로젝트에서 active 클래스 제거
                document.querySelectorAll('.project-item').forEach(p => {
                    p.classList.remove('active');
                });
                // 클릭된 프로젝트에 active 클래스 추가
                this.classList.add('active');
            });
        });

        // 모달 외부 클릭시 닫기
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeModal();
            }
        });

        // 칸반 보드 드래그 앤 드롭 기능
        const taskCards = document.querySelectorAll('.task-card');
        const columns = document.querySelectorAll('.column');

        // 모든 컬럼의 task count 업데이트
        function updateAllTaskCounts() {
            columns.forEach(column => {
                const taskCount = column.querySelectorAll('.task-card').length;
                const countSpan = column.querySelector('.task-count');
                countSpan.textContent = taskCount;
            });
        }

        taskCards.forEach(card => {
            card.addEventListener('dragstart', () => {
                card.classList.add('dragging');
            });
            
            card.addEventListener('dragend', () => {
                card.classList.remove('dragging');
                updateAllTaskCounts();
            });
        });

        columns.forEach(column => {
            column.addEventListener('dragover', (e) => {
                e.preventDefault();
                const draggingCard = document.querySelector('.dragging');
                const afterElement = getDragAfterElement(column, e.clientY);
                if (afterElement == null) {
                    column.appendChild(draggingCard);
                } else {
                    column.insertBefore(draggingCard, afterElement);
                }
                column.classList.add('drag-over');
            });

            column.addEventListener('dragleave', () => {
                column.classList.remove('drag-over');
            });

            column.addEventListener('drop', () => {
                column.classList.remove('drag-over');
            });
        });

        function getDragAfterElement(container, y) {
            const draggableElements = [...container.querySelectorAll('.task-card:not(.dragging)')];

            return draggableElements.reduce((closest, child) => {
                const box = child.getBoundingClientRect();
                const offset = y - box.top - box.height / 2;
                if (offset < 0 && offset > closest.offset) {
                    return { offset: offset, element: child };
                } else {
                    return closest;
                }
            }, { offset: Number.NEGATIVE_INFINITY }).element;
        }

        // 초기 task count 설정
        updateAllTaskCounts();
    </script>
</body>
</html>