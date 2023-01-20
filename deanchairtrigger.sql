DELIMITER $$
CREATE TRIGGER ISCHAIR BEFORE INSERT
ON COLLEGE
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM DEPT
        WHERE NEW.DeanId = DEPT.ChairId
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - CHAIR CAN NOT BE DEAN AT THE SAME TIME';
    END IF;
END
$$ DELIMITER 

DELIMITER $$
CREATE TRIGGER ISDEAN BEFORE INSERT
ON DEPT
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM COLLEGE
        WHERE NEW.ChairId = COLLEGE.DeanId
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - DEAN CAN NOT BE CHAIR THE SAME TIME';
    END IF;
END
$$ DELIMITER ;


DELIMITER $$
CREATE TRIGGER ISCHAIRUpdate BEFORE UPDATE
ON COLLEGE
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM DEPT
        WHERE NEW.DeanId = DEPT.ChairId
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - CHAIR CAN NOT BE DEAN AT THE SAME TIME';
    END IF;
END
$$ DELIMITER 

DELIMITER $$
CREATE TRIGGER ISDEANUpdate BEFORE UPDATE
ON DEPT
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM COLLEGE
        WHERE NEW.ChairId = COLLEGE.DeanId
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - DEAN CAN NOT BE CHAIR THE SAME TIME';
    END IF;
END
$$ DELIMITER ;










