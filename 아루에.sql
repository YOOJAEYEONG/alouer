/****************
아루에 프로젝트 
*****************/
create table alouer_member (
    memberid varchar2(50) primary key,
    authority varchar2(20) default 'ROLE_USER',
    enabled number(1) default 1,
    pass varchar2(50)not null,
    name varchar2(20),
    hp varchar2(20),
    address varchar2(200),
    birth date,
    subscribe varchar2(1),
    edu1 varchar2(100),
    edu2 varchar2(100),
    history varchar2(1000)    
);
select theme,color from arts where theme='상상' or color='파랑';
select theme,color from arts where theme in ('상상','동물') and color in ('파랑','초록');
select memberid from alouer_member where memberid like '%@%';
--더미데이터
insert into alouer_member (memberid, authority, pass, name)
    values('admin', 'ROLE_ADMIN', '1234', '관리자');
insert into alouer_member (memberid, pass, name, hp)
    values('test@alouer.com', '1111', '유저0','010-1234-1234');
insert into alouer_member (memberid, pass, name, hp)
    values('user2@alouer.com', '1111', '유저2','010-1234-1234');
    insert into alouer_member (memberid, pass, name, hp)
    values('user3@alouer.com', '1111', '유저3','010-1234-1234');
desc alouer_member ;
alter table alouer_member MODIFY name varchar2(20) null;

commit;
---------------------------------------------------------------------------
--작품테이블
create table arts(    
    code varchar2(50) primary key,
    title varchar2(500) not null,
    memberid varchar2(50) references alouer_member(memberid),
    name varchar2(100),
    note1 varchar2(4000),
    note2 varchar2(4000),    
    material varchar2(100),
    prodyear number,
    sizeho number,
    height number,
    width number,
    regidate date,
    imageurl varchar2(1000),
    artvalue number,
    rentalprice number,
    pageurl varchar2(300),
    theme varchar2(10),
    color varchar2(10),
    status varchar2(100)
);
drop table arts;
drop table alouer_member;
drop SEQUENCE arts_seq;
--임시 시퀀스 생성
create sequence arts_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    nocache;

--더미데이터
insert into arts values(
    'A0096-002'||arts_seq.nextval, 'slumberer-13-'||arts_seq.nextval , 'test1', '테스트'||arts_seq.nextval, 
    '언어를 통해 사비트은 이러한다. 감상자얻게 된다.',
    '바쁜 일상, 화려하고 자은 분께 이 작품을 추천해드립니다.',
    '캔버스에 유채', 2015, 100, 130, 160, sysdate, 
    'https://og-data.s3.amazonaws.com/media/artworks/w_fixed/A0254/A0254-0032.jpg', 
    100000,10000, '', '정물','초록'
);
select distinct status from arts;
--기본적인 listPage 처리 함수에서 필터기능을 추가함
SELECT * FROM (
			SELECT Tb.*, rownum rNum FROM (
				SELECT * FROM arts WHERE 1=1
					AND theme = ANY( '풍경','상상' )
					AND color = ANY( '빨강','노랑','파랑','초록' )
				ORDER BY code DESC
			) Tb
		)
		WHERE rNum BETWEEN 1 AND 999999999999999
        ;
        
-- arts 검색 필터	
SELECT count(*) FROM (
    SELECT Tb.*, rownum rNum FROM (
        SELECT theme, color,status
        FROM arts where 1=1 and theme  in('상상','동물')
        INTERSECT
        SELECT theme, color,status
        FROM arts where 1=1 and color in('파랑','빨강')
        INTERSECT
        SELECT theme, color,status
        FROM arts where 1=1 and status in('렌탈가능')
        
    )Tb
)
WHERE rNum BETWEEN 1 AND 10
;



-- 렌탈가 3만원 이하 레코드가 없어서 를 강제로 변경함
desc arts;
update arts set rentalprice = 30000 where rentalprice <30000;  
select * from arts where rentalprice <300000;
     
 select code, status from arts where code = 'A0948-0008';
 commit;
select * from auctioninfo where code = 'Aasdlfkj'; 
update arts set status  = '경매준비중' where code = 'A1243-1114';
select * from(
    select * from arts
    order by DBMS_RANDOM.RANDOM
) where rownum < 10;
select COUNT(*) from arts where rownum < DBMS_RANDOM.RANDOM;

update arts set status = 'rental' where rownum = 2;  -- rownum이 () 번째인 레코드의 status를 rental 중인 것으로 설정한다

select round(DBMS_RANDOM.VALUE(1,1500)) from dual; -- 5~1사이의 난수 발생


select round(DBMS_RANDOM.VALUE(1,1500)) from arts;

