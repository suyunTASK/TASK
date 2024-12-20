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

        @keyframes slideUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes scaleIn {
            from {
                transform: scale(0.95);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ec 100%);
            padding: 20px;
        }

        .register-container {
            width: 600px;
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            animation: scaleIn 0.6s ease-out;
        }

        .register-logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .register-logo img {
            width: 160px;
            height: 96px;
            object-fit: contain;
        }

        .register-form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .input-group {
            animation: slideUp 0.6s ease-out forwards;
            opacity: 0;
        }

        .input-group:nth-child(1) { animation-delay: 0.1s; }
        .input-group:nth-child(2) { animation-delay: 0.2s; }
        .input-group:nth-child(3) { animation-delay: 0.3s; }

        .input-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 10px;
            color: #333;
            font-size: 1.1em;
        }

        .input-group input {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 1.2em;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .input-group input:focus {
            border-color: #3498db;
            background: white;
            outline: none;
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1);
        }

        .register-button {
            background: #3498db;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 10px;
            font-size: 1.3em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            animation: slideUp 0.6s 0.4s ease-out forwards;
            opacity: 0;
        }

        .register-button:hover {
       		background: #2980b9;
            box-shadow: 0 5px 15px rgba(41, 128, 185, 0.8);
        }
        
        .register-button:active {
            transform: translateY(1);
        }

        .register-footer {
            margin-top: 40px;
            text-align: center;
            font-size: 1.2em;
            color: #666;
            animation: slideUp 0.6s 0.5s ease-out forwards;
            opacity: 0;
        }

        .register-footer a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .register-footer a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .register-container {
                width: 100%;
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-logo">
            <img src="../image/TASK.png" alt="Task Logo">
        </div>
        <form class="register-form" action="/task/signup" method="post" enctype="multipart/form-data">
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
            이미 계정이 있으신가요? <a href="login">로그인</a>
        </div>
    </div>
</body>
</html>