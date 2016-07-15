create user YUNPAN identified by RichardIIIDNAdecoded;
grant connect, resource to YUNPAN;

grant execute on UTL_HTTP to YUNPAN;
grant execute on UTL_FILE to YUNPAN;
grant execute on JSON to YUNPAN;

grant CREATE JOB to YUNPAN;
--grant CREATE EXTERNAL JOB to EVERNOTE;