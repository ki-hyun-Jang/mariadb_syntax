-- 사용자 관리
-- 사용자 목록조회
select * form mysql.user;

-- 사용자 생성
create user 'jangkihyun'@'%' identified by '비밀번호'; -- %는 원격 포함한 anywhere 접속
create user 'jangkihyun'@'localhost' identified by '비밀번호';

-- 사용자 select권한 부여
grant select on board.author to 'jangkihyun'@'localhost';

-- 사용자 select권한 회수
revoke select on board.author from 'jangkihyun'@'localhost';

-- 사용자 계정삭제
drop user 'jangkihyun'@'localhost';