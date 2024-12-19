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

/* 왼쪽 사이드바 (메인.jsp와 동일) */
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
    box-shadow: 
        0 4px 12px rgba(0, 0, 0, 0.1),
        inset 0 1px 1px rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(5px);
    transition: all 0.3s ease;
}

.team-leader:hover {
    transform: translateY(-2px);
    box-shadow: 
        0 6px 16px rgba(0, 0, 0, 0.15),
        inset 0 1px 1px rgba(255, 255, 255, 0.2);
    background: linear-gradient(145deg, rgba(255, 255, 255, 0.18), rgba(255, 255, 255, 0.1));
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

.team-leader div > div {
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
    </style>
</head>
<body>
    	<!-- main.jsp와 동일 -->
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
    // 모달처리 끝
    
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