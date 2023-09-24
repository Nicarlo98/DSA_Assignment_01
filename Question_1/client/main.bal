
import ballerina/http;
import ballerina/io;

public type Lecture record {
    string stuffID?;
    string title?;
    string name?;
    Office office?; //string officeNo?;
    Course[] courses?;

};

public type Course record {
    string courseCode?;
    string courseName?;
    string nqf?;
};

public type Office record {
    string officeNo?;
};

public function main() returns error? {
    io:println("    ");
    io:println("Welcome to Lectuer Management System");
    http:Client lectureClient = check new ("localhost:5000/lecture");
    io:println("===================================================================");
    io:println("1.Create Lecture");
    io:println("2.View Lecture");
    io:println("3.Update Lecture");
    io:println("4.Delete Lecture");
    io:println("5.View Lectures By StuffID");
    io:println("6.View Lectures By Course");
    io:println("7.View Lectures By Same Office");
    io:println("===================================================================");
    string choice = io:readln("Input your choice: ");
    io:println("    ");

    match choice {
        //Create
        "1" => {
            Lecture lecture = {};
            lecture.stuffID = io:readln("Enter Lecture Stuff ID: ");
            lecture.title = io:readln("Enter Lecture Title: ");
            lecture.name = io:readln("Enter Lecture Name: ");
            Office office = {};
            office.officeNo = io:readln("Enter Lecture Office Number: ");
            lecture.office = office;
            Course course = {};
            course.courseCode = io:readln("Enter Course Code: ");
            course.courseName = io:readln("Enter Course Name: ");
            course.nqf = io:readln("Enter NQF Level for Course: ");
            lecture.courses = [course];

            check create(lectureClient, lecture);
        }
        //view
        "2" => {
            check getAll(lectureClient);
        }
        //update
        "3" => {
            Lecture lecture = {};

            lecture.stuffID = io:readln("Enter Lecture StiffID: ");
            lecture.title = io:readln("Enter Lecture Title: ");
            lecture.name = io:readln("Enter Lecture Name: ");

            Office office = {};
            office.officeNo = io:readln("Enter Lectures Office Number: ");

            check update(lectureClient, lecture);
        }
        //Delete
        "4" => {
            string stuffID = io:readln("Enter Lecture Stuff ID : ");
            check delete(lectureClient, stuffID);
        }
        //check by stuffID
        "5" => {
            string stuffID = io:readln("Enter Lecture Stuff ID : ");
            check lectureById(lectureClient, stuffID);
        }
        //check by course
        "6" => {
            string courseName = io:readln("Enter Course Name : ");
            check getByCourse(lectureClient, courseName);

        }
        //check by office
        "7" => {
            string officeNo = io:readln("Enter Lectures Office Number : ");
            check getByOffice(lectureClient, officeNo);
        }

        _ => {
            io:println("Invalid Input, Please try again and Choices are Between 1-7 !!!");
            check main();
        }
    }
    return ();
}

public function create(http:Client http, Lecture lecture) returns error? {
    if (http is http:Client) {
        string message = check http->post("/createLecture", lecture);
        io:print("   ");
        io:println(message);

    }
    return main();
}

public function getAll(http:Client http) returns error? {
    if (http is http:Client) {
        Lecture[] lecture = check http->get("/listOfLecture");
        foreach Lecture lec in lecture {
            io:println("===================================================================");
            io:println("Lecture ID : ", lec.stuffID);
            io:println("Lecture Title : ", lec.title);
            io:println("Lecture Name : ", lec.name);
            io:println("Lecture Office No : ", lec.office);
            io:print("Courses : ", lec.courses);
            io:println("    ");
        }

        io:println("===================================================================");
        return main();

    }
}

public function update(http:Client http, Lecture lecture) returns error? {
    // string message = check http->put("/updateLecture", lecture);
    io:println(lecture);
    io:println("Successfully Updated");
    io:println("        ");
    return main();
}

//fix
public function delete(http:Client http, string stuffID) returns error? {
    if (http is http:Client) {
        string message = check http->delete("/deleteByStuffId?stuffID=" + stuffID); // Update path
        io:println(message);
        io:println("===================================================================");
    }
    return main();
}

public function lectureById(http:Client http, string stuffID) returns error? {
    if (http is http:Client) {
        Lecture lec = check http->get("/lectureById?stuffID=" + stuffID); // Update path

        // foreach Lecture lec in lecture {
        io:println("===================================================================");
        io:println("Lecture ID : ", lec.stuffID);
        io:println("Lecture Title : ", lec.title);
        io:println("Lecture Name : ", lec.name);
        io:println("Lecture Office No : ", lec.office);
        io:print("Courses : ", lec.courses);
        io:println("    ");
        // }

        io:println("===================================================================");
        return main();
    }
}

public function getByCourse(http:Client http, string courseName) returns error? {
    if (http is http:Client) {
        Lecture[] lectures = check http->get("/AllLectureByCourse?courseName=" + courseName.toString());
        foreach Lecture lecture in lectures {
            io:println("===================================================================");
            io:println("Lecture ID : ", lecture.stuffID);
            io:println("Lecture Title : ", lecture.title);
            io:println("Lecture Name : ", lecture.name);
            io:println("Lecture Office No : ", lecture.office);
            io:print("Courses : ", lecture.courses);
            io:println("===================================================================");
        }
    }

    return main();
}

//fix

public function getByOffice(http:Client http, string officeNo) returns error? {
    if (http is http:Client) {
        Lecture[] lectures = check http->get("/allLectureInSameOffice?officeNo=" + officeNo); // Update path
        if (officeNo == officeNo) {
            foreach Lecture lecture in lectures {
                io:println("==============================================");
                io:println("Lecture ID : ", lecture.stuffID);
                io:println("Lecture Title : ", lecture.title);
                io:println("Lecture Name : ", lecture.name);
                io:println("Lecture Office No : ", lecture.office);
                io:println("Courses : ", lecture.courses);
                io:println("==============================================");
            }
        }
        else {
            io:println("No Lecture in " + officeNo);

        }
    }
    return main();
}