select * from (
    select rownum as "rn" ,  
        CODE,TITLE,MEMBERID,NAME,NOTE1,NOTE2,
        MATERIAL,PRODYEAR,SIZEHO,HEIGHT,WIDTH,REGIDATE,IMAGEURL,
        ARTVALUE,RENTALPRICE,PAGEURL,THEME,COLOR,STATUS 
    from  arts )
where "rn" = 55
;
select count(*), status  from arts group by status;
commit;
-- 랜덤하게 상태를 렌탈가능으로 셋팅함
select * from auctioninfo;

DECLARE
    
BEGIN
        for idx in 1 .. 200 loop
            
                UPDATE arts a
                SET a.status = '지분경매'
                WHERE ROWID IN (SELECT rid
                   FROM (SELECT ROWID rid
                              , ROW_NUMBER() OVER(ORDER BY code) rn
                           FROM arts
                         )
                  WHERE rn = round(DBMS_RANDOM.VALUE(1543,1))
                );
                dbms_output.put_line(idx||' 개의 작품 상태가 변경됨');
    end loop;
end;
/

update  (
    select rownum as "rn" ,  
        CODE,TITLE,MEMBERID,NAME,NOTE1,NOTE2,
        MATERIAL,PRODYEAR,SIZEHO,HEIGHT,WIDTH,REGIDATE,IMAGEURL,
        ARTVALUE,RENTALPRICE,PAGEURL,THEME,COLOR,STATUS 
    from  arts ) 
set status = 'rental'
where "rn" = 55
;


-- auctioninfo 테이블에서 경매 등록되어있는 작품코드 레코드의 갯수 만큼 
-- arts 테이블에 status '지분경매' 변경 처리하는 PL/SQL
set SERVEROUTPUT on;
DECLARE
    code1 varchar2(50);
    total number;
BEGIN
    select count(*) into total from arts where status = '지분경매';
    for idx in 1 .. total loop
    
        dbms_output.put_line(idx);  
        
        select code 
            into code1
        from (select rownum rNum, code from arts)
        where rNum = idx;
        
        dbms_output.put_line(code1);  
        
        --update arts set status = '지분경매' where code = code1;
        insert into auctioninfo ()
            values();
        
    end loop;
end;
/
---------------------------------------------------------
/*rowid를 이용한 랜덤 행 update 하기*/
UPDATE arts a
   SET a.status = '렌탈가능'
                  
 WHERE ROWID IN (SELECT rid
           FROM (SELECT ROWID rid
                      , ROW_NUMBER() OVER(ORDER BY code) rn
                   FROM arts
                 )
          WHERE rn = round(DBMS_RANDOM.VALUE(1,1500))
         );
 ------------------------------------------------------------------------------
 select status from arts where status is not null;
  commit;
select code,rentalprice,status from arts where status = '렌탈중' order by rentalprice ;
update arts set status = '렌탈중' where status is null;
select code from arts where code like 'A0847-0001';
update arts set code = trim(code);
select count(*) from arts where status = '렌탈가능';
------------------------------------------------------------
/*******************
테이블 : auctioninfo
*******************/
create table auctioninfo (
    auctionid   number primary key,
    code             varchar2(50) 
        constraints auctioninfo_FK references arts (code) ,
    startbids    number not null,
    starttime   timestamp not null, -- default SYSTIMESTAMP
    endtime     timestamp  not null,
    auctionTotal number not null,
    isFinish number default 0
);
commit;
select * from alouer_member where memberid='admin@naver.com';
update alouer_member set memberid ='admin@alouer.com' where memberid='admin@naver.com';
drop table auctioninfo;
drop table au_trans;
drop sequence auctioninfo_seq;
drop sequence au_trans_seq;

create sequence auctioninfo_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    nocache;

insert into auctioninfo values(
    auctioninfo_seq.nextval, 
    'A0847-0001', 
    5000, 
    SYSTIMESTAMP,
    to_timestamp('20200814152301123', 'YYYYMMDDHH24MISSFF'),
    1000
);
delete auctioninfo;
delete au_trans;
delete deposittb;
drop sequence auctioninfo_seq;
drop sequence deposittb_seq;
drop sequence au_trans_seq;
select * from deposittb;
select * from au_trans;
select * from auctioninfo;
commit;
rollback;
update auctioninfo 
    set startbids = 1500,auctiontotal = 8
where auctionid = 8;
commit;
update arts set status = '렌탈중' where code =  'A0712-0162';
select * from auctioninfo ;
alter table auctioninfo add isFinish number default 0 ;
select * from arts where code = 'A0712-0162';
delete auctioninfo where startbids = 10000;
select code, status from arts; 
insert into auctioninfo values(
    auctioninfo_seq.nextval, 
    'abc', 
    50000, 
    SYSTIMESTAMP,
    to_timestamp('2020-08-03 10:22:35', 'YYYY-MM-dd HH:mm:ss'),
    1000
);
update auctioninfo 
    set endtime = to_timestamp('2020 07 29 12 00 01 123', 'YYYYMMDDHH24MISSFF')
    where auctionid = 2;

