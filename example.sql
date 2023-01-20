SELECT COURSE.`CCode` AS 'CourseCode', FACULTY_MEMBER.`FMId` AS 'FacultyMemberId' , count(*)
FROM INCLUDE,COURSE,CURRICULUM,DEPT,FACULTY_MEMBER,KEYWORDS,RESEARCH_AREA
WHERE INCLUDE.`CourseCode` = COURSE.`CCode` AND
    COURSE.`CCode` = KEYWORDS.`CourseCode` AND
    INCLUDE.`CurriculumId` = CURRICULUM.`CurId` AND
    CURRICULUM.`DCode` = DEPT.`DCode` AND
    DEPT.`Dcode` = FACULTY_MEMBER.`DeptCode` AND 
    FACULTY_MEMBER.`FMId` = RESEARCH_AREA.`FMId` AND
	Keyword = ResearchArea 
GROUP BY CCode,FACULTY_MEMBER.`FMId`
ORDER BY COURSE.`CCode`
