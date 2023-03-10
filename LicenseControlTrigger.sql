DELIMITER $$
CREATE TRIGGER LICENSEORNOT BEFORE INSERT
ON SECTION
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT *
			FROM COURSE,EDUCATOR,INSTRUCTOR
            WHERE NEW.CourseCode = COURSE.CCode AND NEW.EducatorId = EDUCATOR.EducatorId AND INSTRUCTOR.InstructorId = EDUCATOR.EducatorId AND COURSE.LicenseOrNot = 0
        )
        
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - INSTRUCTOR CAN NOT GIVE GRADUATE COURSE';
    END IF;
END
$$ DELIMITER ;


DELIMITER $$
CREATE TRIGGER LICENSEORNOTUpdate BEFORE UPDATE
ON SECTION
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT *
			FROM COURSE,EDUCATOR,INSTRUCTOR
            WHERE NEW.CourseCode = COURSE.CCode AND NEW.EducatorId = EDUCATOR.EducatorId AND INSTRUCTOR.InstructorId = EDUCATOR.EducatorId AND COURSE.LicenseOrNot = 0
        )
        
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - INSTRUCTOR CAN NOT GIVE GRADUATE COURSE';
    END IF;
END
$$ DELIMITER ;
