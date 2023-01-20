CREATE TABLE OPTIONALCOURSE
(
OptionalCourseCode VARCHAR(40) NOT NULL,
OptionalCourseAttribute VARCHAR(40),
OptionalType VARCHAR(1) NOT NULL,
OptionalTechAttribute VARCHAR(40),
OptionalNonTechAttribute VARCHAR(40),

PRIMARY KEY(OptionalCourseCode),

CHECK((OptionalType = '1' AND OptionalNonTechAttribute != NULL AND OptionalTechAttribute = NULL) OR (OptionalType = '0' AND OptionalTechAttribute = !NULL AND OptionalNonTechAttribute = NULL))
)