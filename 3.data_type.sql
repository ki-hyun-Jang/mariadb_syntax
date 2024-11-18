-- tinyint는 -128~127까지 표현(1byte)
-- author 테이블에 age컬럼 추가
alter table author add column age tinyint;
insert into author (id,age) values (7,200); -- 128까지 표현할 수 있기에 안됨
alter table author modify column age tinyint unsigned;

-- decimal실습
-- decimal (정수부.소수부)로 나뉨
alter table post add column price decimal(10, 3);

-- decimal 소수점 초과 후 값 짤림 현상
insert into post (id, title, price) values(5, 'java', 10.12345)

-- blob (바이너리 데이터) -> 이미지 or 동영상
alter table author add column profile_image longblob;
insert into author(id, profile_image) values(9, LOAD_FILE('C:\Users\Playdata\Desktop\이미지.PNG'))

-- enum: 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('user','admin') not null default 'user';

-- date: 날짜, datetime: 날짜 및 시,분,초 (m)지정 시 소수점 microseconds
-- date타입은 입력,수정,조회 시 문자열 형식을 활용
alter table post add column created_time datetime default current_timestamp();
UPDATE board.post SET created_time = '2024-11-18 17:12:40' WHERE (id = '6');

-- 조회시 비교연산자
select * from author where id >= 2 and id <= 4;
select * from author where id between 2 and 4; -- 바로 위와 같은 구문
select * from author where id not(id < 2 || id > 4); -- 바로 위와 같은 구문
select * from author where id in (2,3,4); -- 바로 위와 같은 구문
select * from author where id not in (2,3,4); -- 1~5까지밖에 데이터가 없다는 가정하에 바로 위와 같은 구문

--select 조건에 select문을 입력해도 된다.
select * form author where id in(select author_id from post);