<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
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

        .login-container {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-out;
        }

        .login-logo {
            text-align: center;
            margin-bottom: 20px;
            
            text-align: center;
            font-size: 1.2em;
            color: #666;
            margin-bottom: 20px;
        }

        .login-logo img {
            width: 210px;
            height: 120px;
        }

        .login-form {
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

        .login-button {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-button:hover {
            background: #2980b9;
        }

        .login-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 0.9em;
            color: #666;
        }

        .login-footer a {
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-footer a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">
            <img src="/images/TASK.png" alt="Task Logo">
        </div>
		<form class="login-form" action="/task/login" method="post">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            </div>
            <button class="login-button" type="submit">로그인</button>
        </form>
        <div class="login-footer">
            계정이 없으신가요? <a href="signup">회원가입</a>
        </div>
    </div>
</body>
</html>
