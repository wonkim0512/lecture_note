
# 데이터베이스 생성. 이미 있다면 삭제 후, 생성. 즉 DB를 생성함.
DROP SCHEMA IF EXISTS test;
CREATE SCHEMA test;
USE test;


# 테이블 생성. 이렇게 명령어를 할 수도 있고, test 우클릭 후 create table.
CREATE TABLE students (
   ID INT(11) NOT NULL AUTO_INCREMENT, # ID 정수형(11자리로 제한하겠다.) NULL값 허용하지 않음. 자동 증가하도록 설정(문자열에는 사용 못하겠지.).
   Name CHAR(35) NOT NULL DEFAULT '', # 있고Bame 문자열 35자. NULL값 허용하지 않음. 값이 무언가 하나는 들어와야함. 기본값 ''
   Age int(11) NOT NULL DEFAULT 25,
   MajorCode VARCHAR(10), # MajorCode 문자열 10자. studentsstudentsstudents
   PRIMARY KEY (ID) # 프라이머리 키는 ID 필드
) DEFAULT CHARSET=utf8;

# primary key
# table에서 어떤 레코드를 분별할 수 있는 유일한 값을 갖는 필드
# 대부분의 경우 유일성을 보장할 수 있는 것을 채택한다. ex)주민등록번호
# 이름의 경우 중복 가능성이 있기 때문에 primary key로 적당하지 않다.

# students 테이블 조회
select * from students;

# 데이터 삽입
insert into students(ID, Name, Age, MajorCode) values (1, "Aaron", 34, "CS");
insert into students values(2, "Bob", 30, 'BIO'); # 하지만 모든 칼럼 값에 다 넣기로 지정했으면 굳이 칼럼을 안써줘도됨
insert into students(Name, Age, MajorCode) values("Alice", 24, 'PHIL'); # auto increment로 지정한 ID는 값 써주면 그걸로 넣고, 아니면 순서대로 넣어준다.
select * from students;
# ID필드가 auto increment로 되어있으므로, 아래와 같이 삭제하여 삽입 가능
insert into students(Name, MajorCode) values("홍길동", 'CHE');
delete from students where ID = 3;
insert into students(ID, Name, Age, MajorCode) values(3, "Alice", 24, 'PHIL');
insert into students values(5, "홍길똥", 32, 'EE');
select * from students;

insert into students(Name, Age, MajorCode) values("Amy", 27, 'CS');
insert into students(Name, Age, MajorCode) values("Jason", 22, 'CS');
insert into students(Name, Age, MajorCode) values("Bill", 20, 'EE');

# Name의 default값이 ''이므로 명시하지 않아도 가능
insert into students(MajorCode) values('EE');
select * from students;
# 조건에 부합하는 row의 field 업데이트
update students set Name = "Tim" where Name = "";# Name이 빈 곳을 찾아서 Tim으로 넣어라
#update students set Name = 'Tim2' where MajorCode = "EE" and Age = 25; # 이렇게 조건 추가도 가능
select * from students;

# 조건에 부합하는 row 삭제
delete from students where Name = "Tim";   # Tim이란 Name을 가지고 있는 데이터는 모두 지움. 
#delete from students; #이렇게 조건을 안달면 다 지움.
select * from students;

# index 생성
create index students_name_idx on students(Name);
#drop index students_name_idx on students;students

# 이제 인덱스가 생성되었으므로 검색이 더 빨라짐. 물론 지금은 데이터 크기가 작으니 별 차이가 없지만.
select * from students
	where Name = "홍길동";
    
# 아래 쿼리에는 인덱스가 영향을 미치지 않음
select * from students
	where Name = '홍길동'
    and MajorCode = 'CHE';
    
# 두개의 필드에 모두 인덱스를 걸어줘야 함.
create index students_name_major_idx ON students (Name, MajorCode);

select * from students
	where Name = '홍길동'
    and MajorCode = 'CHE';
    
    
# MajorCode 기준으로 내림차순 정렬
select * from students
	order by MajorCode desc; 
    
# Name 기준
select * from students
	order by Name desc;
    
# MajorCode 오름차순, Name 내림차순 정렬
select * from students
	order by MajorCode, Name desc;
    
#Age 내림차순, MajorCode 오름차순
select * from students
	order by Age desc, MajorCode;

# 전체 row의 개수를 알 수 있다.
select count(*)
	from students;
    
# 특정 조건 row의 개수를 알 수 있다.
select count(*)
	from students
    where Age > (select avg(Age)
    from students);

