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
                <div class="nav-links">
                <div class="nav-link" onClick="location.href='main.jsp'">할 일</div>
                <div class="nav-link" onClick="location.href='weekend.jsp'">주간 일정표</div>
                <div class="nav-link active" onClick="location.href='calendar.jsp'">캘린더</div>
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
            const month = String(currentDate.getMonth() + 1);
            
            // 월 표시 업데이트
            monthDisplay.textContent = year + '년 ' + month + '월';
            
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