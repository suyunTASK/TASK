<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>개인 일정 추가</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
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

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .add-todo-container {
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

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
        }

        .schedule-group {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .schedule-group .form-group {
            flex: 1;
            margin-bottom: 0;
        }

        .schedule-label {
            color: #34495e;
            font-weight: 500;
            margin-bottom: 12px;
        }

        .priority-selection {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .priority-badge {
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            opacity: 0.6;
            text-align: center;
            width: 80px;
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp" />
    
    <div class="main-content">
        <div class="add-todo-container">
            <h2 class="form-title">개인 일정 추가</h2>
            <form action="/task/private?action=addPrivateTodo" method="post">
                <div class="form-group">
                    <label for="todoName">일정 제목</label>
                    <input type="text" id="todoName" name="todo_name" required placeholder="일정 제목을 입력하세요">
                </div>

                <div>
                    <div class="schedule-label">날짜 설정</div>
                    <div class="schedule-group">
                        <div class="form-group">
                            <label for="startDate">시작 날짜</label>
                            <input type="date" id="startDate" name="st_day" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">종료 날짜</label>
                            <input type="date" id="endDate" name="ed_day" required>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="schedule-label">시간 설정</div>
                    <div class="schedule-group">
                        <div class="form-group">
                            <label for="startTime">시작 시간</label>
                            <input type="time" id="startTime" name="st_time" required>
                        </div>
                        <div class="form-group">
                            <label for="endTime">종료 시간</label>
                            <input type="time" id="endTime" name="ed_time" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>우선순위</label>
                    <input type="hidden" id="priorityInput" name="color" required>
                    <div class="priority-selection">
                        <span class="priority-badge priority-high" data-priority="red">높음</span>
                        <span class="priority-badge priority-medium" data-priority="yellow">중간</span>
                        <span class="priority-badge priority-low" data-priority="blue">낮음</span>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="location.href='main'">취소</button>
                    <button type="submit" class="btn btn-primary">일정 추가</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 우선순위 선택
        document.querySelectorAll('.priority-badge').forEach(badge => {
            badge.addEventListener('click', function() {
                document.querySelectorAll('.priority-badge').forEach(b => b.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('priorityInput').value = this.dataset.priority;
            });
        });

        // 폼 제출 전 검증
        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            const priority = document.getElementById('priorityInput').value;

            if (!priority) {
                e.preventDefault();
                alert('우선순위를 선택해주세요.');
                return;
            }

            const startDateTime = new Date(startDate + 'T' + startTime);
            const endDateTime = new Date(endDate + 'T' + endTime);

            if (startDateTime >= endDateTime) {
                e.preventDefault();
                alert('종료 일시는 시작 일시보다 늦어야 합니다.');
                return;
            }
        });

        // 오늘 날짜를 기본값으로 설정
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('startDate').value = today;
        document.getElementById('endDate').value = today;
    </script>
</body>
</html>