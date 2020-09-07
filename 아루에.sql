/****************
�Ʒ翡 ������Ʈ 
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
select theme,color from arts where theme='���' or color='�Ķ�';
select theme,color from arts where theme in ('���','����') and color in ('�Ķ�','�ʷ�');
select memberid from alouer_member where memberid like '%@%';
--���̵�����
insert into alouer_member (memberid, authority, pass, name)
    values('admin', 'ROLE_ADMIN', '1234', '������');
insert into alouer_member (memberid, pass, name, hp)
    values('test@alouer.com', '1111', '����0','010-1234-1234');
insert into alouer_member (memberid, pass, name, hp)
    values('user2@alouer.com', '1111', '����2','010-1234-1234');
    insert into alouer_member (memberid, pass, name, hp)
    values('user3@alouer.com', '1111', '����3','010-1234-1234');
desc alouer_member ;
alter table alouer_member MODIFY name varchar2(20) null;

commit;
---------------------------------------------------------------------------
--��ǰ���̺�
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
--�ӽ� ������ ����
create sequence arts_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    nocache;

--���̵�����
insert into arts values(
    'A0096-002'||arts_seq.nextval, 'slumberer-13-'||arts_seq.nextval , 'test1', '�׽�Ʈ'||arts_seq.nextval, 
    '�� ���� ���Ʈ�� �̷��Ѵ�. �����ھ�� �ȴ�.',
    '�ٻ� �ϻ�, ȭ���ϰ� ���� �в� �� ��ǰ�� ��õ�ص帳�ϴ�.',
    'ĵ������ ��ä', 2015, 100, 130, 160, sysdate, 
    'https://og-data.s3.amazonaws.com/media/artworks/w_fixed/A0254/A0254-0032.jpg', 
    100000,10000, '', '����','�ʷ�'
);
select distinct status from arts;
--�⺻���� listPage ó�� �Լ����� ���ͱ���� �߰���
SELECT * FROM (
			SELECT Tb.*, rownum rNum FROM (
				SELECT * FROM arts WHERE 1=1
					AND theme = ANY( 'ǳ��','���' )
					AND color = ANY( '����','���','�Ķ�','�ʷ�' )
				ORDER BY code DESC
			) Tb
		)
		WHERE rNum BETWEEN 1 AND 999999999999999
        ;
        
-- arts �˻� ����	
SELECT count(*) FROM (
    SELECT Tb.*, rownum rNum FROM (
        SELECT theme, color,status
        FROM arts where 1=1 and theme  in('���','����')
        INTERSECT
        SELECT theme, color,status
        FROM arts where 1=1 and color in('�Ķ�','����')
        INTERSECT
        SELECT theme, color,status
        FROM arts where 1=1 and status in('��Ż����')
        
    )Tb
)
WHERE rNum BETWEEN 1 AND 10
;



-- ��Ż�� 3���� ���� ���ڵ尡 ��� �� ������ ������
desc arts;
update arts set rentalprice = 30000 where rentalprice <30000;  
select * from arts where rentalprice <300000;
     
 select code, status from arts where code = 'A0948-0008';
 commit;
select * from auctioninfo where code = 'Aasdlfkj'; 
update arts set status  = '����غ���' where code = 'A1243-1114';
select * from(
    select * from arts
    order by DBMS_RANDOM.RANDOM
) where rownum < 10;
select COUNT(*) from arts where rownum < DBMS_RANDOM.RANDOM;

update arts set status = 'rental' where rownum = 2;  -- rownum�� () ��°�� ���ڵ��� status�� rental ���� ������ �����Ѵ�

select round(DBMS_RANDOM.VALUE(1,1500)) from dual; -- 5~1������ ���� �߻�


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
-- �����ϰ� ���¸� ��Ż�������� ������
select * from auctioninfo;

DECLARE
    
BEGIN
        for idx in 1 .. 200 loop
            
                UPDATE arts a
                SET a.status = '���а��'
                WHERE ROWID IN (SELECT rid
                   FROM (SELECT ROWID rid
                              , ROW_NUMBER() OVER(ORDER BY code) rn
                           FROM arts
                         )
                  WHERE rn = round(DBMS_RANDOM.VALUE(1543,1))
                );
                dbms_output.put_line(idx||' ���� ��ǰ ���°� �����');
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


-- auctioninfo ���̺��� ��� ��ϵǾ��ִ� ��ǰ�ڵ� ���ڵ��� ���� ��ŭ 
-- arts ���̺� status '���а��' ���� ó���ϴ� PL/SQL
set SERVEROUTPUT on;
DECLARE
    code1 varchar2(50);
    total number;
BEGIN
    select count(*) into total from arts where status = '���а��';
    for idx in 1 .. total loop
    
        dbms_output.put_line(idx);  
        
        select code 
            into code1
        from (select rownum rNum, code from arts)
        where rNum = idx;
        
        dbms_output.put_line(code1);  
        
        --update arts set status = '���а��' where code = code1;
        insert into auctioninfo ()
            values();
        
    end loop;
end;
/
---------------------------------------------------------
/*rowid�� �̿��� ���� �� update �ϱ�*/
UPDATE arts a
   SET a.status = '��Ż����'
                  
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
select code,rentalprice,status from arts where status = '��Ż��' order by rentalprice ;
update arts set status = '��Ż��' where status is null;
select code from arts where code like 'A0847-0001';
update arts set code = trim(code);
select count(*) from arts where status = '��Ż����';
------------------------------------------------------------
/*******************
���̺� : auctioninfo
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
update arts set status = '��Ż��' where code =  'A0712-0162';
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
-- systimestamp -> DATE Ÿ������ ����ȯ
select CAST(SYSTIMESTAMP as DATE) from auctioninfo;
/*******************
���̺� : au_trans
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
    
-- ���̵�����
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
            VALUES(depositTb_seq.NEXTVAL,   'user1@alouer.com',    3000,    0,  43000, 'A0574-0005 ��� ����',  to_date('20200729094114', 'YYYYMMDDHH24MISS') );
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   'user1@alouer.com',    0,    50000,  54000, '��ġ�� �Ա�',  to_date('20200729094113', 'YYYYMMDDHH24MISS') );
select * from deposittb where memberid = 'user1@alouer.com';
select * from auctioninfo where auctionid = 8;



-- ��Ż󼼺��� ���������� �������ݺ� ���� ������ ǥ����
select bidsprice,  count(bidsprice) lot from 
        (select * from au_trans where auctionid = 2) 
group by bidsprice 
order by bidsprice desc;

 select status from arts where ;



-- ��� ���� ��Ȳ�� �ð������� ��ȸ
select rownum rN, TbSec.* from
    (SELECT * FROM (
                SELECT Tb.*, rownum rNum FROM 
                    (SELECT * FROM au_trans) Tb 
                where auctionid = 8 
            ) 
    WHERE rNum BETWEEN 1 AND 10
    order by auctiontime desc) TbSec
;
-- ����¡�� rownum �� ����
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
-- ��� ���� ��� 1�ִ� ���� insert�� �����Ͽ� ���ڵ带 ����ϴ� ���ν���
-- �Ʒ��� ȸ�����̵�:'A0006' �� 3�ָ� 1500���� �����ϴ°�� 
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
--��� ���
insert into auctioninfo values(
    auctioninfo_seq.nextval, 
    'A0847-0001', 
    5000, 
    SYSTIMESTAMP,
    to_timestamp('20200814152301123', 'YYYYMMDDHH24MISSFF'),
    1000
);
----------------------------------------------------
-- arts���̺��� ���а�� ������ ���ڵ��� ������ŭ auctioninfo���̺� ��� ���ó���ϴ� PL/SQL
--0�ܰ�
select count(*) from arts where status = '���а��';
--1�ܰ�
select rownum,code,status from arts where status = '���а��' ;
--2�ܰ�
select code,status 
from (select rownum rNum, code,status from arts where status ='���а��')
where rNum = 51;

select count(*) from arts where status ='���а��'; -- 51
select * from auctioninfo;
set SERVEROUTPUT on;

DECLARE
    code1 varchar2(50);
    total number;
BEGIN
    select count(*) into total from arts where status ='���а��';
    for idx in 1 .. total loop
    
        dbms_output.put_line(idx);  
        
        select code 
            into code1
        from (select rownum rNum, code from arts where status ='���а��')
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
 values (DEPOSITTB_SEQ.nextval,'test@alouer.com',0,1000000,1003000,'��ġ���Ա�',systimestamp);
commit;
select * from alouer_member where memberid like '%@%';
--------------------------------------------------------------
--��Ű� ������ [����������]���� ������Ȳ�� ��ȸ�ϴ� ���
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

--��Ű� ������ [�ش�Խù�]���� ������Ȳ�� ��ȸ�ϴ� ���
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
--�����ϰ� ����� ���¸� ��� ����� ������
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

-- auctioninfo ���̺��� ��ϵ� ����� ���������� ���� �ð��� ���ϴ� ������ 
SELECT systimestamp - tm AS interval
     , EXTRACT(DAY    FROM systimestamp - tm) *24*60*60
     + EXTRACT(HOUR   FROM systimestamp - tm) *60*60
     + EXTRACT(MINUTE FROM systimestamp - tm) *60
     + EXTRACT(SECOND FROM systimestamp - tm) AS second
FROM (SELECT endtime tm FROM auctioninfo);
commit;
select * from auctioninfo where code in('A0753-0018','A1214-0023','A1030-0007','A0800-0049','A0672-0508','A0337-0104','A0574-0005','A1240-0073');

--------------------------- ��ġ�� ���̺� -----------------------------------
--��ġ�� ���̺� ����
create table depositTb(
        idx number primary key,
        memberid varchar2(50) 
            constraints deposit_FK 
            references alouer_member (memberid),
        withdraw number default 0 not null, 
        deposit number default 0 not null,
        balance number default 0 not null,
        history varchar2(200), --��������(���а��, ���аŷ�, ����, ���)
        transtime date default sysdate not null
);

--��ġ�� ���̺� ������ ����
create sequence depositTb_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    Nocache;

-- ���ȸ���鿡�� ��ġ�� ���� 
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
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    0,  0, '�ű�', sysdate );
         insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    5000,  5000, '�ű԰���ĳ�������̺�Ʈ', sysdate );
    end loop;
end;
/



--����³����� ��ϵ� deposittb���̺��� ������ �ɹ��� ���� ������ �ŷ������� ������(��ġ���ܰ�)�� ��ȸ
select balance from 
(select * from(
    (select * from deposittb) tb
    ) where memberid = 'test1@naver.com' ) 
where idx = (select max(idx) from deposittb where memberid = 'test1@naver.com');

-- ������ ����� ����Ʈ�� ��ȸ
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

-- �ش� ������ ���� �ֱ� �ܰ� ��ȸ
select balance from 
            (select * from deposittb
            where memberid = 'test@alouer.com' ) 
where idx = (select max(idx) from deposittb where memberid = 'test@alouer.com');
select * from alouer_member where memberid='testuser@naver.com';
commit;

-- �ű�ȸ�� �ܰ� �Է�
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   'test@alouer.com',    0,    0,  0, '�ű�', sysdate );
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
    VALUES(depositTb_seq.NEXTVAL,   'test@alouer.com',    0,    5000,  5000, '��', sysdate );
    select * from deposittb;
-- �ش� ������ ���� balance(�ܰ�)�� ������� ó��. 
INSERT INTO depositTb (idx, memberId, withdraw, deposit, balance, history)     
    VALUES(depositTb_seq.NEXTVAL,    'testuser@naver.com',    0,    150000,  
            (select balance from 
                    (select * from
                        (select * from depositTb where memberid = 'testuser@naver.com' ) 
            where idx = (select max(idx) from deposittb where memberid = 'testuser@naver.com'))) + 150000,
        '��ġ���Ա�' , sysdate) ;
--------------------------------------------------------
-- ��ž��̵� 2���� ��Ź����� ������� ���� ���� �����ڵ鸸 �����Ͽ� �������� ��ȸ�ϴ� ������
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
-- ������ ��ġ�� ����
select * from deposittb where memberid = 'admin@alouer.com';
insert into depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
    VALUES(depositTb_seq.NEXTVAL,   'admin@alouer.com',    0,    50000000,  50000000, '��ġ������', sysdate );
select * from auctioninfo where auctionid= 447;
select count(*) from au_trans where auctionid = 2;

-- �������������� ������ ��� ���а���� ��������Ʈ�� ��ȸ
    select  rownum rNum, ATS.title, TRANS.* from (
        select rownum rn,TB.*  from 
            (select * from au_trans 
                where memberid = 'test@alouer.com' 
                order by bidsprice desc) TB) TRANS
        inner join auctioninfo INF  on TRANS.auctionid = INF.auctionid
        inner join arts ATS on ATS.code = INF.code
    where rn <= inf.auctiontotal and inf.endtime < systimestamp ;
    

--������������ ���� ���� �ݾ��� ��ȸ�ϴ� ������
select bidsprice from (
    select rownum rn,TB.* from 
        (select memberid, auctionid,code,bidsprice from au_trans 
            where auctionid = 8 order by bidsprice desc) TB) TRANS
    inner join auctioninfo INF 
    on TRANS.auctionid = INF.auctionid
where rn = inf.auctiontotal;


---------------------------------------------------------------------------
-- [����� ��ſ� ���� ���������� �������� ���� �����ǿ� ���� ȯ��ó��]
SET SERVEROUTPUT ON;

-- ��ž��̵� 8���� ��Ź����� ������� ���� �� �����ǵ��� ���� �����ǵ��� ��ȸ�ϴ� ������
--1. ��ż����� 5�� �̹Ƿ� 3000�������� ���������� ����
select memberid, auctionid,code,bidsprice from au_trans where auctionid = 8 order by bidsprice desc;
--2. ���������� ��� �����ǵ��� ��ȸ
select memberid, INF.auctionid, INF.code, bidsprice, title from (
    select rownum rn,TB.* from 
        (select T.memberid, auctionid, A.code, bidsprice, A.title from au_trans T
                     inner join arts A       on T.code = A.code
            where auctionid = 8 
            order by bidsprice desc) TB) TRANS
    inner join auctioninfo INF      on TRANS.auctionid = INF.auctionid
where rn > inf.auctiontotal 
order by bidsprice desc ;

-- ������������ �����ǵ鿡 ���� ȯ��ó��
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
    -- ���� ���а� ������ ��ȸ�Ͽ� ���� �ʱ�ȭ
    select count(*) into v_totalcnt
    from (
        select rownum rn,TB.* from 
            (select memberid, auctionid,code,bidsprice from au_trans 
                where auctionid = 8 
                order by bidsprice desc) TB) TRANS
        inner join auctioninfo INF 
        on TRANS.auctionid = INF.auctionid -- 20��
    where rn > inf.auctiontotal ;

    -- �� ������ŭ �ݺ��ϸ鼭  
    for v_index in 1 .. v_totalcnt loop
        
        --  �������ڵ��� id �� �������� ���� ������ ����
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
        where R = v_index; -- 40��
        
        -- �ش� ������ ���� �ܰ� ������ ����
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
        
   
        
    
        -- �ش� ������ ���� balance(�ܰ�)�� ȯ�� ó��. 
        -- �̶� ������ depositTb ���̺� ���ڵ尡 ������ null ������ ��
        INSERT INTO depositTb (idx, memberId, withdraw, deposit, balance, history, transtime)     
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    v_bidsprice,  
                    (select NVL(balance, 0) from 
                            (select * from
                                (select * from depositTb where memberid = v_memberid ) 
                    where idx = (select max(idx) from deposittb where memberid = v_memberid ))) + v_bidsprice,
                v_title||' ��ǰ ��� ������ ȯ��' , sysdate) ;
    end loop;
end;
/
commit;
select * from deposittb where memberid = 'user1@alouer.com' order by transtime, balance desc; --ȯ�� ���� Ȯ��
select * from deposittb where memberid = 'user2@alouer.com' order by transtime desc;
delete deposittb where idx =1043 ;
-----------------------------------------------------------------------------------------------------
-- �����ǵ��� ���аŷ��� ��� & �ش��� �Ϸ�ó�� **** �ڼ��� �������� ��������
DECLARE 
		    v_totalcnt NUMBER;
		    v_code VARCHAR2(50);
		    v_memberid VARCHAR2(50);
		    v_auctionid NUMBER;
		    v_R NUMBER;
		    v_bidCnt number;
            v_bidsprice number;
		BEGIN -- ��°�� 9
		   -- <!-- ����� �� ���� ������ ��ŭ stockinfo ��  ����ϱ����� �ݺ��� �� �ʱ�ȭ -->
		    SELECT auctiontotal , code
                   INTO v_totalcnt, v_code
		    FROM auctioninfo WHERE auctionid = 450;
		    
            
		    select count(*)
                    INTO v_bidCnt 
		    from au_trans where auctionid = 450; -- 87
		    
           
		    
		    if v_bidCnt > 0 then 
			    FOR idx IN 1 .. v_totalcnt LOOP -- 20 ��°��
			           
			           -- <!-- ��ž��̵� 8���� ��Ź����� ������� ���� ���� �����ڵ鸸 �����Ͽ� �������� ��ȸ -->
			            select R, memberid,  auctionid , bidsprice
				          --  <!-- ���� �ʱ�ȭ������ -->
                                INTO v_R, v_memberid,  v_auctionid , v_bidsprice
			            FROM (
                                SELECT rownum R,TRANS.memberid, INF.auctionid , TRANS.bidsprice
                                FROM (
                                        SELECT rownum rn,TB.* FROM 
                                            (SELECT memberid, auctionid,bidsprice FROM au_trans -- 30��° ��
                                                    WHERE auctionid =452
                                                    ORDER BY bidsprice DESC) TB
                                        ) TRANS
                                        INNER JOIN auctioninfo INF 
                                        ON TRANS.auctionid = INF.auctionid
                                WHERE rn <= inf.auctiontotal
			            )
			            WHERE R=idx;
			            
			          --  <!-- �ش� ���� ���е��� ���аŷ�( stockinfo) ���̺� �߰� -->
			            INSERT INTO stockinfo ( stockid, code, memberid, stockprice, auctionid, datelog)
			                VALUES (stockinfo_seq.NEXTVAL, v_code, v_memberid, v_bidsprice  , v_auctionid, sysdate);
			            
			    END LOOP;
		    end if;
		--    <!-- ���аŷ� ��� �� ��� �Ϸ� ó��  -->
		    UPDATE auctioninfo SET isfinish = 1 WHERE auctionid = 450;
		--    <!-- ���аŷ� ��ϵ� ��ǰ�� ���¸� ���� -->
		    UPDATE arts SET status = '��Ż�غ���' WHERE code = v_code;
		END;
/

---------------- ��� ���̺� END ------------------
commit;
-- ���ȸ���鿡�� ��ġ�� ���»��� 
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
            VALUES(depositTb_seq.NEXTVAL,   v_memberid,    0,    5000,  5000, '�ű԰���ĳ�������̺�Ʈ', sysdate );
    end loop;
end;
/
------------------------------------------------------
-- ������� ����
UPDATE auctionInfo  
		SET 
            code = 'A1113-0008', -- ��ǰ�ڵ�
            startBids = 2000, -- �������۰�
            startTime = to_timestamp( '2020-08-01 02:31:47.411', 	'YYYY-MM-DD HH24:MI:SS.FF'), 
            endTime = to_timestamp( '2020-08-02 02:31:47.411',	'YYYY-MM-DD HH24:MI:SS.FF'), 
            auctionTotal = 10 -- ���м���
		WHERE auctionId = 5; --��Ź�ȣ
commit;
select * from au_trans where auctionid = 5;
-- ���� ������ ��ȸ�Ҷ� ������ ��� ��ϵǾ��ִ°�� ������ ��. ���� �ֽ��� ��� ������ ��ȸ�ϵ��� ������
select * from (
        select rownum R, A.* from (
                SELECT * FROM auctioninfo WHERE code = 'A0753-0018' 
        ) A
        order by auctionid desc
)
where R = 1
;
-- getTotalAuctionInfo ���а�� ����Ʈ���� �� �Խù��� ��ŵ�� ������ ������
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

--������> ���� ������ ��Űǵ��� ���� * 20% 
select sum(stockprice) from stockinfo where to_char(sysdate, 'YYYYMMDD') = to_char(datelog, 'YYYYMMDD');

select  status, count(status)  from arts group by status; 


select * from deposittb where memberid = 'admin@alouer.com';
update auctioninfo set endTime = to_timestamp( '2020-08-06 17:30:47.411',	'YYYY-MM-DD HH24:MI:SS.FF');

rollback;
-- ������� ��ǰ���� ��ȸ
	SELECT code,title,name,status,rnum FROM (
			SELECT Tb.*, rownum rNum FROM (
				SELECT * FROM
					(SELECT * FROM arts WHERE status = '���а��' )
			) Tb
		)
		WHERE rNum BETWEEN 11 AND 20;
    -- ��ϵ� ��������� ��ȸ
    select * from (
             SELECT rownum R, B.* FROM (
                     SELECT A.*, arts.title, name FROM 
                        (SELECT * FROM auctioninfo)A 
                            inner join arts ON A.code = arts.code
                            where A.code = 'A0172-0046'
                            --where name = '�̻���'
                            order by auctionid desc
            ) B      
    )
    WHERE r BETWEEN 1 AND 10
    ; 
    select * from auctioninfo where code = 'A0665-0033';

-- �����ڸ���>�������� �� 5�� ��ȸ 
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

-- ���� : ���� ��¥ where ���� �ɱ�
--where ���� : (SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL)

--���� : ���� ��¥�� ��� ���� ���� �����ݾ��� 20%
select * from stockinfo where auctionid = 432;
select * from au_trans where auctionid = 432;
rollback;
update stockinfo set stockprice = 0;
desc stockinfo;
-- stockinfo ���̺� �÷��߰� �� ����Ű ����
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

select * from arts where (code||title||memberid||name||note1||note2||material||prodyear||sizeho||height||width||regidate||imageurl||artvalue||rentalprice||pageurl||theme||color||lat||status||lng)  like '%����%';
select name code, title, status, theme, color, sizeho from arts where name = '������';
'A123-456''A1251-0004''A1234-123'
select * from arts where name like '%������%';

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

-- ���������� > ���� ������ ��ų���
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



------------------ �ֽ� ���̺� start ----------------
create table stockinfo(
                    stockid number primary key,
                    code varchar2(50) REFERENCES arts(code),
                    memberid varchar2(50) REFERENCES alouer_member(memberId) ,
                    stockprice number -- ��� ������
                    );
                    
  
-- ������ ����
create sequence stockinfo_seq
    increment by 1
    start with 1
    nomaxvalue
    minvalue 1
    nocycle
    Nocache;
 