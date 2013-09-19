 select inst_id,sid,serial#, a.username, a.logon_time, a.status, a.terminal, a.machine from gv$session a ;
 
select * from gv$session a ;
 
select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   dba_objects c
   where
   b.sid = a.session_id
   and
   a.object_id = c.object_id;
   
   ALTER SYSTEM KILL SESSION '21,7650';
   



