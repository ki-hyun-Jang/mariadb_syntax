-- not null 제약조건 추가
alter table author modify column email varchar(255) not null;

-- unique 제약조건 추가
alter table author modify column email varchar(255) unique;
alter table author modify column email varchar(255) not null unique;

-- foreign key 제약조건 삭제 및 추가
-- 제약조건의 이름 확인 후 삭제 및 추가 기능
select * from information_schema.key_column_usage where table_name = 'post'; -- 제약조건 조회
alter table post drop foreign key post_ibfk_1; -- 제약조건 삭제
alter table post add constraint post_author_fk foreign key(author_id) references author(id); --제약조건 추가

-- index 조회성능 향상, 용량차지
-- praimary key, foreign key, unique

-- delete, update 관련 제약조건 테스트
-- on delete cascade 테스트

-- 제약조건 삭제
alter table post drop foreign key post_author_fk;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
-- on delete, set null, on update
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade set null on update set null;

-- default옵션
alter table author modify column name varchar(255) default 'anonymous';
-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- uuid
alter table post add column user_id char(36) default UUID();
