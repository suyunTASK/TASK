![데베](https://github.com/user-attachments/assets/137943cc-47aa-4477-850e-569a4930d36b)
# Database Schema Setup
데이터 베이스 스키마 설정

## Prerequisites
- MySQL installed on your system
- 데베이름 task

## Step 1: 테이블생성
5개의 테이블 생성

```sql
-- 사용자 테이블
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL
);

-- 팀 테이블
CREATE TABLE team (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_todo_id INT NULL,
    team_name VARCHAR(100) NOT NULL
);

-- 팀-유저 관계 테이블
CREATE TABLE team_users (
    team_id INT NOT NULL,
    user_id INT NOT NULL,
    role VARCHAR(50),
    leader BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (team_id, user_id)
);

-- 팀 일정 테이블
CREATE TABLE team_todo (
    team_todo_id INT AUTO_INCREMENT PRIMARY KEY,
    todo_name VARCHAR(100) NOT NULL,
    st_time TIME NOT NULL,
    ed_time TIME NOT NULL,
    day VARCHAR(20) NOT NULL,
    color VARCHAR(20),
    user_id INT NULL,
    team_id INT NULL
);

-- 개인 일정 테이블
CREATE TABLE private_todo (
    private_todo_id INT AUTO_INCREMENT PRIMARY KEY,
    todo_name VARCHAR(100) NOT NULL,
    st_time TIME NOT NULL,
    ed_time TIME NOT NULL,
    st_day VARCHAR(20) NOT NULL,
    ed_day VARCHAR(20) NOT NULL,
    color VARCHAR(20),
    user_id INT NOT NULL
);

```
### step 1-A
한글 깨질시 테이블 인코딩 수정 코드
```sql
ALTER TABLE 테이블명 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## Step 2: 외래키 추가
테이블끼리 연결정보 설명

```sql
-- team_todo의 user_id와 team_id 외래 키 추가
ALTER TABLE team_todo
ADD CONSTRAINT fk_team_todo_user FOREIGN KEY (user_id) REFERENCES user(user_id),
ADD CONSTRAINT fk_team_todo_team FOREIGN KEY (team_id) REFERENCES team(team_id);

-- team 테이블의 team_todo_id 외래 키 추가
ALTER TABLE team
ADD CONSTRAINT fk_team_todo FOREIGN KEY (team_todo_id) REFERENCES team_todo(team_todo_id);

-- team_users의 team_id와 user_id 외래 키 추가
ALTER TABLE team_users
ADD CONSTRAINT fk_team_users_team FOREIGN KEY (team_id) REFERENCES team(team_id),
ADD CONSTRAINT fk_team_users_user FOREIGN KEY (user_id) REFERENCES user(user_id);

-- private_todo의 user_id 외래 키 추가
ALTER TABLE private_todo
ADD CONSTRAINT fk_private_todo_user FOREIGN KEY (user_id) REFERENCES user(user_id);
```

## Step 3: 입력 예시
```sql
-- 사용자 데이터 삽입
INSERT INTO user (password, name) VALUES ('password123', '홍길동');
INSERT INTO user (password, name) VALUES ('mypassword', '김철수');

-- 팀 데이터 삽입
INSERT INTO team (team_name) VALUES ('수윤 팀');
INSERT INTO team (team_name) VALUES ('개발자 팀');

-- 팀 유저 관계 삽입
INSERT INTO team_users (team_id, user_id, role, leader) VALUES (1, 1, 'Manager', TRUE);
INSERT INTO team_users (team_id, user_id, role, leader) VALUES (1, 2, 'Member', FALSE);

-- 팀 일정 삽입
INSERT INTO team_todo (todo_name, st_time, ed_time, day, color, user_id, team_id) 
VALUES ('팀 회의', '10:00:00', '11:00:00', '월요일', 'red', 1, 1);

-- 개인 일정 삽입
INSERT INTO private_todo (todo_name, st_time, ed_time, day, color, user_id) 
VALUES ('개인 공부', '20:00:00', '22:00:00', '화요일', 'blue', 2);
```
## Step 4: 조회 예시
```sql
--특정 팀의 모든 사용자 조회
SELECT u.name, tu.role, tu.leader 
FROM team_users tu
JOIN user u ON tu.user_id = u.user_id
WHERE tu.team_id = 1;
```
```sql
--특정 사용자의 개인 일정 조회
SELECT todo_name, st_time, ed_time, day, color
FROM private_todo
WHERE user_id = 2;
```
```sql
-- 특정 팀의 팀 일정 조회
SELECT tt.todo_name, tt.st_time, tt.ed_time, tt.day, tt.color
FROM team_todo tt
WHERE tt.team_id = 1;
```
