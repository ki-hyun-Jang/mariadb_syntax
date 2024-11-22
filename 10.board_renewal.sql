-- 여러 사용자가 1개의 글을 수정할 수 있다고 가정 후 DB리뉴얼
-- author와 post가 n:m관계가 되어 관계테이블을 별도로 생성
create database board;
use board;

create table author(id Bigint primary key auto_increment, email varchar(255), password varchar(255), name varchar(255), created_time datetime);
create table post(id Bigint primary key auto_increment, title varchar(255), contents varchar(3000), created_time datetime);
create table author_address(id Bigint primary key auto_increment, author_id bigint, conutry varchar(255), city varchar(255), street varchar(255), created_time datetime, FOREIGN KEY (author_id) REFERENCES author(id));
create table author_post(id Bigint primary key auto_increment, author_id bigint, post_id bigint, created_time datetime, FOREIGN KEY (author_id) REFERENCES author(id), FOREIGN KEY (post_id) REFERENCES post(id));

describe author;
ALTER TABLE author modify column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE author modify column email varchar(255) not null;

describe post;
ALTER TABLE post modify column title varchar(255) not null;
ALTER TABLE post modify column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;


describe author_address; -- 1:1관계를 보장하려면 author_id unique설정
ALTER TABLE author_address modify column author_id bigint not null;
ALTER TABLE author_address modify column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;

describe author_post; -- n:m관계인 author과 post가 정규화가 되지않기에 연결테이블 생성
ALTER TABLE author_post modify column author_id bigint not null;
ALTER TABLE author_post modify column post_id bigint not null;
ALTER TABLE author_post modify column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE author_post DROP COLUMN update_time;


-- 복합키예제로 author_post 생성
create table author_post2(
    author_id bigint not null,
    post_id bigint not null,
    primary key(author_id, post_id),
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id)
);
-- 제약조건 테이블
select * from information_schema.key_column_usage where table_name = 'author_post2';
-- index조회
show index from author_post2;
-- 조회 시 복합키를 걸어놨으니 두 개의 fk를 조건으로 조회를 해야함
select * from author_post2 where author_id = 1 and post_id=2;

-- 저자별 글쓴 개수 조회
select a.*, count(*) as count
from author a join author_post ap on a.id=ap.author_id
group by a.id
order by a.id;