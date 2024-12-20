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

        .login-container {
            width: 600px;
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            animation: scaleIn 0.6s ease-out;
        }

        .login-logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-logo img {
            width: 160px;
            height: 96px;
            object-fit: contain;
        }

        .login-form {
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

        .login-button {
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

       .login-button:hover {
       background: #2980b9;
       transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(41, 128, 185, 0.8);
       }


        .login-button:active {
            transform: translateY(1);
        }

        .login-footer {
            margin-top: 40px;
            text-align: center;
            font-size: 1.2em;
            color: #666;
            animation: slideUp 0.6s 0.5s ease-out forwards;
            opacity: 0;
        }

        .login-footer a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .login-footer a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-size: 1.2em;
            margin-bottom: 15px;
            text-align: center;
        }

        @media (max-width: 600px) {
            .login-container {
                width: 100%;
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">
            <img src="/images/TASK.png" alt="Task Logo">
        </div>
        
        <c:if test="${not empty param.error}">
            <div class="error-message">
                <c:choose>
                    <c:when test="${param.error == 'invalid_credentials'}">
                        아이디 또는 비밀번호가 잘못되었습니다.
                    </c:when>
                    <c:when test="${param.error == 'login_failed'}">
                        로그인 중 오류가 발생했습니다. 다시 시도해주세요.
                    </c:when>
                    <c:otherwise>
                        알 수 없는 오류가 발생했습니다.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
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