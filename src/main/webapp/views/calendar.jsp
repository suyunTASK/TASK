<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀 캘린더</title>
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

        /* 왼쪽 사이드바 (메인.jsp와 동일) */
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

        /* 캘린더 컨테이너 */
        .calendar-container {
            flex: 1;
            padding: 20px;
            animation: fadeIn 0.5s ease-out;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-title {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 1.5em;
            font-weight: bold;
        }

        .calendar-nav-btn {
            background: none;
            border: none;
            font-size: 1.2em;
            cursor: pointer;
            color: #3498db;
            transition: color 0.3s ease;
        }

        .calendar-nav-btn:hover {
            color: #2980b9;
        }

        .calendar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
            color: #666;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            text-align: center;
        }

        .calendar-day {
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .calendar-day:hover {
            background: #f0f0f0;
        }

        .calendar-day.today {
            background: #3498db;
            color: white;
        }

        .calendar-day.has-event {
            position: relative;
        }

        .calendar-day.has-event::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 50%;
            transform: translateX(-50%);
            width: 6px;
            height: 6px;
            background: #ff7675;
            border-radius: 50%;
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
    <!-- 왼쪽 사이드바 (메인.jsp와 동일) -->
    <div class="sidebar">
        <div class="logo">TASK</div>
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
                <div class="nav-links">
                <div class="nav-link" onClick="location.href='main.jsp'">할 일</div>
                <div class="nav-link" onClick="location.href='weekend.jsp'">주간 일정표</div>
                <div class="nav-link active" onClick="location.href='calendar.jsp'"">캘린더</div>
                <div class="nav-link" onClick="location.href='blockByTask.jsp'">업무 별 블록</div>
            </div>
            </div>
            <button class="add-task-btn" onClick="location.href='addTask.jsp'">+ 새 업무</button>
        </div>
		
        <!-- 캘린더 영역 -->
        <div class="calendar-container">
            <div class="calendar-header">
                <div class="calendar-title">
                    <button class="calendar-nav-btn" id="prevMonth">&lt;</button>
                    <span id="currentMonth">2024년 6월</span>
                    <button class="calendar-nav-btn" id="nextMonth">&gt;</button>
                </div>
              
            </div>
            <div class="calendar">
                <div class="calendar-weekdays">
                	<div>일</div>
                    <div>월</div>
                    <div>화</div>
                    <div>수</div>
                    <div>목</div>
                    <div>금</div>
                    <div>토</div>
                </div>
                <div class="calendar-days" id="calendarDays">
                    <!-- 일자들이 여기에 동적으로 추가됨 -->
                </div>
            </div>
        </div>
    </div>

    <script>
        // 현재 날짜 상태 관리
        let currentDate = new Date();

     // 캘린더 렌더링 함수
        function renderCalendar() {
            const monthDisplay = document.getElementById('currentMonth');
            const calendarDays = document.getElementById('calendarDays');
            
            // 현재 월의 첫날과 마지막 날 계산
            const firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
            const lastDay = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
            
            // 연도를 두 자리 형식으로 변환
            const year = String(currentDate.getFullYear()).slice(2); // '2024' -> '24'
            
            // 월 표시 업데이트
            monthDisplay.textContent = '${year}년 ${currentDate.getMonth() + 1}월';
            
            // 캘린더 초기화
            calendarDays.innerHTML = '';
            
            // 첫 날 이전의 빈 칸 채우기
            for (let i = 0; i < firstDay.getDay(); i++) {
                calendarDays.appendChild(document.createElement('div'));
            }
            
            // 날짜 채우기
            for (let day = 1; day <= lastDay.getDate(); day++) {
                const dayElement = document.createElement('div');
                dayElement.textContent = day;
                dayElement.classList.add('calendar-day');
                
                // 오늘 날짜 강조
                const today = new Date();
                if (day === today.getDate() && 
                    currentDate.getMonth() === today.getMonth() && 
                    currentDate.getFullYear() === today.getFullYear()) {
                    dayElement.classList.add('today');
                }
                
                // 일정이 있는 날짜 표시 (예시)
                if ([5, 10, 15, 20, 25].includes(day)) {
                    dayElement.classList.add('has-event');
                }
                
                dayElement.addEventListener('click', () => {
                    // 날짜 클릭 시 이벤트 처리 (예: 해당 날짜의 이벤트 보기)
                    alert('${currentDate.getFullYear()}년 ${currentDate.getMonth() + 1}월 ${day}일 클릭됨');
                });
                
                calendarDays.appendChild(dayElement);
            }
        }


        // 이전 달로 이동
        document.getElementById('prevMonth').addEventListener('click', () => {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        });

        // 다음 달로 이동
        document.getElementById('nextMonth').addEventListener('click', () => {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        });

        // 초기 캘린더 렌더링
        renderCalendar();
    </script>
</body>
</html>