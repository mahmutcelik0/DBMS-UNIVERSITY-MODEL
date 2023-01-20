
DELIMITER $$
CREATE FUNCTION rateCalculator
(
	 MatchCount INT,
    AttCourseCode VARCHAR(40)
)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE Percent FLOAT;
    DECLARE CourseKeywordCount INT;
    
    SET Percent = (MatchCount/ (
								SELECT  count(*)
								FROM COURSE,KEYWORDS
								WHERE COURSE.`CCode` = KEYWORDS.`CourseCode` AND KEYWORDS.`CourseCode` = AttCourseCode
								GROUP BY CourseCode)
                                ) * 100;
    
    RETURN Percent;
END $$
DELIMITER ;

DROP FUNCTION rateCalculator