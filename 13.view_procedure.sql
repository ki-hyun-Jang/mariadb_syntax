-- view: 실제데이터를 참조만 하는 가상의 테이블
-- 사용목적 1) 복잡한 쿼리대신 2)테이블의 컬럼까지 권한 분리

-- view 생성
create view author_for_marketing as select name, email from author;
create view author_for_marketing as select name, email from author where role != 'admin'; -- 조건가능

-- view 조회 
select * from author_for_marketing;

-- view 권한부여
grant select on board.author.author_for_marketing to '계정명'@'localhost';

-- view 삭제
drop view author_for_marketing;

-- 프로시저 생성
DELIMITER //
CREATE procedure hello_procedure()
begin
    실행문;
end
// DELIMITER ;

-- 프로시저 호출
call hello_procedure();

-- 프로시저 삭제
DROP procedure hello_procedure;

-- 게시글 목록조회 프로시저 생성
DELIMITER //
CREATE procedure 게시글목록조회()
begin
    select * from post;
end
// DELIMITER ;

-- 게시글 단건 조회 생성 및 실행
DELIMITER //
CREATE procedure 게시글id단건조회(in post_id bigint)
begin
    select * from post where id = post_id;
end
// DELIMITER ;

call 게시글id단건조회(1);

-- 본인이 쓴 글 목록조회
-- 가정: 본인의 email의 입력값으로 조회, 결과는*
DELIMITER //
CREATE procedure 이메일로글목록조회(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents
    from post p 
    join author_post ap on p.id = ap.post_id
    join author a on ap.author_id = a.id
    where a.email = inputEmail;
end
// DELIMITER ;

-- 글쓰기
DELIMITER //
CREATE procedure 글쓰기(in inputTitle varchar(255), inputContents varchar(3000), inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;
    -- post 테이블에 insert
    insert into post(title, contents) values(inputTitle, inputContents);
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;  
    -- author_post테이블 insert: author_id, post_id
    insert into author_post(author_id, post_id) values(authorId,postId);
end
// DELIMITER ;

-- 글삭제
DELIMITER //
CREATE procedure 글삭제(in inputPostId bigint, in inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint;

    select count(*) into authorPostCount from author_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;

    if authorPostCount=1 then
        delete from author_post where author_id = authorId AND post_id = inputPostId;
        delete from post where id = inputPostId;
    else
        delete from author_post where author_id = authorId AND post_id = inputPostId;
    end if;
end
// DELIMITER ;


-- 반복문을 통해 post대량 생성: title, 글쓴이email
DELIMITER //
create procedure 글도배(in count int, in inputEmail varchar(255))
begin
    declare countValue int default 0;
    declare authorId bigint;
    declare postId bigint;
    while count > countValue do
        insert into post(title) values("안녕하세요 ㅎ2ㅎ2");
        select id into postId from post order by id desc limit 1;
        select id into authorId from author where email = inputEmail;  

        insert into author_post(author_id, post_id) values(authorId,postId);
        set countValue = countValue +1 ;
    end while;
end
// DELIMITER ;