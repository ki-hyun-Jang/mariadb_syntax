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

-- like: 특정문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드이다.
select * from post where tilte Like "%h"; -- h로 끝나는 title 조회
select * from post where tilte Like "h%"; -- h로 시작하는 title 조회
select * from post where tilte Like "%h%"; -- h를 포함하는 title 조회

-- regxp: 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 소문자가 하나라도 포함되어 있는 데이터 조회
select * from post where title not regexp '[a-z]'; -- 소문자가 하나라도 포함되어 있지않은 데이터 조회
select * from post where title regexp '[가-힣]'; -- 한글이 하나라도 포함되어 있는 데이터 조회

-- 타입 변환 cast, convert: 숫자-> 날짜, 문자-> 날짜
select cast(20241119 as date);
select cast('20241119' as date);
select convert(20241119, date);
select convert('20241119', date);
-- 문자 -> 숫자 변환
select cast('22' as unsigned);

-- 날짜조회 방법
-- like패턴, 부등호 활용
select * from post where created_time like '2024-11%'; -- 문자열처럼
select * from post where created_time >= '2024-01-01' && created_time < '2025-01-01';

--date_format 활용
select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, "%Y") = '2024';
select * from post where cast date_format(created_time, '%Y') = 2024 as unsigned = 2024;

-- 오늘날짜 및 시간
select now();
