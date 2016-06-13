select user from dual;
-- DB 목록을 보여준다. 
show databases;
-- DB명을 선택한다. 사용한 DB를 선택하는 쿼리 
use test;
-- 현재 선택되어 있는 DB내의 테이블을 보여준다. 
show tables;

-- drop table user;






-- user 테이블 생성(사용할 유저를 생성/저장/삭제)
create table user
( user_id     int not null auto_increment primary key,
  user_name   nvarchar(30) not null,
  user_tel     nvarchar(50),
  user_email   nvarchar(120),
  user_des     nvarchar(120)
);

-- game reuslt 테이블 생성(게임을 생성할 때마다 생성)
create table result
( game_id    int not null auto_increment primary key,
  game_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- result_detail테이블 생성(유저의 아이템 저장/수정)
create table result_detail
( user_id     int not null, 
 game_id    int not null ,
  user_item      nvarchar(120),
 CONSTRAINT UNO_USER_FK FOREIGN KEY(user_id) REFERENCES user(user_id)
						on delete cascade,
CONSTRAINT GNO_RESULTLIST_FK FOREIGN KEY( game_id) REFERENCES result( game_id)
);

drop table result_detail;
drop table result;

delete 
from result_detail
where game_id=502;

select *
from result_detail;


delete 
from result
where game_id=502;

select *
from result;

rollback;

show databases;

show tables;

drop table user;
  
select * from result_detail;


-- user 테이블 기본 데이터 입력 
insert into user(user_name, user_tel, user_email, user_des) 
values ('윤기준', '010-7583-9430', 'kjyoo@aksys.co.kr', 'CEO');
insert into user(user_name, user_tel, user_email, user_des) 
values ('이종범', '010-6256-2161', 'jblee@aksys', '부사장');
insert into user(user_name, user_tel, user_email, user_des) 
values ('이서정', '010-3225-0922', 'sj2531009@aksys.co.kr', '과장');
insert into user(user_name, user_tel, user_email, user_des) 
values ('김태수', '010-8410-8930', 'tskim@aksys.co.kr', '소장');
insert into user(user_name, user_tel, user_email, user_des) 
values ('백현섭', '010-2413-3997', 'hsbaek@aksys.co.kr', '수석');
insert into user(user_name, user_tel, user_email, user_des) 
values ('여기석', '010-8021-8051', 'krisyeo@aksys.co.kr', '책임');
insert into user(user_name, user_tel, user_email, user_des) 
values ('문준태', '010-2352-7136', 'jtmoon@aksys.co.kr', '책임');
insert into user(user_name, user_tel, user_email, user_des) 
values ('윤형준', '010-4030-3256', 'hiyun@aksys.co.kr', '주임');
insert into user(user_name, user_tel, user_email, user_des) 
values ('김영태', '010-2790-4845', '', '선임');
insert into user(user_name, user_tel, user_email, user_des) 
values ('허송희', '010-4155-1451', 'songhe23@aksys.co.kr', '연구원');

select *
from user;


 -- 한글깨짐 해결 

-- 테이블 삭제 
-- drop table user
-- 커밋 
commit;
select *
from user;

-- result 테이블에 게임 데이터 입력
insert into result(game_id, game_date) 
values (1, now());
insert into result(game_id, game_date) 
values (2, now());
insert into result(game_id, game_date) 
values (3, now() );
insert into result(game_id, game_date) 
values (4, now());
insert into result(game_id, game_date) 
values (5, now());
insert into result(game_id, game_date) 
values (6, now());

select *
from result;
commit;

--  result_detail 데이터에 아이템 정보 입력 
insert into result_detail(user_id, game_id, user_item) 
values ('1','1','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('2','1','10000');
insert into result_detail(user_id, game_id, user_item) 
values ('3','1','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('4','1','5000');
insert into result_detail(user_id, game_id, user_item) 
values ('5','1','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('6','1','꽝');


insert into result_detail(user_id, game_id, user_item) 
values ('5','2','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('7','2','10000');
insert into result_detail(user_id, game_id, user_item) 
values ('8','2','꽝');


insert into result_detail(user_id, game_id, user_item) 
values ('1','3','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('4','3','10000');
insert into result_detail(user_id, game_id, user_item) 
values ('5','3','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('6','3','꽝');
insert into result_detail(user_id, game_id, user_item) 
values ('10','3','꽝');


show databases;

use test;

show tables;
-- ★★ 사용자 관리 페이지--------------------------------------------------------- 

-- 유저 검색기능 
select @rownum := @rownum+1 as rownum, user_name, user_tel, user_email, user_des
from user,  (select @rownum:=0) r
where user_tel like '%%';

select *
from user;


-- 이름 오름차순
select @rownum := @rownum+1 as rownum, user_name, user_tel, user_email, user_des
from user,  (select @rownum:=0) r
where user_name like '%%'
order by user_name ;
-- 이름 내림차순
select @rownum := @rownum+1 as rownum, user_name, user_tel, user_email, user_des
from user,  (select @rownum:=0) r
order by user_name desc;

commit;


-- 유저 추가 
 insert into user(user_name, user_tel, user_email, user_des) 
values ('윤기준', '010-7583-9430', 'kjyoo@aksys.co.kr', 'CEO');

commit;
-- 유저 삭제 
delete 
from user on delete cascade
where user_id=14 ;

-- ★★ 사다리 생성 --------------------------------------------------------- 

-- 게임 생성 후 
-- result 테이블에 게임 데이터 입력
insert into result(game_date) 
values (now());

select max(game_id) game_id
from result_detail;

select max(game_id) from result;



-- 생성된 게임에 유저 추가 * 참가한 유저 아이디 만큼 
insert into result_detail(user_id, game_id) 
values ('9',(select max(game_id)
							  from result));
                              
 commit;
 
delete 
from result_detail
where game_id = (select max(game_id) game_id
							from result_detail);            
 
delete
from result
where game_id=(select 
						   max(game_id) 
						   from result);
                              
select *
from result_detail
where game_id = 200;

delete 
from result_detail
where game_id>10;

commit;

select *
from user;

select *
from result;

select *
from result_detail;

delete
from result_detail ;



commit;

insert into result_detail(user_id, game_id) 
values ('10','4');
insert into result_detail(user_id, game_id) 
values ('8','4');
insert into result_detail(user_id, game_id) 
values ('4','4');
insert into result_detail(user_id, game_id) 
values ('7','4');


select  @rownum := @rownum+1 as rownum,  user_name, user_des, user_item
from result_detail  r join user u
on r.user_id=u.user_id,  (select @rownum:=0) f
where r.game_id=(select max(game_id)
							  from result)
order by user_name;
							
-- 라인별 상품 입력 란에 들어감 
update result_detail
set user_item='5000'
where user_id='6' and game_id='4';
update result_detail
set user_item='꽝'
where user_id='10' and game_id='4';
update result_detail
set user_item='꽝'
where user_id='8' and game_id='4';
update result_detail
set user_item='1000'
where user_id='4' and game_id='4';
update result_detail
set user_item='꽝'
where user_id='7' and game_id='4';

-- ★★ 사다리 타기--------------------------------------------------------- 

-- 게임할 때 (이름, 아이템)
select  @rownum := @rownum+1 as rownum,  user_name,user_item
from result_detail  r join user u
on r.user_id=u.user_id,  (select @rownum:=0) r
where game_id=2;


-- ★★ 결과 -------------------------------------------------------------
-- 결과/지난 게임 상세 
select  @rownum := @rownum+1 as rownum,  user_name, user_des, user_item, r.game_date game_date
from result r join result_detail  d join user u
on r.game_id=d.game_id and  u.user_id=d.user_id,  (select @rownum:=0) r
where d.game_id=4
order by d.user_item;

delete 
from result
where game_id =;


select game_date
from result 
where game_id=4;


-- ★★ 지난게임 목록  --------------------------------------------------------- 
-- 지난게임 목록 
select  d.game_id game_id, r.game_date game_date
from result r join result_detail d join user u
on r.game_id=d.game_id and  u.user_id=d.user_id
where user_name like '%%'
group by r.game_id
order by r.game_date desc;


-- +game_id, user_id, user_item 출력하는 쿼리 

select  @rownum := @rownum+1 as rownum,  user_name, user_des, user_item
,u.user_id user_id, r.game_id game_id
from result_detail  r join user u
on r.user_id=u.user_id,  (select @rownum:=0) f
where r.game_id=(select max(game_id)
							  from result)
order by user_name;
							

-- Exception 처리 
delete from user where user_id=23 ;

select *
from user 
where user_id=23; 

select *
from result_detail;