select avg(Age) from students;
select * from students order by Age desc;
	   
# 정수형의 경우 데이터 합, 평균등의 계산이 가능하다.
#select sum(*)
#	from students;
    
select sum(Age)
	from students;
    
select avg(Age)
	from students;
    
# 각 필드에 산술 연산이 가능함.
select sum(Age) / 2 
	from students;
    
select sum(Age), avg(Age)
	from students;
    
    
# between 연산자 사용 가능
select * from students;

select * from students
	where Age between 20 and 30
    and (Name like "A%"); #Name = "K%"가 아니라 like "K%"구나!
    
# NULL 비교
select * 
	from students 
    where Name = NULL; # (X)
    
select *
	from students
	where Name is Null; # (O)
    
    
# 지정한 열에서 중복을 제거하여 데이터를 가져옴. unique한 값만 나옴.
select distinct MajorCode 
	from students;
    

# 집합 함수
# sum, avg, count, max, min
select max(Age), min(Age), sum(Age), avg(Age), count(Age)
	from students;


# group by
# 특정 필드를 기준으로 데이터를 그룹화 시킴
select * 
	from students
    group by MajorCode;


# 주로 집합 함수와 함께 사용됨. 그룹별 집계가 가능
select MajorCode, max(Age), min(Age), avg(Age) 
	from students
    group by MajorCode;
    
# 그룹화 후 집합 함수를 조건으로 걸고 싶다면 where 사용이 불가능
select MajorCode, max(Age), min(Age), avg(Age) 
	from students
    group by MajorCode
    where avg(Age) <= 27; #(X)
    
select MajorCode, max(Age), min(Age), avg(Age) 
	from students
    where MajorCode = 'CS'
    group by MajorCode;  #먼저 필터링 후 그룹핑   
    
select MajorCode, max(Age), min(Age), avg(Age) 
	from students
    group by MajorCode 
    having MajorCode = 'CS'; #먼저 그룹핑 후 having에서 함수 사용.
    
    
select MajorCode, max(Age), min(Age), avg(Age) 
	from students
    group by MajorCode
    having avg(Age) <= 27;
    
# subquery
select * from students
	where Age > 
    (select avg(Age) from students);
    
    
select *
	from (select *
		from students where Age > 26) as t
        where Age = min(Age); # 이 그룹에서 가장 어린 사람의 정보 찾고 싶은데...
        

select min(Age) 
	from (select *
		from students where Age > 26) as t; #subquery 이름을 지정.
            
            
select * from students;
# major table 생성
# ID, Code, Name, Description #뒤에서 다른 테이블과 연동시키려면 type이 같아야 한다. varchar(20)면 뒤에서도 varchar(20)이어야 한다.

describe students;
drop table majors;
create table majors (
	ID INT not null auto_increment,
	Code varchar(10) not null, #code는 자동증가가 안되겠지
    Name char(35) not null default '',
    Description varchar(100) not null default '',
    primary key (ID)) default charset = utf8;

select * from majors;    
    
insert into majors(Code, Name, Description) values('CS', 'Computer Science', 'CSCSCSCS');
insert into majors(Code, Name, Description) values('BIO', 'Biology', 'Biology hahaha');
insert into majors(Code, Name, Description) values('PHIL', 'Philosophy', 'Good');
insert into majors(Code, Name, Description) values('CHE', 'Chemistry', 'Better');
insert into majors(Code, Name, Description) values('EE', 'Electrical Engineering', 'Best');
insert into majors(Code, Name, Description) values('ECO', 'Economics', 'Even Better');
select * from majors; 

select * from students;
select * from majors;

# 교차 조인
# 존재하는 모든 행에 대해 조인 함
select * from students s
	cross join majors m;
    
# 혹은 아래와 같이 표현 가능
select * 
	from students s, majors m;


# 내부조인 (inner join)
# 지정한 열의 값이 일치하는 행만 가져옴

select *   
	from students s
    inner join majors m
    on s.MajorCode = m.Code; 
    
select *
	from students s
	join majors m #그냥 join이라고만 써도됨
    on s.MajorCode = m.Code;

select ID, Name, Age, MajorCode #이렇게 선택적으로 가져오는건 안되나?
	from students s
    join majors m
    on s.MajorCode = m.Code;
    
select * from students;
select * from majors;

select s.ID, s.Name, s.Age, m.Name #헷갈릴만한 것들은 어느 테이블에서 가져왔는지 명시해줘야되
	from students s
    join majors m
    on s.MajorCode = m.Code;


