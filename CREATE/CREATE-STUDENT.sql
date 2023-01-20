CREATE TABLE `Student`
(
StudentId BIGINT NOT NULL,
DOB date,
FName Varchar(30) NOT NULL,
MNAme VARCHAR(1), 
LName VARCHAR(30) NOT NULL,
Addr varchar(60),
SPhone VARCHAR(20),
Major VARCHAR(45),
DeptCode INT,

PRIMARY KEY(StudentId),

CHECK(length(SPhone) =11)
)
