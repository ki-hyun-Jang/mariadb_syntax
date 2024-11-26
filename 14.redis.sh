# redis 설치
sudo apt-get install redis-server

# redis 접속
redis-cli

# redis는 0~15번까지의 database로 구성 (default는 0번)
# 데이터베이스 선택
select db번호

# 데이터베이스내 모든 키 조회
keys *

# 일반적인 String 자료구조. 만약 이미 값이 존재하면 덮어쓰기
set key명 value값
set email_1 hong@naver.com
# nx: 이미 존재하면 pass, 없으면 set
set email_1 hong@naver.com nx
# ex: 만료시간(초단위) - ttl(time to live)
set email_1 hong@naver.com ex 10

# get를 통한 value값 얻기
get email_1

# 특정 key삭제
del email_1
# 현재 db내에 모든 key삭제
flushdb

# redis 활용 예시: 동시성이슈
# 1. 좋아요 기능 구현
set like:posting:1 0
# 좋아요 눌렀을 경우
incr like:posting:1 # 특정 key값의 value를 1만큼 증가
decr like:posting:1 # 특정 key값의 value를 1만큼 감소
get like:posting:1

# 2. 재고관리
set stocks:product:1 100
decr stocks:product:1
get stocks:product:1
# bash쉘을 활용하여 재고감소 프로그램 작성

# redis활용예시 : 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 -> json형식으로 저장
set author:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":28}\"}" ex 20

# list 자료구조
# redis의 list는 java의 deque와 같은 자료구조, 즉 double-ended queue구조

# lpush: 데이터를 왼쪽에 삽입
# rpush: 데이터를 오른쪽에 삽입
# lpop: 데이터를 왼쪽에 꺼내기
# rpop: 데이터를 오른쪽에 꺼내기

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3
rpop hongildongs

# list 조회
# -1은 뒤에서 부터 1번째
lrange hongildongs 0 0
lrange hongildongs -1 -1
lrange hongildongs 0 -1
lrange hongildongs -3 -1

# 데이터 개수 조회
llen hongildongs
# ttl 사용
expire hongildongs 20
# ttl 조회
ttl hongildongs
# pop과 push를 동시에 -> a리스트에서 pop해서 b리스트를 push
rpoplpush Alist Blist
# 최근 방문한 페이지 -> 5개push, 최근방문한 페이지 3개만

# set자료구조: 중복없음, 순서없음
sadd memberlist member1
sadd memberlist member2
sadd memberlist member1

# set 조회
smembers merberlism
# set멤버 개수 조회
scard memberlist

# set에서 멤버 삭제
srem memberlist member2
# 특정 멤버가 set안에 있는지 존재여부 확인
sismember memberlist member1

# 좋아요 구현
sadd like:posting:1 member1
sadd like:posting:1 member2
sadd like:posting:1 member1
scard like:posting:1 member1

# zest: stored set
# 사이에 숫자는 score이며,score값을 기준으로 정렬가능
zadd  memberlist 3 members1
zadd  memberlist 4 members2
zadd  memberlist 1 members3
zadd  memberlist 2 members4

# 조회방법
# score 기준 오름차순 정렬
zrange memberlist 0 -1
# score 기준 내림차순 정렬
zrevrange memberlist 0 -1

# zset삭제
zrem memberlist members4

# zrank: 특정멤버가 몇번째(index) 순서인지 출력
zrank memberlist members4

# hashes: map 형태의 자료구조 (key:value, key:value ... 형태의 자료구조)
hset author:info:1 name "hong" email "hong@naver.com" age 30
# 특정값 조회
hget author:info:1 name
# 모든 객체값 조회
hgetall author:info:1

# 특정 요소 값 수정
hset author:info:1 name "jang"