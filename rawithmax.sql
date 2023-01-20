CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `MAHMUT`@`%` 
    SQL SECURITY DEFINER
VIEW `rawithmax` AS
    SELECT 
        `firstview`.`CourseCode` AS `CourseCode`,
        `firstview`.`FacultyMemberId` AS `FacultyMemberId`,
        `firstview`.`DCode` AS `DCode`,
        `firstview`.`EducatorId` AS `EducatorId`,
        `firstview`.`CurriculumId` AS `CurriculumId`,
        `firstview`.`MATCH_PERCENT` AS `MATCH_PERCENT`
    FROM
        `ra` `firstview`
    WHERE
        (`firstview`.`MATCH_PERCENT` = (SELECT 
                MAX(`secondview`.`MATCH_PERCENT`)
            FROM
                `ra` `secondview`
            WHERE
                (`secondview`.`CourseCode` = `firstview`.`CourseCode`)))
                /* course code kullanarak join yapıyoruz bu sayede her course için max değeri almamızı sağlıyor */