CREATE TABLE CURRICULUM
(
CurId INT NOT NULL,
EnglishPercent VARCHAR(4) NOT NULL,
DCode INT NOT NULL,

PRIMARY KEY(CurId),

CHECK(`EnglishPercent` = "%0" OR `EnglishPercent` = "%30" OR `EnglishPercent` = "%100")

)