# 외부조인 
# 내부조인과 달리 일치하지 않는 데이터도 가져오게 됨.

select * from students;
select * from majors;
# 왼쪽 외부 조인 (left outer join or left join)
select *
	from students s
    left outer join majors m
    on s.MajorCode = m.Code;
    
select s.ID, s.Name, s.Age, m.Name, m.Description
	from students s
    left join majors m
    on s.MajorCode = m.Code;
    
# 오른쪽 외부 조인 (right outer join or right join)
select * from majors;
select *
	from students s
    right join majors m
    on s.MajorCode = m.Code;
    
select s.ID, s.Name, s.Age, m.Name, m.Description
	from students s
	right join majors m
    on s.MajorCode = m.Code;
    

# 전체 외부 조인 (Mysql 지원하지 않음)
#select *
#	from students s
#    full outer join majors m
#    on s.MajorCode = m.Code;

# 굳이 결과를 받고 싶으면 아래와 같이 함.
select *
	from students s
    right join majors m
    on s.MajorCode = m.Code
	union    #두 결과를 합집합처럼 합침.
select *
	from students s
    left join majors m
    on s.MajorCode = m.Code;

select * 
	from students s
	left join majors m
	on s.MajorCode=m.Code
    union
select *
	from students s
    right join majors m
    on s.MajorCode=m.Code;
    
# 변영효 강사님이 들려준 본인 회사 매출과 쿠폰. inner join과 outer join의 사례로 각각 생각해봐



# 연습문제) courses 테이블과  scores 테이블을 만들고 적당한 데이터를 채우시오.
# course table 생성
# ID, Code, Name
describe students;
create table courses(
	ID int(11) not null auto_increment,
    Code varchar(50) not null default '',
    Name varchar(50) not null default '',
    primary key (ID)) default charset = utf8;
    
select * from courses;

insert into courses(Code, Name) values ("ECON101", "Introduction to Economics");
insert into courses(Code, Name) values ("ECON201", "Game Theory");
insert into courses(Code, Name) values ("ECON301", "Game Theory");
insert into courses(Code, Name) values ("CS101", "Introduction to CS");
insert into courses(Code, Name) values ("CS201", "Data Structure");
insert into courses(Code, Name) values ("CS301", "Algorithm");
select * from courses;
update courses set Name = "Industrial Organization" where Code = "ECON301";
select * from courses;
#delete from courses;

# score table 생성
# ID, StudentID, CourseCode, Score 
create table score(
	ID int(11) not null auto_increment,
    StudentID int(11) not null,
    CourseCode varchar(50) not null default '',
    Score int(10) not null default 0,
    primary key (ID)) default charset = utf8;

#select * from students;
select * from score;
insert into score(StudentID, CourseCode, Score) values(1, "ECON101", 98);
insert into score(StudentID, CourseCode, Score) values(1, "ECON201", 93);
insert into score(StudentID, CourseCode, Score) values(1, "ECON301", 97);
insert into score(StudentID, CourseCode, Score) values(2, "CS101", 81);
insert into score(StudentID, CourseCode, Score) values(2, "CS201", 91);
insert into score(StudentID, CourseCode, Score) values(2, "CS301", 88);
insert into score(StudentID, CourseCode, Score) values(3, "ECON101", 98);
insert into score(StudentID, CourseCode, Score) values(3, "ECON201", 93);
insert into score(StudentID, CourseCode, Score) values(3, "CS101", 81);
insert into score(StudentID, CourseCode, Score) values(3, "CS201", 91);
select * from score;

# 연습문제)
# 1. 학생별 평균 점수를 구하시오
describe score;
select s.StudentID, avg(Score) 
	from score s
    group by StudentID;
    
# 2. 전공별 평균 점수를 구하시오.

# 3. 가장 많은 코스를 듣는 학생과 가장 적은 코스를 듣는 학생은?
select * 
	from courses c
	left join score sstudents
    on c.ID = s.StudentID;

select count(t.StudentID) from (select * 
	from courses c
	left join score s
    on c.ID = s.StudentID) as t
    group by t.StudentID;

# 4. 전체 평균보다 낮은 점수를 기록한 학생의 이름과 나이를 출력하세요.

studentscoursescoursesstudents

# 연습문제 )
# 1. 회원가입이 필요한 쇼핑몰 사이트에 필요한 테이블을 설계해보세요.
# 1.1 회원 테이블, 주문 테이블, 상품 테이블


# 테이블 버림
drop table students;