CREATE TABLE EDUCATOR
(
EducatorId BIGINT NOT NULL,
TalkSpeed INT,

PRIMARY KEY(EducatorId),

CHECK(TalkSpeed>0 AND TalkSpeed <=100)
)