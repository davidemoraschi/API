create user evernote identified by eventatRosaKhutorExtreme;
grant connect, resource to evernote;

grant execute on UTL_HTTP to EVERNOTE;
grant execute on UTL_FILE to EVERNOTE;

grant CREATE JOB to EVERNOTE;
grant CREATE EXTERNAL JOB to EVERNOTE;

grant create view to evernote;