
DELIMITER $$
CREATE TRIGGER `ISENGLISHINSERT` BEFORE INSERT ON `include` FOR EACH ROW BEGIN
	IF
		exists
		(SELECT *
        FROM COURSE AS C, CURRICULUM AS CUR
        WHERE NEW.CourseCode = C.CCode
        AND NEW.CurriculumId = CUR.CurId
        AND ((CUR.EnglishPercent = '%100' AND C.IsEnglish = 0)
        OR (CUR.EnglishPercent = '%0' AND C.IsEnglish = 1))
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'INSERT WARNING - ENGLISH PERCENTS DOESNT MATCH';
    END IF;
END

$$ DELIMITER ;


DELIMITER $$
CREATE TRIGGER `ISENGLISHUPDATE` BEFORE UPDATE ON `include` FOR EACH ROW BEGIN
	IF
		exists
		(SELECT *
        FROM COURSE AS C, CURRICULUM AS CUR
        WHERE NEW.CourseCode = C.CCode
        AND NEW.CurriculumId = CUR.CurId
        AND ((CUR.EnglishPercent = '%100' AND C.IsEnglish = 0)
        OR (CUR.EnglishPercent = '%0' AND C.IsEnglish = 1))
        )
    THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'UPDATE WARNING - ENGLISH PERCENTS DOESNT MATCH';
    END IF;
END

$$ DELIMITER ;