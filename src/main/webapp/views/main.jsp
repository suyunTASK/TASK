<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀 프로젝트!</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        @keyframes slideIn {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            min-height: 100vh;
            background: #f5f7fa;
        }

        /* 왼쪽 사이드바 */
        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, #2c3e50, #3498db);
            color: white;
            padding: 20px;
            animation: slideIn 0.5s ease-out;
        }

        .logo {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }

        .team-list {
            margin-bottom: 30px;
        }

        .team-item {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .team-item:hover {
            background: rgba(255,255,255,0.1);
        }

        .team-item.active {
            background: rgba(255,255,255,0.2);
        }

        .team-leader {
            display: flex;
            align-items: center;
            padding: 15px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
            margin-top: 20px;
        }

        .team-leader img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        /* 메인 콘텐츠 영역 */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* 상단 네비게이션 */
        .top-nav {
            background: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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

        /* 칸반 보드 */
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .column-header {
            font-weight: bold;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-task-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .add-task-btn:hover {
            background: #2980b9;
            animation: pulse 1s infinite;
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
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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

        .priority-high { background: #ff7675; color: white; }
        .priority-medium { background: #fdcb6e; color: white; }
        .priority-low { background: #81ecec; color: white; }

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
    <!-- 왼쪽 사이드바 -->
    <div class="sidebar">
        <div class="logo">TASK</div>
        <div class="team-list">
            <div class="team-item active">웹개발 프로젝트</div>
            <div class="team-item">마케팅 프로젝트</div>
            <div class="team-item">디자인 프로젝트</div>
        </div>
        <div class="team-leader">
            <img src="/api/placeholder/40/40" alt="Team Leader">
            <div>
                <div>김지훈</div>
                <small>팀장</small>
            </div>
        </div>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <!-- 상단 네비게이션 -->
        <div class="top-nav">
            <div class="nav-links">
                <div class="nav-link active" onClick="location.href='main.jsp'">할 일</div>
                <div class="nav-link" onClick="location.href='weekend.jsp'">주간 일정표</div>
                <div class="nav-link" onClick="location.href='calendar.jsp'">캘린더</div>
                <div class="nav-link" onClick="location.href='blockByTask.jsp'">업무 별 블록</div>
            </div>
            <button class="add-task-btn" onClick="location.href='addTask.jsp'">+ 새 업무</button>
        </div>	
		
        <!-- 칸반 보드 -->
        <div class="board-container">
            <div class="board">
                <div class="column">
                    <div class="column-header">
                        할 일
                        <span class="task-count">3</span>
                    </div>
                    <div class="task-card" draggable="true">
                        <div class="task-title">로그인 페이지 디자인</div>
                        <div class="task-meta">
                            <div class="task-assignee">
                                <img src="/api/placeholder/24/24" alt="Assignee">
                                김철수
                            </div>
                            <span class="priority-badge priority-high">높음</span>
                        </div>
                    </div>
                    <div class="task-card" draggable="true">
                        <div class="task-title">데이터베이스 설계</div>
                        <div class="task-meta">
                            <div class="task-assignee">
                                <img src="/api/placeholder/24/24" alt="Assignee">
                                이영희
                            </div>
                            <span class="priority-badge priority-medium">중간</span>
                        </div>
                    </div>
                </div>

                <div class="column">
                    <div class="column-header">
                        진행중
                        <span class="task-count">2</span>
                    </div>
                    <div class="task-card" draggable="true">
                        <div class="task-title">API 개발</div>
                        <div class="task-meta">
                            <div class="task-assignee">
                                <img src="/api/placeholder/24/24" alt="Assignee">
                                박민수
                            </div>
                            <span class="priority-badge priority-high">높음</span>
                        </div>
                    </div>
                </div>

                <div class="column">
                    <div class="column-header">
                        검토중
                        <span class="task-count">1</span>
                    </div>
                    <div class="task-card" draggable="true">
                        <div class="task-title">메인 페이지 UI 검토</div>
                        <div class="task-meta">
                            <div class="task-assignee">
                                <img src="/api/placeholder/24/24" alt="Assignee">
                                정수진
                            </div>
                            <span class="priority-badge priority-low">낮음</span>
                        </div>
                    </div>
                </div>

                <div class="column">
                    <div class="column-header">
                        완료
                        <span class="task-count">2</span>
                    </div>
                    <div class="task-card" draggable="true">
                        <div class="task-title">요구사항 분석</div>
                        <div class="task-meta">
                            <div class="task-assignee">
                                <img src="/api/placeholder/24/24" alt="Assignee">
                                최동훈
                            </div>
                            <span class="priority-badge priority-medium">중간</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
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
                updateAllTaskCounts(); // 드래그가 끝나면 모든 컬럼의 카운트 업데이트
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