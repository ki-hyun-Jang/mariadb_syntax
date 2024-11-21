-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id=post.author_id;
select * from author a inner join post p on a.id=p.author_id;
--출력순서만 달라질뿐 조회결과는 동일
select * from post inner join author on author.id=post.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
-- post의 글쓴이가 없는 데이터는 포함x, 글쓴이 중에 글을 한번도 안쓴 사람 포함x
select p.*,email from post p inner join author a on a.id=p.author_id;
-- 글쓴이가 있는 글의 제목, 내용, 그리고 글쓴이의 이메일만 출력하시오.
select p.title, p.contents, a.email from post p inner join author a on a.id=p.author_id;

-- outer join
-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일 정보를 출력.
-- left outer join -> left join으로 생략가능
-- 글을 한 번도 안쓴 글쓴이 정보는 포함x
select p.*, a.email from post p left join author a on a.id=p.author_id;

-- 글쓴이를 기준으로 left join할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 여러 번 출력될 수 있음.
-- author와 post가 1:n관계이므로.
-- 글쓴이가 없는 글은 포함
select * from author a left join post p on a.id=p.author_id;

-- 실습) 글쓴이가 있는 글 중에서 글의 제목과 저자의 이메일을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력
select p.title, a.author_id from post p left join author a on a.id=p.author_id where a.age>=30;

-- 글의 내용과 글의 저자의 이름이 있는 글 목록을 출력하되, 2024년6월이후에 만들어진글만
select p.title, a.name, p.created_time from post p join author a on a.id=p.author_id where a.name is not null and p.contents is not null and p.created_time >'2024-05-31 23:59:59';
-- 부등호보다는 date_format이 가장 정확하다

-- union: 두테이블의 select 결과를 횡으로 결합(기본적으로 distinct 적용)
-- column의 개수와 컬럼의 타입이 같아야함에 유의
-- column all: 중복까지 포함
select name, email from author union select title, contents from post;

-- 서브쿼리: select문 안에 또 다른 select문을 서브쿼리라고한다.
-- where절 안에 서브쿼리
-- 한 번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id=p.author_id;
select * from author where id in (select author_id from post);

-- select절 안에 서브쿼리
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력 
select a.email, (select count(*) from post where author_id=a.id) from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- 집계함수
--count : 행의 개수를 세지만, null은 count에서 제외
select count(*) from author;
select sum(price) form post;
select avg(price) from post;
-- 소수점 첫 번째 자리에서 반올림해서 소수점을 없앰
select round(price,0) from post;
select round(avg(price),0) from post;

-- group by: 그룹화된 데이터를 하나의 행(row)처럼 취급
-- author_id로 그룹핑을 했으면, 그 외의 컬럼은 조회하는 것은 적철하지 않음.
select author_id from group by author_id;
-- group by와 집계함수
-- 아래 쿼리에서 *의 의미는 그룹화된 데이터내에서의 개수를 말한다.
select author_id,count(*) from post group by author_id;
select author_id,count(*),sum(price) from post group by author_id;

-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id=a.id) from author a;
-- join과 group by, 집계함수 활용한 글의 개수 출력
select a.id, a.email, count(p.author_id)
from author a left join post p on a.id=p.author_id
group by a.id;

-- where와 group by
-- 연도별로 post 글의 개수 출력, 연도가 null인 값은 제외
select date_format(created_time,'%Y') as year, count(*)
from post
where created_time is not null
group by year;

-- having: group by를 통해 나온 집계값에 대한 조건
-- 글을 2개 이상 쓴사람에 대한 정보조회
select author_id from post group by author_id having count(*)>=2

select author_id, count(*) as cnt 
from post 
group by author_id
having cnt>=2

-- 다중 열 group by
-- post에서 사용자마다 작성자가 만든 제목에 개수를 출력하시오.
select author_id, title, count(*) from post group by author_id, title;
