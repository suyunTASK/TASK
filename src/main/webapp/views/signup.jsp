<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: #f5f7fa;
            animation: fadeIn 1s ease-out;
        }

        .register-container {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-out;
        }

        .register-logo {
            text-align: left;
            font-size: 1.2em;
            color: #666;
            margin-bottom: 20px;
        }

        .register-logo img {
            width: 100px;
            height: 60px;
        }

        .register-form {
            display: flex;
            flex-direction: column;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #666;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }

        .input-group input:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        .register-button {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .register-button:hover {
            background: #2980b9;
        }

        .register-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 0.9em;
            color: #666;
        }

        .register-footer a {
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .register-footer a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-logo">
            <img src="../image/TASK.png" alt="Task Logo">
        </div>
        <form class="register-form" action="/TASK/user?action=signup" method="post" enctype="multipart/form-data">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="input-group">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호를 다시 입력하세요" required>
            </div>
            <button class="register-button" type="submit">회원가입</button>
        </form>
        <div class="register-footer">
            이미 계정이 있으신가요? <a href="/TASK/views/login.jsp">로그인</a>
        </div>
    </div>
</body>
</html>
