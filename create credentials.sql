select * from USER_SCHEDULER_JOB_RUN_DETAILS;
select * FROM user_scheduler_credentials;

BEGIN
  DBMS_SCHEDULER.create_credential(
    credential_name => 'externaljob',
    username        => 'externaljob',
    password        => 'YYYY-MM-DD');
END;
/
EXEC DBMS_SCHEDULER.SET_ATTRIBUTE('EVER_CREATE_NOTE', 'credential_name', 'externaljob');

exec dbms_scheduler.drop_credential('externaljob', TRUE);
/