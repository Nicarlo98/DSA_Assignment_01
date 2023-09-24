import ballerina/http;

type Lecture record {
    readonly string stuffID;
    string title;
    string name;
    Office office;
    Course[] courses;
};

type Course record {
    string courseCode;
    string courseName;
    string nqf;
};

type Office record {
    string officeNo;
};

table<Lecture> key(stuffID) lectureTable = table [];

service /lecture on new http:Listener(5000) {

    resource function post createLecture(Lecture newLecture) returns string|error {
        error? createNewLecture = lectureTable.add(newLecture);

        if (createNewLecture is error) {
            return "Error " + createNewLecture.message();
        } else {
            return newLecture.title + " " + newLecture.name + " saved successfully";
        }
    }

    resource function get listOfLecture() returns Lecture[] {
        return lectureTable.toArray();
    }

    resource function put updateLecture(Lecture updatedLectures) returns string {
        error? updateLecture = lectureTable.put(updatedLectures);

        if (updateLecture is error) {
            return "Error " + updateLecture.message();
        } else {
            // return string `${updatedLectures.title} ${updatedLectures.name} saved successfully`;
            return updatedLectures.title + " " + updatedLectures.name + " updated successfully";
        }
    }

    resource function get lectureById(string stuffID) returns Lecture|string {
        Lecture? result = lectureTable[stuffID];
        if (result != null) {
            return result;
        } else {
            return stuffID + " is Invalid. Please Check Again";
        }
        //other way to try
        // Lecture? lecture = lectureTable[stuffID];
        // if (lecture is Lecture) {
        //     return lecture;
        // } else {
        //     return "Invalid stuffID. Please Check Again";
        // }
    }

    resource function get AllLectureByCourse(string courseName) returns Lecture[]|string {
        if (courseName != "") {
            Lecture[] lectureResults = [];
            foreach var lecture in lectureTable {
                foreach var course in lecture.courses {
                    if (course.courseName == courseName) {
                        lectureResults.push(lecture);
                        break;
                    }
                }
            }
            if (lectureResults.length() > 0) {
                return lectureResults;
            } else {
                return "No lectures found for the course: " + courseName;
            }
        } else {
            return "Invalid course name";
        }

        //another to try if not work
        // if (courseName !== "") {
        //     table<Lecture> lectureResults = from var lecture in lectureTable
        //         where courseName == lecture.courses.courseName
        //         select lecture;
        //     return lectureResults.toArray();
        // } else {
        //     return "Invalid";
        // }

    }

    resource function get allLectureInSameOffice(string officeNo) returns Lecture[]|string {
        if (officeNo != "") {
            Lecture[] lectureResults = [];
            foreach var lecture in lectureTable {
                if (lecture.office.officeNo == officeNo) {
                    lectureResults.push(lecture);
                }
            }
            if (lectureResults.length() > 0) {
                return lectureResults;
            } else {
                return "No lectures found in office: " + officeNo;
            }
        } else {
            return "Invalid office number";
        }

        //another way to try if not work
        // if (officeNo !== "") {
        //     table<Lecture> lectureResults = from var lecture in lectureTable
        //         where officeNo == lecture.officeNo
        //         select lecture;
        //     return lectureResults.toArray();
        // } else {
        //     return "Invalid";
        // }
    }

    resource function delete deleteByStuffId(string stuffID) returns string|error {
        Lecture|error deleteResult = lectureTable.remove(stuffID);
        if (deleteResult is error) {
            return "Error " + deleteResult.message();
        } else {
            return "Lecturer with ID " + stuffID + " deleted successfully";
        }
    }
}
