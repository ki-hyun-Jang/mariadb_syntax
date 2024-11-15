-- mariadb 서버에 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스키마(database) 생성 : 중요
CREATE DATABASE board;

-- 스키마(database) 삭제
DROP DATABASE board;


-- 스키마(database) 선택 : 중요
use board; --use 원하는 스키마(database)

-- 테이블 목록조회 : 중요
show tables;

-- 문자인코딩 조회 (문자체계 조회)
show variables like 'character_set_server';

-- 문자인코딩 변경
ALTER DATABASE board character set utf8mb4;

-- 테이블 생성 : 중요
CREATE TABLE author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼조회 : 중요
describe author;

-- 테이블 컬럼상세조회
show full columns from author;

-- 테이블 생성명령문 조회
show CREATE table author;

-- post테이블 신규 생성(id, title, content, author_id)
CREATE table post(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT not null, foreign key(author_id) references author(id)); 

-- 테이블 index(성능향상 옵션) 조회
show index from author

-- alter문: 테이블의 구조를 변경
-- 테이블을의 이름 변경
alter table post rename posts;

-- 테이블 컬럼 추가 : 중요
alter table author add column age int;

-- 테이블 컬럼 삭제
alter table author drop column age;

-- 테이블 컬럼명 변경
alter table post change column content columns VARCHAR(255);

-- 테이블 컬럼 타입과 제약조건 변경 : 중요, 기존에 있던 테이블에 덮어쓰기 되므로 유의
alter table author modify column email VARCHAR(100) not null;

-- 테이블 삭제
-- show CREATE table post; 삭제하기전에 복사
drop table post;