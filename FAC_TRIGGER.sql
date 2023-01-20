
/* EDUCATOR INSERT TRIGGER*/
/* EDUCATOR A EKLENECEK YENI ID RESEARCH ASSISTANT TA EXISTS ISE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EducatorTrig BEFORE INSERT
ON `EDUCATOR`
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM RESEARCH_ASSISTANT
        WHERE `RESEARCH_ASSISTANT`.`ResearchAsstFMId` = NEW.`EducatorId`
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - EDUCATOR EXISTS IN RESEARCH ASSISTANT TABLE';
    END IF;
END
$$ DELIMITER ;



/* RESEARCH ASSISTANT INSERT TRIGGER*/
/* RESEARCH ASSISTANT A EKLEME YAPILACAGINDA EDUCATORDA EXISTS ISE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER ResearchAssistantTrig BEFORE INSERT
ON `RESEARCH_ASSISTANT`
FOR EACH ROW
BEGIN
	IF
		EXISTS(
        SELECT *
        FROM EDUCATOR
        WHERE `EDUCATOR`.`EducatorId` = NEW.`ResearchAsstFMId`
        )
    THEN SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - RESEARCH ASSISTANT EXISTS IN EDUCATOR TABLE';
    END IF;
END

$$  DELIMITER ;


/* EDUCATOR UPDATE TRIGGER*/
/* EDUCATOR UPDATE EDILECEGINDE YENI EDUCATOR ID RESEARCH ASSISTANT ID LERINDE EXISTS ISE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EducatorUpdateTrig BEFORE UPDATE
ON `EDUCATOR`
FOR EACH ROW
BEGIN
	IF
     EXISTS(
		SELECT *
        FROM RESEARCH_ASSISTANT
        WHERE `RESEARCH_ASSISTANT`.`ResearchAsstFMId` = NEW.`EducatorId`
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - EDUCATOR EXISTS IN RESEARCH ASSISTANT TABLE';
    END IF;
END
$$ DELIMITER ;


/* RESEARCH ASSISTANT UPDATE TRIGGER*/
/* RESEARCH ASSISTANT A GUNCELLEME YAPILACAGINDA YENI ID EDUCATOR ID ICERISINDE EXISTS ISE HATA VERIR*/
DELIMITER $$
CREATE TRIGGER ResearchAssistantUpdateTrig BEFORE UPDATE
ON `RESEARCH_ASSISTANT`
FOR EACH ROW
BEGIN
	IF
		EXISTS(
        SELECT *
        FROM EDUCATOR
        WHERE `EDUCATOR`.`EducatorId` = NEW.`ResearchAsstFMId`
        )
    THEN SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - RESEARCH ASSISTANT EXISTS IN EDUCATOR TABLE';
    END IF;
END

$$  DELIMITER ;


/* Professor Insert TRIGGER*/
/* PROFESSOR EKLEYECEGIMIZE ASSISTANT_PROF ASSOCIATE_PROF VEYA INSTRUCTOR ICINDE VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerPROFTrig BEFORE INSERT
ON `PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`ProfessorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`ProfessorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`ProfessorId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - PROF EXIST IN ANOTHER EER TABLES';
    END IF;
END 
$$ DELIMITER ;

/* AssociateProf Insert TRIGGER*/
/* ASSOCIATE PROFESSOR E EKLENECEGINDE PROFESSOR ASSISTANT PROFESSOR VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerAsscProfTrig BEFORE INSERT
ON `ASSOCIATE_PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`AssociateProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`AssociateProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`AssociateProfId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - ASSOCIATE PROFESSOR EXIST IN ANOTHER EER TABLES';
    END IF;
END 
$$ DELIMITER ;

/* AssistantProf Insert TRIGGER*/
/* ASSISTANT PROFFESSOR E EKLEME YAPACAGIMIZDA PROF ASST PROF VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerAsstProfTrig BEFORE INSERT
ON `ASSISTANT_PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`AssistantProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`AssistantProfId`
            )
            OR EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`AssistantProfId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - ASSISTANT PROFESSOR EXIST IN ANOTHER EER TABLES';
    END IF;
END 

$$ DELIMITER ;



/*Instructor Insert TRIGGER*/
/* INSTRUCTOR EKLENECEGINDE PROF ASSC PROF VEYA ASST PROFTA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER InstructorTrig BEFORE INSERT 
ON `INSTRUCTOR`
FOR EACH ROW
BEGIN
	IF EXISTS
        (
        SELECT *
        WHERE
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`InstructorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`InstructorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`InstructorId`
            )
        )
	THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - INSTRUCTOR EXIST IN ANOTHER EER TABLES';
	END IF;
END
$$ DELIMITER ;


/* PROFESSOR Update TRIGGER*/
/* PROFESSOR U UPDATE LEYECEGIMIZDE YENI DEGER ASSC PROF ASST PROF VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerPROFUpdateTrig BEFORE UPDATE
ON `PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`ProfessorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`ProfessorId`
            )
             OR
            EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`ProfessorId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - PROFESSOR EXIST IN ANOTHER EER TABLES';
    END IF;
END 
$$ DELIMITER ;

/* AssociateProf Update TRIGGER*/
/* ASSC PROF U UPDATELERKEN YENI DEGER PROF ASST PROF VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerAsscProfUpdateTrig BEFORE UPDATE
ON `ASSOCIATE_PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`AssociateProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`AssociateProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`AssociateProfId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - ASSOCIATE PROFESSOR EXIST IN ANOTHER EER TABLES';
    END IF;
END 
$$ DELIMITER ;

/* AssistantProf Insert TRIGGER*/
/* ASSISTANT PROF U UPDATE LERKEN YENI DEGER PROF ASSC PROF VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER EerAsstProfUpdateTrig BEFORE UPDATE
ON `ASSISTANT_PROFESSOR`
FOR EACH ROW
BEGIN
	IF EXISTS(
		SELECT *
        WHERE 
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`AssistantProfId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`AssistantProfId`
            )
            OR EXISTS
            (
				SELECT *
                FROM `INSTRUCTOR`
                WHERE `InstructorId` = NEW.`AssistantProfId`
            )
    )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - ASSISTANT PROFESSOR EXIST IN ANOTHER EER TABLES';
    END IF;
END 

$$ DELIMITER ;

/*Instructor UPDATE TRIGGER*/
/* INSTRUCTOR U UPDATE EDERKEN YENI DEGER PROF ASSC PROF VEYA INSTRUCTORDA VARSA HATA VERIR*/
DELIMITER $$
CREATE TRIGGER InstructorUpdateTrig BEFORE UPDATE 
ON `INSTRUCTOR`
FOR EACH ROW
BEGIN
	IF EXISTS
        (
        SELECT *
        WHERE
			EXISTS
            (
				SELECT *
                FROM `PROFESSOR`
                WHERE `ProfessorId` = NEW.`InstructorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSOCIATE_PROFESSOR`
                WHERE `AssociateProfId` = NEW.`InstructorId`
            )
            OR
            EXISTS
            (
				SELECT *
                FROM `ASSISTANT_PROFESSOR`
                WHERE `AssistantProfId` = NEW.`InstructorId`
            )
        )
	THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - INSTRUCTOR EXIST IN ANOTHER EER TABLES';
	END IF;
END
$$ DELIMITER ;