commit;
-- systimestamp -> DATE 타입으로 형변환
select CAST(SYSTIMESTAMP as DATE) from auctioninfo;
/*******************
테이블 : au_trans
*******************/
create table au_trans (
    a_transid   number primary key,
    auctionid   number 
        constraints auctionid_FK references auctioninfo (auctionid) ,
    memberid varchar2(50) 
        constraints memberid_FK references alouer_member (memberid),
    code            varchar2(50)  
         constraints code_FK references arts (code),
    bidsprice   number  not null,
    auctiontime  timestamp default SYSTIMESTAMP
);

create sequence au_trans_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    nocache;
    
-- 더미데이터
insert into au_trans values (
    au_trans_seq.nextval,
    8,
    'user1@alouer.com',
    'A0574-0005',
    3000,
    to_timestamp('20200729094113022', 'YYYYMMDDHH24MISSFF') --SYSTIMESTAMP
    -- 20200729074113022
);
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   'user1@alouer.com',    3000,    0,  43000, 'A0574-0005 경매 입찰',  to_date('20200729094114', 'YYYYMMDDHH24MISS') );
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   'user1@alouer.com',    0,    50000,  54000, '예치금 입금',  to_date('20200729094113', 'YYYYMMDDHH24MISS') );
select * from deposittb where memberid = 'user1@alouer.com';
select * from auctioninfo where auctionid = 8;



-- 경매상세보기 페이지에서 입찰가격별 입찰 수량을 표시함
select bidsprice,  count(bidsprice) lot from 
        (select * from au_trans where auctionid = 2) 
group by bidsprice 
order by bidsprice desc;

 select status from arts where ;



-- 경매 입찰 현황을 시간순으로 조회
select rownum rN, TbSec.* from
    (SELECT * FROM (
                SELECT Tb.*, rownum rNum FROM 
                    (SELECT * FROM au_trans) Tb 
                where auctionid = 8 
            ) 
    WHERE rNum BETWEEN 1 AND 10
    order by auctiontime desc) TbSec
;
-- 페이징시 rownum 값 개선
select  TbSec.* from
    (SELECT * FROM (
                SELECT Tb.*, rownum RN FROM 
                    (SELECT * FROM au_trans order by bidsprice desc) Tb 
                where auctionid = 2
                
            ) 
    WHERE RN BETWEEN 10 AND 20
    order by auctiontime desc) TbSec
;
------------------------------------------------------------------
-- 경매 입찰 기능 1주당 각각 insert를 진행하여 레코드를 기록하는 프로시저
-- 아래는 회원아이디:'A0006' 이 3주를 1500원에 입찰하는경우 
DECLARE

BEGIN
    for idx in 1 .. 3 loop
        INSERT INTO au_trans
            VALUES (
                au_trans_seq.NEXTVAL, 
                2, 
               'A0006', 
                'A1214-0023', 
                1500, 
                SYSTIMESTAMP
            );
    end loop;
end;
/
---------------------------------------------
--경매 등록
insert into auctioninfo values(
    auctioninfo_seq.nextval, 
    'A0847-0001', 
    5000, 
    SYSTIMESTAMP,
    to_timestamp('20200814152301123', 'YYYYMMDDHH24MISSFF'),
    1000
);
----------------------------------------------------
-- arts테이블에서 지분경매 상태인 레코드의 갯수만큼 auctioninfo테이블에 경매 등록처리하는 PL/SQL
--0단계
select count(*) from arts where status = '지분경매';
--1단계
select rownum,code,status from arts where status = '지분경매' ;
--2단계
select code,status 
from (select rownum rNum, code,status from arts where status ='지분경매')
where rNum = 51;

select count(*) from arts where status ='지분경매'; -- 51
select * from auctioninfo;
set SERVEROUTPUT on;

DECLARE
    code1 varchar2(50);
    total number;
BEGIN
    select count(*) into total from arts where status ='지분경매';
    for idx in 1 .. total loop
    
        dbms_output.put_line(idx);  
        
        select code 
            into code1
        from (select rownum rNum, code from arts where status ='지분경매')
        where rNum = idx;
        
        dbms_output.put_line(code1);  
        
        insert into auctioninfo (auctionid,code,startbids,starttime,endtime,auctionTotal) 
        values (
            auctioninfo_seq.nextval, 
            code1 , 
            1000,  
            SYSTIMESTAMP,
            to_timestamp('20200806152301123', 'YYYYMMDDHH24MISSFF'),
            10 
        );
  
    end loop;
end;
/
select * from deposittb where memberid = 'user1@alouer.com';
insert into deposittb 
 values (DEPOSITTB_SEQ.nextval,'test@alouer.com',0,1000000,1003000,'예치금입금',systimestamp);
