CREATE TABLE SECTION
(
SecId INT NOT NULL,
SecNo INT NOT NULL,
Sem VARCHAR(10) NOT NULL,
SecYear INT NOT NULL,
Bld VARCHAR(40),
RoomNo VARCHAR(40),
DaysTime VARCHAR(40),
CourseCode VARCHAR(40) NOT NULL,
EducatorId BIGINT NOT NULL,

PRIMARY KEY (SecId)




)
