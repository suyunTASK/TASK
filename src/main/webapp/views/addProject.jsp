<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>새 프로젝트 생성</title>
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



/* Main Content Styles */
.main-content {
	flex: 1;
	display: flex;
	flex-direction: column;
	padding: 20px;
}

.add-project-container {
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

.project-type-selection {
	display: flex;
	gap: 20px;
	margin-bottom: 20px;
}

.project-type-option {
	flex: 1;
	padding: 15px;
	border: 2px solid #ddd;
	border-radius: 8px;
	text-align: center;
	cursor: pointer;
	transition: all 0.3s ease;
	opacity: 0.7;
}

.project-type-option.selected {
	border-color: #3498db;
	opacity: 1;
	transform: scale(1.02);
	box-shadow: 0 4px 6px rgba(52, 152, 219, 0.2);
}

.team-invite-section {
	display: none;
	margin-top: 20px;
}

.team-member-selection {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.team-member-option {
	display: flex;
	align-items: center;
	background: #f1f3f5;
	padding: 8px 12px;
	border-radius: 20px;
	cursor: pointer;
	transition: all 0.3s ease;
	border: 1px solid transparent;
}

.team-member-option input {
	display: none;
}

.team-member-option.selected {
	background: #3498db;
	color: white;
	border: 1px solid #2980b9;
	transform: scale(1.05);
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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

#inviteUrlSection {
	margin-top: 15px;
	display: none;
}

#inviteUrl {
	background-color: #f1f3f5;
	padding: 10px;
	border-radius: 6px;
	word-break: break-all;
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
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp" />

	<!-- Main Content -->
	<div class="main-content">
		<div class="add-project-container">
			<h2 class="form-title">새 프로젝트 생성</h2>
			<form id="projectForm" action="/addProject" method="post">
				<!-- Form content remains the same -->
				<!-- Project type selection -->
				<div class="form-group">
					<label>프로젝트 유형</label>
					<div class="project-type-selection">
						<div class="project-type-option" data-type="personal">
							<input type="radio" name="projectType" value="personal"
								style="display: none;"> 개인 프로젝트
						</div>
						<div class="project-type-option" data-type="team">
							<input type="radio" name="projectType" value="team"
								style="display: none;"> 팀 프로젝트
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="projectName">프로젝트 이름</label> <input type="text"
						id="projectName" name="projectName" required
						placeholder="프로젝트 이름을 입력하세요">
				</div>

				<div class="form-group">
					<label for="projectDescription">프로젝트 설명</label>
					<textarea id="projectDescription" name="projectDescription"
						placeholder="프로젝트에 대한 간단한 설명을 입력하세요"></textarea>
				</div>

				<!-- Team project invite section -->
				<div class="team-invite-section" id="teamInviteSection">
					<div class="form-group">
						<label>팀원 선택</label>
						<div class="team-member-selection">
							<label class="team-member-option"> <input type="checkbox"
								name="teamMembers" value="김철수"> 김철수
							</label> <label class="team-member-option"> <input
								type="checkbox" name="teamMembers" value="이영희"> 이영희
							</label> <label class="team-member-option"> <input
								type="checkbox" name="teamMembers" value="박민수"> 박민수
							</label> <label class="team-member-option"> <input
								type="checkbox" name="teamMembers" value="정수진"> 정수진
							</label> <label class="team-member-option"> <input
								type="checkbox" name="teamMembers" value="최동훈"> 최동훈
							</label>
						</div>
					</div>
				</div>

				<!-- Invite URL section -->
				<div id="inviteUrlSection" style="display: none;">
					<div class="form-group">
						<label>프로젝트 초대 링크</label>
						<button type="button" class="btn btn-secondary"
							onclick="generateInviteUrl()">초대 링크 생성</button>
						<div id="inviteUrl"></div>
						<button type="button" class="btn btn-secondary"
							onclick="copyInviteUrl()">URL 복사</button>
					</div>
				</div>

				<div class="btn-group">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='main.jsp'">취소</button>
					<button type="submit" class="btn btn-primary">프로젝트 생성</button>
				</div>
			</form>
		</div>
	</div>

	<script>
        // 프로젝트 유형 선택
        const projectTypeOptions = document.querySelectorAll('.project-type-option');
        const teamInviteSection = document.getElementById('teamInviteSection');
        const inviteUrlSection = document.getElementById('inviteUrlSection');
        const inviteUrlElement = document.getElementById('inviteUrl');

        projectTypeOptions.forEach(option => {
            option.addEventListener('click', function () {
                // 라디오 버튼 선택
                const radio = this.querySelector('input[type="radio"]');
                radio.checked = true;

                // 선택된 스타일 적용
                projectTypeOptions.forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');

                // 팀 프로젝트 선택 시 팀원 선택 섹션 표시
                if (this.dataset.type === 'team') {
                    teamInviteSection.style.display = 'block';
                } else {
                    teamInviteSection.style.display = 'none';
                    inviteUrlSection.style.display = 'none';
                }
            });
        });

        // 팀원 선택 기능
        const teamMemberOptions = document.querySelectorAll('.team-member-option');
        teamMemberOptions.forEach(option => {
            option.addEventListener('click', function () {
                const checkbox = this.querySelector('input[type="checkbox"]');
                checkbox.checked = !checkbox.checked;
                this.classList.toggle('selected', checkbox.checked);
            });
        });

        // 폼 제출 이벤트
        document.getElementById('projectForm').addEventListener('submit', function (e) {
            const projectType = document.querySelector('input[name="projectType"]:checked');
            const projectName = document.getElementById('projectName').value;

            // 프로젝트 유형 검증
            if (!projectType) {
                e.preventDefault();
                alert('프로젝트 유형을 선택해주세요.');
                return;
            }

            // 팀 프로젝트인 경우 팀원 선택 검증
            if (projectType.value === 'team') {
                const selectedTeamMembers = document.querySelectorAll('.team-member-option.selected');
                if (selectedTeamMembers.length === 0) {
                    e.preventDefault();
                    alert('최소 한 명의 팀원을 선택해주세요.');
                    return;
                }

                // 초대 URL 생성 (서버단에서 실제 구현 필요)
                const inviteToken = generateInviteToken();
                inviteUrlElement.textContent = `http://yourproject.com/invite/${inviteToken}`;
                inviteUrlSection.style.display = 'block';
                e.preventDefault(); // 실제 서버 연동 시 주석 처리
            }
        });

        // 간단한 초대 토큰 생성 (실제 구현 시 서버에서 안전하게 생성)
        function generateInviteToken() {
            return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        }
        
        function generateInviteUrl() {
            // 서버에 AJAX 요청을 보내 랜덤 초대 URL을 생성
            fetch('/generateInviteUrl', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ projectName: document.getElementById('projectName').value })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const inviteUrlElement = document.getElementById('inviteUrl');
                    inviteUrlElement.textContent = data.url; // 서버에서 반환한 초대 URL 표시
                    inviteUrlElement.style.display = 'block';
                } else {
                    alert('초대 링크 생성에 실패했습니다.');
                }
            });
        }

        function copyInviteUrl() {
            const urlText = inviteUrlElement.textContent;
            navigator.clipboard.writeText(urlText).then(() => {
                alert('초대 링크가 복사되었습니다.');
            });
        }
    </script>
</body>
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
</html>