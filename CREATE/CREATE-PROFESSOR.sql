CREATE TABLE PROFESSOR
(
ProfessorId BIGINT NOT NULL,
NofMentoredStudent INT,

CHECK(NofMentoredStudent >= 0),

PRIMARY KEY(ProfessorId)
)