commit;
select * from alouer_member where memberid like '%@%';
--------------------------------------------------------------
--경매가 끝나고 [마이페이지]에서 낙찰현황을 조회하는 경우
SELECT * FROM (
    SELECT Tb.*, rownum rNum 
    FROM (SELECT * FROM au_trans Trans
                            inner join auctioninfo AuInfo
                            on Trans.auctionid = AuInfo.auctionid
                        WHERE memberid = 'A0615' 
                        order by auctiontime desc) Tb 
     ) 
WHERE rnum <= auctiontotal
ORDER BY bidsprice DESC;

--경매가 끝나고 [해당게시물]에서 낙찰현황을 조회하는 경우
select rownum rN, TbSec.* from (
    SELECT * FROM (
            SELECT Tb.*, rownum rNum 
            FROM (SELECT * FROM au_trans Trans
                      inner join auctioninfo AuInfo
                      on Trans.auctionid = AuInfo.auctionid
                  WHERE Trans.auctionid = 8
                  order by bidsprice desc) Tb 
                 ) 
            WHERE rnum <= auctiontotal
            ORDER BY bidsprice DESC
    ) TbSec
;
select code, status from arts;

------------------
--랜덤하게 경매중 상태를 경매 종료로 변경함
DECLARE
    total number;
BEGIN
        select count(*) into total from auctioninfo;
        
        for idx in 1 .. total loop
            
                UPDATE auctioninfo a
                    SET a.endtime = systimestamp
                WHERE ROWID IN (SELECT rid
                   FROM (SELECT ROWID rid
                              , ROW_NUMBER() OVER(ORDER BY code) rn
                           FROM auctioninfo
                         )
                  WHERE rn = round(DBMS_RANDOM.VALUE(51,1))
                );
                
    end loop;
end;
/

SELECT systimestamp - tm AS interval
     , EXTRACT(DAY    FROM systimestamp - tm) *24*60*60
     + EXTRACT(HOUR   FROM systimestamp - tm) *60*60
     + EXTRACT(MINUTE FROM systimestamp - tm) *60
     + EXTRACT(SECOND FROM systimestamp - tm) AS second
  FROM (SELECT TO_TIMESTAMP('14/01/13 17:40:33.751000000', 'yy/mm/dd hh24:mi:ss.ff') tm FROM dual)
;

-- auctioninfo 테이블에서 등록된 경매중 경매종료까지 남은 시간을 구하는 쿼리문 
SELECT systimestamp - tm AS interval
     , EXTRACT(DAY    FROM systimestamp - tm) *24*60*60
     + EXTRACT(HOUR   FROM systimestamp - tm) *60*60
     + EXTRACT(MINUTE FROM systimestamp - tm) *60
     + EXTRACT(SECOND FROM systimestamp - tm) AS second
FROM (SELECT endtime tm FROM auctioninfo);
commit;
select * from auctioninfo where code in('A0753-0018','A1214-0023','A1030-0007','A0800-0049','A0672-0508','A0337-0104','A0574-0005','A1240-0073');

--------------------------- 예치금 테이블 -----------------------------------
--예치금 테이블 생성
create table depositTb(
        idx number primary key,
        memberid varchar2(50) 
            constraints deposit_FK 
            references alouer_member (memberid),
        withdraw number default 0 not null, 
        deposit number default 0 not null,
        balance number default 0 not null,
        history varchar2(200), --변동내역(지분경매, 지분거래, 충전, 출금)
        transtime date default sysdate not null
);

--예치금 테이블 시퀀스 생성
create sequence depositTb_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    Nocache;

-- 모든회원들에게 예치금 지급 
declare
    v_memberid varchar2(50);
    v_r number;
    v_total number;
begin
    select count(*) into v_total from alouer_member;
    
    for idx1 in  1 .. v_total loop
    
        select r, memberid into v_r, v_memberid
        from (
            select rownum r, memberid 
            from alouer_member )
        where r = idx1;
        
        
        
        
         insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    0,  0, '신규', sysdate );
         insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    5000,  5000, '신규가입캐시지급이벤트', sysdate );
    end loop;
end;
/



--입출력내역이 기록된 deposittb테이블에서 선택한 맴버의 가장 마지막 거래내역의 벨런스(예치금잔고)를 조회
select balance from 
(select * from(
    (select * from deposittb) tb
    ) where memberid = 'test1@naver.com' ) 
where idx = (select max(idx) from deposittb where memberid = 'test1@naver.com');

-- 유저의 입출금 리스트를 조회
select * from (
        select rownum R, T2.* from (
                select T1.* from (
                        select * from deposittb
                        where memberid = 'test@alouer.com' 
                        order by  transtime desc
                ) T1 
        ) T2
)
where R BETWEEN 11 AND 20 ; 

