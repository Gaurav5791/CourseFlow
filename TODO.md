# CourseFlow PostgreSQL Database Switch - TODO

## Plan Steps (Approved)
1. [ ] Verify/Run PostgreSQL setup (DB courseflow_db, schema.sql, sample-data.sql)
2. [x] Edit application.properties: Switch H2 → PostgreSQL config
3. [x] Edit application-h2.properties: Uncomment PostgreSQL section
4. [x] Restart server: cd courseflow-backend && mvn clean spring-boot:run (failed - PostgreSQL not available)
5. [ ] Test: http://localhost:8080/api/courses shows JSON data (not empty)
6. [ ] Verify logs: PostgreSQL connection, no H2 console
7. [ ] [COMPLETE] 

**Next:** User: Ensure PostgreSQL running on localhost:5432, create DB, run schema + sample-data.
