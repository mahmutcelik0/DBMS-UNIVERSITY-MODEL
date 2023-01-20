CREATE TABLE RESEARCH_ASSISTANT
(
ResearchAsstFMId BIGINT NOT NULL,
ReserachAsstStudentId BIGINT NOT NULL,
RAAttribute VARCHAR(40),
ProfId BIGINT,

PRIMARY KEY(ResearchAsstFMId,ResearchAsstStudentId),
UNIQUE(ResearchAsstFMId),
UNIQUE(ReserachAsstStudentId)
)