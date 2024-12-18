<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>업무 별 블록</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Reusing the existing CSS from main.jsp */
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

        /* Sidebar styles (same as main.jsp) */
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

        /* Main content styles (same as main.jsp) */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

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

        /* Block by Task specific styles */
        .block-container {
            flex: 1;
            padding: 20px;
            overflow: auto;
            animation: fadeIn 0.5s ease-out;
        }

        .block-chart {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .block-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .block-label {
            width: 100px;
            margin-right: 15px;
        }

        .block-bars {
            flex: 1;
            display: flex;
            height: 30px;
        }

        .block-segment {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 0.8em;
        }

        .priority-high { background: #ff7675; }
        .priority-medium { background: #fdcb6e; }
        .priority-low { background: #81ecec; }
    </style>
</head>
<body>
    <!-- Sidebar (same as main.jsp) -->
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

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navigation (same as main.jsp) -->
        <div class="top-nav">
            <div class="nav-links">
                <div class="nav-link" onClick="location.href='main.jsp'">할 일</div>
                <div class="nav-link" onClick="location.href='weekend.jsp'">주간 일정표</div>
                <div class="nav-link" onClick="location.href='calendar.jsp'">캘린더</div>
                <div class="nav-link active" onClick="location.href='blockByTask.jsp'">업무 별 블록</div>
            </div>
            <button class="add-task-btn" onClick="location.href='addTask.jsp'">+ 새 업무</button>
        </div>

        <!-- Block by Task Container -->
        <div class="block-container">
            <div class="block-chart">
                <div class="chart-header">
                    <h2>개발팀 업무 현황</h2>
                </div>
                <div class="block-row">
                    <div class="block-label">김철수</div>
                    <div class="block-bars">
                        <div class="block-segment priority-high" style="width: 40%;">로그인 페이지 디자인 (40%)</div>
                        <div class="block-segment priority-low" style="width: 30%;">문서 작성 (30%)</div>
                        <div class="block-segment priority-medium" style="width: 30%;">코드 리뷰 (30%)</div>
                    </div>
                </div>
                <div class="block-row">
                    <div class="block-label">이영희</div>
                    <div class="block-bars">
                        <div class="block-segment priority-high" style="width: 50%;">데이터베이스 설계 (50%)</div>
                        <div class="block-segment priority-medium" style="width: 30%;">테스트 케이스 (30%)</div>
                        <div class="block-segment priority-low" style="width: 20%;">회의 참여 (20%)</div>
                    </div>
                </div>
                <div class="block-row">
                    <div class="block-label">박민수</div>
                    <div class="block-bars">
                        <div class="block-segment priority-high" style="width: 60%;">API 개발 (60%)</div>
                        <div class="block-segment priority-medium" style="width: 25%;">기술 문서화 (25%)</div>
                        <div class="block-segment priority-low" style="width: 15%;">성능 튜닝 (15%)</div>
                    </div>
                </div>
                <div class="block-row">
                    <div class="block-label">정수진</div>
                    <div class="block-bars">
                        <div class="block-segment priority-high" style="width: 45%;">메인 페이지 UI (45%)</div>
                        <div class="block-segment priority-medium" style="width: 35%;">UX 개선 (35%)</div>
                        <div class="block-segment priority-low" style="width: 20%;">디자인 가이드 (20%)</div>
                    </div>
                </div>
                <div class="block-row">
                    <div class="block-label">최동훈</div>
                    <div class="block-bars">
                        <div class="block-segment priority-high" style="width: 40%;">요구사항 분석 (40%)</div>
                        <div class="block-segment priority-medium" style="width: 35%;">프로젝트 계획 (35%)</div>
                        <div class="block-segment priority-low" style="width: 25%;">리스크 관리 (25%)</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>