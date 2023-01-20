/* YENI EKLECEK DEPT IN CHAIR START DATE I GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER ChairStartDateControl BEFORE INSERT
ON DEPT
FOR EACH ROW
BEGIN
	IF
		NEW.CStartDate > curdate()
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
	END IF;
END;
$$ DELIMITER ;

/* UPDATE EDILECEK DEPT IN CHAIR START DATE I GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER ChairStartDateControlUpdate BEFORE UPDATE
ON DEPT
FOR EACH ROW
BEGIN
	IF
		NEW.CStartDate > curdate()
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
    END IF;

END;
$$ DELIMITER ;

/* YENI EKLECEK STUDENT IN DOB U GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER StudentDOB BEFORE INSERT
ON STUDENT
FOR EACH ROW
BEGIN
	IF
		NEW.DOB > curdate()
	THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
    END IF;
END
$$ DELIMITER ;

/* UPDATE EDILECEK STUDENT IN DOB U GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER StudentDOBUpdate BEFORE UPDATE
ON STUDENT
FOR EACH ROW
BEGIN
	IF
		NEW.DOB > curdate()
	THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
    END IF;
END
$$ DELIMITER ;

/* INSERT EDILECEK SECTION IN SecYear I GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER SecYear BEFORE INSERT
ON SECTION
FOR EACH ROW
BEGIN
	IF
		NEW.SecYear > year(curdate())
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
    END IF;
END;
$$ DELIMITER ;

/* UPDATE EDILECEK SECTION IN SecYear I GUNUMUZUN TARIHINDEN BUYUKSE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER SecYearUpdate BEFORE UPDATE
ON SECTION
FOR EACH ROW
BEGIN
	IF
		NEW.SecYear > year(curdate())
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'ENTER PAST DATE';
    END IF;
END;
$$ DELIMITER ;