<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주간 일정표</title>
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

        /* 사이드바 스타일 */
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

        /* 주간 일정 컨테이너 */
        .weekly-schedule-container {
            flex: 1;
            padding: 20px;
            animation: fadeIn 0.5s ease-out;
        }

        .schedule-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .schedule-title {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 1.5em;
            font-weight: bold;
        }

        .schedule-nav-btn {
            background: none;
            border: none;
            font-size: 1.2em;
            cursor: pointer;
            color: #3498db;
            transition: color 0.3s ease;
        }

        .schedule-nav-btn:hover {
            color: #2980b9;
        }

        .weekly-grid {
            display: grid;
            grid-template-columns: 100px repeat(7, 1fr);
            gap: 10px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 10px;
        }

        .time-column {
            display: grid;
            grid-template-rows: repeat(24, 40px);
            text-align: right;
            padding-right: 10px;
            color: #666;
            font-size: 0.8em;
        }

        .time-slot {
            border-top: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 5px;
        }

        .day-column {
            display: grid;
            grid-template-rows: repeat(24, 40px);
            border-left: 1px solid #eee;
            position: relative;
        }

        .day-header {
            position: sticky;
            top: 0;
            background: white;
            text-align: center;
            padding: 10px 0;
            font-weight: bold;
            z-index: 10;
            border-bottom: 1px solid #eee;
        }

        .event {
            position: absolute;
            background: #3498db;
            color: white;
            border-radius: 5px;
            padding: 5px;
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 0.8em;
            opacity: 0.9;
            transition: background 0.3s ease;
        }

        .event:hover {
            background: #2980b9;
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
    </style>
</head>
<body>
    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="logo">Team Manager</div>
        <div class="team-list">
            <div class="team-item">웹개발 프로젝트</div>
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
                <div class="nav-link" onClick="location.href='main.jsp'">할 일</div>
                <div class="nav-link active" onClick="location.href='weekend.jsp'">주간 일정표</div>
                <div class="nav-link" onClick="location.href='calendar.jsp'">캘린더</div>
                <div class="nav-link" onClick="location.href='blockByTask.jsp'">업무 별 블록</div>
            </div>
            <button class="add-task-btn">+ 새 업무</button>
        </div>	
		
        <!-- 주간 일정 영역 -->
        <div class="weekly-schedule-container">
            <div class="schedule-header">
                <div class="schedule-title">
                    <button class="schedule-nav-btn" id="prevWeek">&lt;</button>
                    <span id="currentWeek">6월 10일 - 6월 16일</span>
                    <button class="schedule-nav-btn" id="nextWeek">&gt;</button>
                </div>
            </div>

            <div class="weekly-grid">
                <!-- 시간 열 -->
                <div class="time-column">
                    <div class="time-slot">00:00</div>
                    <div class="time-slot">01:00</div>
                    <div class="time-slot">02:00</div>
                    <div class="time-slot">03:00</div>
                    <div class="time-slot">04:00</div>
                    <div class="time-slot">05:00</div>
                    <div class="time-slot">06:00</div>
                    <div class="time-slot">07:00</div>
                    <div class="time-slot">08:00</div>
                    <div class="time-slot">09:00</div>
                    <div class="time-slot">10:00</div>
                    <div class="time-slot">11:00</div>
                    <div class="time-slot">12:00</div>
                    <div class="time-slot">13:00</div>
                    <div class="time-slot">14:00</div>
                    <div class="time-slot">15:00</div>
                    <div class="time-slot">16:00</div>
                    <div class="time-slot">17:00</div>
                    <div class="time-slot">18:00</div>
                    <div class="time-slot">19:00</div>
                    <div class="time-slot">20:00</div>
                    <div class="time-slot">21:00</div>
                    <div class="time-slot">22:00</div>
                    <div class="time-slot">23:00</div>
                </div>

                <!-- 요일별 열 -->
                <div class="day-column">
                    <div class="day-header">일</div>
                    <!-- 이벤트들 -->
                    <div class="event" style="top: calc(9 * 40px); height: calc(3 * 40px);">
                        웹개발 프로젝트 미팅
                    </div>
                    <div class="event" style="top: calc(14 * 40px); height: calc(2 * 40px);">
                        API 설계 리뷰
                    </div>
                </div>

                <div class="day-column">
                    <div class="day-header">월</div>
                    <div class="event" style="top: calc(10 * 40px); height: calc(2 * 40px);">
                        기획 회의
                    </div>
                </div>

                <div class="day-column">
                    <div class="day-header">화</div>
                    <div class="event" style="top: calc(11 * 40px); height: calc(3 * 40px);">
                        디자인 워크샵
                    </div>
                </div>

                <div class="day-column">
                    <div class="day-header">수</div>
                    <div class="event" style="top: calc(15 * 40px); height: calc(2 * 40px);">
                        마케팅 전략 논의
                    </div>
                </div>

                <div class="day-column">
                    <div class="day-header">목</div>
                    <div class="event" style="top: calc(16 * 40px); height: calc(2 * 40px);">
                        주간 결과 보고회
                    </div>
                </div>

                <div class="day-column">
                    <div class="day-header">금</div>
                </div>

                <div class="day-column">
                    <div class="day-header">토</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 현재 주 상태 관리
        let currentWeek = new Date();

        // 주 포맷팅 함수
        function formatWeek(date) {
            const startOfWeek = new Date(date);
            startOfWeek.setDate(date.getDate() - date.getDay() + 1);
            
            const endOfWeek = new Date(startOfWeek);
            endOfWeek.setDate(startOfWeek.getDate() + 6);

            return '${startOfWeek.getMonth() + 1}월 ${startOfWeek.getDate()}일 - ${endOfWeek.getMonth() + 1}월 ${endOfWeek.getDate()}일';
        }

        // 주 업데이트 함수
        function updateWeekDisplay() {
            const weekDisplay = document.getElementById('currentWeek');
            weekDisplay.textContent = formatWeek(currentWeek);
        }

        // 이전 주로 이동
        document.getElementById('prevWeek').addEventListener('click', () => {
            currentWeek.setDate(currentWeek.getDate() - 7);
            updateWeekDisplay();
        });

        // 다음 주로 이동
        document.getElementById('nextWeek').addEventListener('click', () => {
            currentWeek.setDate(currentWeek.getDate() + 7);
            updateWeekDisplay();
        });

        // 초기 주 표시
        updateWeekDisplay();
    </script>
</body>
</html>