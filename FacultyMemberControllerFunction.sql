
DELIMITER $$
CREATE FUNCTION FacultyMemberController
(
FMId INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN

		DECLARE count INT;
        SET count = 
        (
        SELECT count(*)
        FROM FACULTY_MEMBER 
        WHERE 
			EXISTS(SELECT * FROM RESEARCH_ASSISTANT WHERE ResearchAsstFMId = FMId)
            OR
			EXISTS(SELECT * FROM EDUCATOR WHERE EducatorId = FMId)
            AND
				(
				EXISTS(SELECT * FROM PROFESSOR WHERE ProfessorId = FMId)
				OR
				EXISTS(SELECT * FROM ASSOCIATE_PROFESSOR WHERE AssociateProfId = FMId)
				OR
				EXISTS(SELECT * FROM ASSISTANT_PROFESSOR WHERE AssistantProfId = FMId)
				OR
				EXISTS(SELECT * FROM INSTRUCTOR WHERE InstructorId = FMId)
				)
        );
		
        RETURN count !=0;

END $$
DELIMITER ;

