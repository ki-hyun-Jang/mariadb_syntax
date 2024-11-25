# 덤프파일 생성
mysqldump -u root -p database명 > 파일명.sql
# 한글 깨질때
mysqldump -u root -p database명 -r 파일명.sql
# 덤프파일 적용(복원)
# <가 특수문자로 인식되어, window에서는 적용이 안될경우 git bash로 사용
mysql -u root -p database명 < 파일명.sql
mysql -u root -p board < dumpfile.sql

# dumpfile파일을 gihub에 push
# Linux에서 mariaDB설치
sudo apt-get install mariadb-server

# marriadb서버 실행
sudo systemctl start mariadb

# mariadb 접속
mariadb -u root -p
create database board;

# git설치
sudo apt install git

# git에서 repository clone
git clone ropositoryURL

# linux에서 mariadb 덤프파일 적용