-- 해당 유저의 가장 최근 잔고를 조회
select balance from 
            (select * from deposittb
            where memberid = 'test@alouer.com' ) 
where idx = (select max(idx) from deposittb where memberid = 'test@alouer.com');
select * from alouer_member where memberid='testuser@naver.com';
commit;

-- 신규회원 잔고 입력
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   'test@alouer.com',    0,    0,  0, '신규', sysdate );
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
    VALUES(depositTb_seq.NEXTVAL,   'test@alouer.com',    0,    5000,  5000, '예', sysdate );
    select * from deposittb;
-- 해당 유저의 최종 balance(잔고)에 입출금을 처리. 
INSERT INTO depositTb (idx, memberId, withdraw, deposit, balance, history)     
    VALUES(depositTb_seq.NEXTVAL,    'testuser@naver.com',    0,    150000,  
            (select balance from 
                    (select * from
                        (select * from depositTb where memberid = 'testuser@naver.com' ) 
            where idx = (select max(idx) from deposittb where memberid = 'testuser@naver.com'))) + 150000,
        '예치금입금' , sysdate) ;
--------------------------------------------------------
-- 경매아이디가 2번인 경매물에서 경매지분 수량 안의 입찰자들만 선택하여 낙찰정보 조회하는 쿼리문
select * from (
    select rownum rn,TB.* from 
        (select memberid, auctionid,code,bidsprice from au_trans 
            where auctionid = 2 
            order by bidsprice desc) TB) TRANS
    inner join auctioninfo INF 
    on TRANS.auctionid = INF.auctionid
where rn <= inf.auctiontotal ;
select rownum R , A.* from (  
        select * from arts  
) A
;
   select * from stockinfo;
   select * from au_trans order by a_transid desc;
select * from deposittb order by idx desc;
   desc stockinfo;
-- 관리자 예치금 충전
select * from deposittb where memberid = 'admin@alouer.com';
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
    VALUES(depositTb_seq.NEXTVAL,   'admin@alouer.com',    0,    50000000,  50000000, '예치금충전', sysdate );
select * from auctioninfo where auctionid= 447;
select count(*) from au_trans where auctionid = 2;

-- 마이페이지에서 참여한 모든 지분경매의 낙찰리스트를 조회
    select  rownum rNum, ATS.title, TRANS.* from (
        select rownum rn,TB.*  from 
            (select * from au_trans 
                where memberid = 'test@alouer.com' 
                order by bidsprice desc) TB) TRANS
        inner join auctioninfo INF  on TRANS.auctionid = INF.auctionid
        inner join arts ATS on ATS.code = INF.code
    where rn <= inf.auctiontotal and inf.endtime < systimestamp ;
    

--낙찰범위내의 가장 낮은 금액을 조회하는 쿼리문
select bidsprice from (
    select rownum rn,TB.* from 
        (select memberid, auctionid,code,bidsprice from au_trans 
            where auctionid = 8 order by bidsprice desc) TB) TRANS
    inner join auctioninfo INF 
    on TRANS.auctionid = INF.auctionid
where rn = inf.auctiontotal;


---------------------------------------------------------------------------
-- [종료된 경매에 대해 입찰내역중 낙찰되지 못한 입찰건에 대해 환불처리]
SET SERVEROUTPUT ON;

-- 경매아이디가 8번인 경매물에서 경매지분 수량 외 낙찰되되지 못한 입찰건들을 조회하는 쿼리문
--1. 경매수량이 5개 이므로 3000원까지가 낙찰범위에 속함
select memberid, auctionid,code,bidsprice from au_trans where auctionid = 8 order by bidsprice desc;
--2. 낙찰범위를 벗어난 입찰건들을 조회
select memberid, INF.auctionid, INF.code, bidsprice, title from (
    select rownum rn,TB.* from 
        (select T.memberid, auctionid, A.code, bidsprice, A.title from au_trans T
                     inner join arts A       on T.code = A.code
            where auctionid = 8 
            order by bidsprice desc) TB) TRANS
    inner join auctioninfo INF      on TRANS.auctionid = INF.auctionid
where rn > inf.auctiontotal 
order by bidsprice desc ;

-- 낙찰되지않은 입찰건들에 대해 환불처리
declare
    v_totalcnt number;
    v_id varchar2(50);
    v_memberid varchar2(50);
    v_bidsprice number;
    v_code varchar2(50);
    v_auctionid number;
    v_title varchar2(50);
    v_R number;
    v_balance number;
