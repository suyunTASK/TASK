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
    </script>
</body>
</html>