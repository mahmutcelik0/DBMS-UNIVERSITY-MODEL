/* MANDATORY YE INSERT YAPILACAGINDA OPTIONALDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER MandatoryInsertControl BEFORE INSERT
ON MANDATORY
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT *
            FROM OPTIONALCOURSE
            WHERE NEW.MandatoryCourseCode = OPTIONALCOURSE.OptionalCourseCode
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - THIS COURSE EXISTS IN OPTIONAL COURSES TABLE';
    
    END IF;


END;
$$ DELIMITER ;

/* MANDATORY YE UPDATE YAPILACAGINDA OPTIONALDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER MandatoryUpdateControl BEFORE UPDATE
ON MANDATORY
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT *
            FROM OPTIONALCOURSE
            WHERE NEW.MandatoryCourseCode = OPTIONALCOURSE.OptionalCourseCode
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - THIS COURSE EXISTS IN OPTIONAL COURSES TABLE';

    END IF;


END;

$$ DELIMITER ;

/* OPTIONALCOUSE A INSERT YAPILACAGINDA MANDATORY DE VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER OptionalCourseInsert BEFORE INSERT
ON OPTIONALCOURSE
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT * 
            FROM MANDATORY
            WHERE NEW.OptionalCourseCode = MANDATORY.MandatoryCourseCode
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - THIS COURSE EXISTS IN MANDATORY COURSES TABLE';
    END IF;

END;

$$ DELIMITER ;

/* OPTIONALCOUSE A UPDATE YAPILACAGINDA MANDATORY DE VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER OptionalCourseUpdate BEFORE UPDATE
ON OPTIONALCOURSE
FOR EACH ROW
BEGIN
	IF
		EXISTS(
			SELECT * 
            FROM MANDATORY
            WHERE NEW.OptionalCourseCode = MANDATORY.MandatoryCourseCode
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - THIS COURSE EXISTS IN MANDATORY COURSES TABLE';
    END IF;

END;

$$ DELIMITER ;