begin
    -- 입찰 실패건 갯수를 조회하여 변수 초기화
    select count(*) into v_totalcnt
    from (
        select rownum rn,TB.* from 
            (select memberid, auctionid,code,bidsprice from au_trans 
                where auctionid = 8 
                order by bidsprice desc) TB) TRANS
        inner join auctioninfo INF 
        on TRANS.auctionid = INF.auctionid -- 20행
    where rn > inf.auctiontotal ;

    -- 총 갯수만큼 반복하면서  
    for v_index in 1 .. v_totalcnt loop
        
        --  입찰레코드의 id 와 입찰가를 꺼내 변수에 저장
        select R, memberid, auctionid, code, bidsprice, title 
                into v_R, v_memberId, v_auctionid, v_code, v_bidsprice, v_title
        from (
            select rownum R, memberid, INF.auctionid, INF.code, bidsprice, title 
                  from (
                        select rownum rn,TB.* from 
                            (select T.memberid, auctionid, A.code, bidsprice, A.title from au_trans T
                                         inner join arts A       on T.code = A.code
                                where auctionid = 8 
                                order by bidsprice desc) TB) TRANS
                        inner join auctioninfo INF      on TRANS.auctionid = INF.auctionid
            where rn > inf.auctiontotal 
        ) T
        where R = v_index; -- 40행
        
        -- 해당 유저의 최종 잔고를 변수에 대입
         select balance    into v_balance
         from 
                (select * from
                        (select * from depositTb where memberid = v_memberid ) 
                 where idx = (select max(idx) from deposittb where memberid = v_memberid)
        );
        
        
        
dbms_output.put_line('v_index: '||v_index);
dbms_output.put_line('v_memberid: '||v_memberid);
dbms_output.put_line('v_bidsprice: '||v_bidsprice);
dbms_output.put_line('v_title: '||v_title);
dbms_output.put_line('v_balance: '||v_balance);
        
   
        
    
        -- 해당 유저의 최종 balance(잔고)에 환불 처리. 
        -- 이때 유저가 depositTb 테이블에 레코드가 없으면 null 에러가 남
        INSERT INTO depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    v_bidsprice,  
                    (select NVL(balance, 0) from 
                            (select * from
                                (select * from depositTb where memberid = v_memberid ) 
                    where idx = (select max(idx) from deposittb where memberid = v_memberid ))) + v_bidsprice,
                v_title||' 작품 경매 입찰건 환불' , sysdate) ;
    end loop;
end;
/
commit;
select * from deposittb where memberid = 'user1@alouer.com' order by transtime, balance desc; --환불 성공 확인
select * from deposittb where memberid = 'user2@alouer.com' order by transtime desc;
delete deposittb where idx =1043 ;
-----------------------------------------------------------------------------------------------------
-- 낙찰건들을 지분거래에 등록 & 해당경매 완료처리 **** 박성일 쿼리문이 수정본임
DECLARE 
		    v_totalcnt NUMBER;
		    v_code VARCHAR2(50);
		    v_memberid VARCHAR2(50);
		    v_auctionid NUMBER;
		    v_R NUMBER;
		    v_bidCnt number;
            v_bidsprice number;
		BEGIN -- 번째행 9
		   -- <!-- 경매의 총 옥션 수량을 만큼 stockinfo 에  등록하기위해 반복할 값 초기화 -->
		    SELECT auctiontotal , code
                   INTO v_totalcnt, v_code
		    FROM auctioninfo WHERE auctionid = 450;
		    
            
		    select count(*)
                    INTO v_bidCnt 
		    from au_trans where auctionid = 450; -- 87
		    
           
		    
		    if v_bidCnt > 0 then 
			    FOR idx IN 1 .. v_totalcnt LOOP -- 20 번째행
			           
			           -- <!-- 경매아이디가 8번인 경매물에서 경매지분 수량 안의 입찰자들만 선택하여 낙찰정보 조회 -->
			            select R, memberid,  auctionid , bidsprice
				          --  <!-- 변수 초기화시켜줌 -->
                                INTO v_R, v_memberid,  v_auctionid , v_bidsprice
			            FROM (
                                SELECT rownum R,TRANS.memberid, INF.auctionid , TRANS.bidsprice
                                FROM (
                                        SELECT rownum rn,TB.* FROM 
                                            (SELECT memberid, auctionid,bidsprice FROM au_trans -- 30번째 행
                                                    WHERE auctionid =452
                                                    ORDER BY bidsprice DESC) TB
                                        ) TRANS
                                        INNER JOIN auctioninfo INF 
                                        ON TRANS.auctionid = INF.auctionid
                                WHERE rn <= inf.auctiontotal
			            )
			            WHERE R=idx;
			            
			          --  <!-- 해당 낙찰 지분들은 지분거래( stockinfo) 테이블에 추가 -->
			            INSERT INTO stockinfo ( stockid, code, memberid, stockprice, auctionid, datelog)
			                VALUES (stockinfo_seq.NEXTVAL, v_code, v_memberid, v_bidsprice  , v_auctionid, sysdate);
			            
			    END LOOP;
		    end if;
		--    <!-- 지분거래 등록 후 경매 완료 처리  -->
		    UPDATE auctioninfo SET isfinish = 1 WHERE auctionid = 450;
		--    <!-- 지분거래 등록된 작품의 상태를 변경 -->
		    UPDATE arts SET status = '렌탈준비중' WHERE code = v_code;
		END;
