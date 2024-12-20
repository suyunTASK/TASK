<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 프로젝트 생성</title>
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="add-project-container">
            <h2 class="form-title">새 프로젝트 생성</h2>
            <form id="projectForm" action="/task/addProject" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="team_name">프로젝트 이름</label>
                    <input type="text" id="team_name" name="team_name" placeholder="프로젝트 이름을 입력하세요" required>
                </div>

                <div id="inviteUrlSection">
                    <div class="form-group">
                        <label>프로젝트 초대 링크</label>
                        <button type="button" class="btn btn-secondary" onclick="generateInviteUrl()">초대 링크 생성</button>
                        <div id="inviteUrl"></div>
                        <button type="button" class="btn btn-secondary" onclick="copyInviteUrl()">URL 복사</button>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="location.href='main'">취소</button>
                    <button type="submit" class="btn btn-primary">프로젝트 생성</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const projectForm = document.getElementById('projectForm');
        const inviteUrlSection = document.getElementById('inviteUrlSection');
        const inviteUrlElement = document.getElementById('inviteUrl');

        projectForm.addEventListener('submit', function(e) {
            const projectName = document.getElementById('team_name').value;

            // 초대 URL 생성 (서버단에서 실제 구현 필요)
            const inviteToken = generateInviteToken();
            inviteUrlElement.textContent = `http://project.com/invite/${inviteToken}`;
            inviteUrlSection.style.display = 'block';

            e.preventDefault(); // 실제 서버 연동 시 주석 처리
        });

        function generateInviteToken() {
            return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        }

        function generateInviteUrl() {
            fetch('/generateInviteUrl', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ projectName: document.getElementById('team_name').value })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    inviteUrlElement.textContent = data.url;
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
</html>
