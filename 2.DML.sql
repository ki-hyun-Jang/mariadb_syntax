-- insert into: 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);

-- 문자열은 일반적으로 작은 따옴표를 사용
insert into author(id, name, email) values(1, 'Jang', 'skjwj0511@naver.com');

--  select: 데이터조회, *은 모든 컬럼을 의미
select * from author;
select name, email from author;

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

-- update: 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set name ='홍길동' where id=1;
update author set name = '홍길동2', email='honggildong@naver.com' where id=2;

-- delete: 데이터 삭제
-- where조건을 생략할 경우 모든 데이터가 삭제됨에 유의
delete from author where id = 5;

-- select: 조회
select * from author; -- 어떠한 조건없이 모든 컬럼 조회
select * from author where id=1; -- where 뒤에 조회 조건을 통해 조회
select * from author where name = 'honggildong';
select * from author where id > 3;
select * from author where id > 2 and address="수원시"; -- 또는 일경우에는 or를 사용

-- 중복제거 조회: distinct
select distinct name from author;

-- 정렬: order by + 컬럼명
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순 정렬
-- asc: 오름차순, desc: 내림차순 -> 디폴트는 asc
select * from author order by name desc;

-- 멀티컬럼 order by: 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬. 중복 시 그 다음 정렬옵션 적용
select * from author order by name desc, email asc;

-- 결과값 개수 제한
select * from author order by id desc limit 2; -- id 내림차순 정렬 기준 2개 제한 조회

-- 별칭(alias)을 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is not null;
select * from author where password is null;