/

---------------- 경매 테이블 END ------------------
commit;
-- 모든회원들에게 예치금 계좌생성 
declare
    v_memberid varchar2(50);
    v_r number;
begin
    for idx1 in  1 .. 507 loop
        select r, memberid into v_r, v_memberid
        from (
            select rownum r, memberid 
            from alouer_member )
        where r = idx1;
    
         insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    5000,  5000, '신규가입캐시지급이벤트', sysdate );
    end loop;
end;
/
------------------------------------------------------
-- 경매정보 수정
UPDATE auctionInfo  
		SET 
            code = 'A1113-0008', -- 작품코드
            startBids = 2000, -- 입찰시작가
            startTime = to_timestamp( '2020-08-01 02:31:47.411', 	'YYYY-MM-DD HH24:MI:SS.FF'), 
            endTime = to_timestamp( '2020-08-02 02:31:47.411',	'YYYY-MM-DD HH24:MI:SS.FF'), 
            auctionTotal = 10 -- 지분수량
		WHERE auctionId = 5; --경매번호
commit;
select * from au_trans where auctionid = 5;
-- 옥션 정보를 조회할때 여러번 경매 등록되어있는경우 에러가 남. 가장 최신의 경매 정보를 조회하도록 변경함
select * from (
        select rownum R, A.* from (
                SELECT * FROM auctioninfo WHERE code = 'A0753-0018' 
        ) A
        order by auctionid desc
)
where R = 1
;
-- getTotalAuctionInfo 지분경매 리스트에서 각 게시물의 경매등록 정보를 가져옴
 SELECT * FROM (
			 SELECT ROWNUM R, A.*, arts.title FROM 
			 	(SELECT * FROM auctioninfo)A 
			 		INNER JOIN arts ON A.code = arts.code
			 WHERE arts.code = ANY
                        ('A1243-1114',' Aasdlfkj',' A0093-0028',' A0111-0007',' A1137-0109',' A0729-0064',' A1196-0026',' A1197-0061') 
             ORDER BY auctionid DESC
		    ) B
;
 SELECT r, auctionid, startbids, starttime, endtime, auctiontotal, isfinish,   title  FROM (
			 SELECT ROWNUM R, A.*, arts.title FROM 
			 	(SELECT * FROM auctioninfo)A 
			 		INNER JOIN arts ON A.code = arts.code
			 WHERE arts.code = ANY
                        ('A1243-1114','Aasdlfkj','A0093-0028','A0111-0007','A1137-0109','A0729-0064','A1196-0026','A1197-0061') 
             ORDER BY auctionid DESC
		    ) B
;

--관리자> 오늘 낙찰된 경매건들의 총합 * 20% 
select sum(stockprice) from stockinfo where to_char(sysdate, 'YYYYMMDD') = to_char(datelog, 'YYYYMMDD');

select  status, count(status)  from arts group by status; 


select * from deposittb where memberid = 'admin@alouer.com';
update auctioninfo set endTime = to_timestamp( '2020-08-06 17:30:47.411',	'YYYY-MM-DD HH24:MI:SS.FF');

rollback;
-- 경매중인 작품들을 조회
	SELECT code,title,name,status,rnum FROM (
			SELECT Tb.*, rownum rNum FROM (
				SELECT * FROM
					(SELECT * FROM arts WHERE status = '지분경매' )
			) Tb
		)
		WHERE rNum BETWEEN 11 AND 20;
    -- 등록된 경매정보를 조회
    select * from (
             SELECT rownum R, B.* FROM (
                     SELECT A.*, arts.title, name FROM 
                        (SELECT * FROM auctioninfo)A 
                            inner join arts ON A.code = arts.code
                            where A.code = 'A0172-0046'
                            --where name = '이상훈'
                            order by auctionid desc
            ) B      
    )
    WHERE r BETWEEN 1 AND 10
    ; 
    select * from auctioninfo where code = 'A0665-0033';

-- 관리자메인>입찰마감 순 5개 조회 
select * from (    
    select A.*, rownum R from (        
        select * from auctioninfo INF
        inner join arts 
        on INF.code = arts.code
        where isfinish = 0 order by endtime asc 
    ) A 
)where R between 1 and 5
;      

 SELECT * FROM (
        	SELECT rownum R, B.* FROM (
           		SELECT A.*, arts.title, name FROM 
                	(SELECT * FROM auctioninfo)A 
                    	INNER JOIN arts ON A.code = arts.code
				
                    	WHERE arts.code LIKE '%'||'A1137-0109'||'%'
            
                    	ORDER BY auctionid DESC
          	) B      
	    )
	    WHERE R BETWEEN 1 AND 10;

select count(*) from (
        select * from arts where 1=1
        intersect 
        SELECT * FROM arts WHERE '(code||title||memberid||name||note1||note2||material||prodyear||sizeho||height||width||regidate||imageurl||artvalue||rentalprice||pageurl||theme||color||lat||status||lng)'
        like '%'||''||'%'
);

-- 매출 : 오늘 날짜 where 조건 걸기
--where 조건 : (SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL)

--매출 : 오늘 날짜의 경매 낙찰 건의 결제금액의 20%
select * from stockinfo where auctionid = 432;
select * from au_trans where auctionid = 432;
rollback;
update stockinfo set stockprice = 0;
desc stockinfo;
-- stockinfo 테이블에 컬럼추가 및 포린키 설정
alter table stockinfo add auctionid number not null 
    constraint stockinfo_fk 
        references auctioninfo (auctionid);
        
        
   SELECT * FROM (
		    SELECT rownum rn,TB.* FROM 
		        (SELECT memberid, auctionid,code,bidsprice FROM au_trans 
		            WHERE auctionid = 432 ORDER BY bidsprice desc) TB) TRANS
		    INNER JOIN auctionInfo INF 
		    ON TRANS.auctionid = INF.auctionid;
		--WHERE rn = INF.auctiontotal;     

SELECT rownum rn,TB.* FROM (
		        (SELECT memberid, auctionid,code,bidsprice FROM au_trans 
		            WHERE auctionid = 432 ORDER BY bidsprice desc
                ) TB
) TRANS
		    INNER JOIN auctionInfo INF 
		    ON TRANS.auctionid = INF.auctionid;

 select * from au_trans order by auctiontime desc;       
        
insert into stockinfo values 
commit;
select B.total from (
select max(dat) as dat from
    (select to_char(ordertime,'YYYYMMDD') as dat from rental_trans 
    group by to_char(ordertime,'YYYYMMDD'))
    ) A
    INNER JOIN 
    (select to_char(ordertime,'YYYYMMDD') as dat, 
    count(totalamount) total from rental_trans 
    group by to_char(ordertime,'YYYYMMDD'))B 
    ON A.dat = B.dat
;

select * from arts where (code||title||memberid||name||note1||note2||material||prodyear||sizeho||height||width||regidate||imageurl||artvalue||rentalprice||pageurl||theme||color||lat||status||lng)  like '%공간%';
select name code, title, status, theme, color, sizeho from arts where name = '정윤지';
'A123-456''A1251-0004''A1234-123'
select * from arts where name like '%정윤지%';

select * from auctioninfo where code ='A0309-0009';


 SELECT  ROWNUM roNum, ATS.title, ATS.imageurl, TRANS.*, INF.* FROM (
		    SELECT ROWNUM rn,TB.* FROM 
		        (SELECT * FROM au_trans 
		            WHERE memberid = 'test@alouer.com'
		            ORDER BY bidsprice DESC) TB) TRANS
		    INNER JOIN auctioninfo INF  ON TRANS.auctionid = INF.auctionid
        	INNER JOIN arts ATS ON ATS.code = INF.code
		WHERE rn <= inf.auctiontotal AND inf.endtime < SYSTIMESTAMP;


select * from auctioninfo;

-- 마이페이지 > 내가 낙찰된 경매내역
select D.auctionid, lot, sum, INF.code, arts.title from (
        select auctionid, count(*) lot, sum(bidsprice) sum  from
        (SELECT B.auctionid , bidsprice FROM au_trans A INNER JOIN auctioninfo B
        ON A.auctionid = B.auctionid
                            WHERE memberid = 'test@alouer.com' and B.isfinish=1
                            ORDER BY bidsprice DESC)C  group by auctionid
)D inner join auctioninfo INF on D.auctionid = INF.auctionid
inner join arts on INF.code = arts.code
                    ;
select * from arts where code = 'A1197-0061';
select * from auctioninfo;

select * from stockinfo;
select * from au_trans;
select count(*) from au_trans where memberid='test@alouer.com';

select * from auctioninfo where auctionid = 425;

select * from auctioninfo where code = 'A0665-0033';
select * from au_trans where memberid = 'test@alouer.com';



------------------ 주식 테이블 start ----------------
create table stockinfo(
                    stockid number primary key,
                    code varchar2(50) REFERENCES arts(code),
                    memberid varchar2(50) REFERENCES alouer_member(memberId) ,
                    stockprice number -- 경매 낙찰가
                    );
                    
  
-- 시퀀스 생성
create sequence stockinfo_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    Nocache;
 