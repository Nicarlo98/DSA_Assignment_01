import ballerina/grpc;
import ballerina/io;

type BookMemory record {
    string id;
    string title;
    string author;
    string optAuthor;
    string location;
    string isbn;
    Availability availability;
};

type UserMemory record {
    string id;
    string name;
    userType typeOfUser;
};

map<BookMemory> bookStorage = {};

map<UserMemory> userStorage = {};



listener grpc:Listener ep = new (9090);

table<Book> key() bookTable = table [];

@grpc:Descriptor {value: LIBRARY_DESC}
service "Librarian" on ep {

    

    remote function createBook(Book value) returns Book|error {
        if (bookStorage[value.id] == null){
            bookStorage[value.id] = value;
            return value;
        }else {
            return error("Book already in storage");
        }
    }
    remote function updateBook(Book value) returns Book|error {
        if (bookStorage[value.id] != null) {
            bookStorage[value.id] = value;
            return value;
        }else {
            return error("404 Book not found!");
        }
    }
    remote function removeBook(RemoveBook value) returns error? {
        if (bookStorage[value.isbn] != null){
            _ = bookStorage.remove(value.isbn);
            return (); 
        }else {
            return error("404 book not found!");
        }
    }
    remote function createUsers(stream<Users, grpc:Error?> clientStream) returns Responds|error {
        Responds responds = {Message: "Users created successfully"};
        check clientStream.forEach(function (Users user){
          UserMemory userMemory = {
                id: user.id,
                name: user.name,
                typeOfUser: user.typeOfUser
            };
             userStorage[user.id] = userMemory;

            io:println("New user created: " + user.id);


    });
        return responds;
    
    }
    remote function listBooks() returns stream<Book, error?>|error {
       // grpc:ResponseSender<Book> responseSender = check new (bookStorage.size());
        stream<Book, error?> bookStream = stream from var book in bookTable.toArray()
            select book;

        return bookStream;
        //  foreach Book, value in bookStorage {
        //     Book book = {
        //         id: value.id,
        //         title: value.title,
        //         author: value.author,
        //         optAuthor: value.optAuthor,
        //         location: value.location,
        //         isbn: value.isbn,
        //         availability: value.availability
        //     };
            
        //     check responseSender->send(book);
             
        // }
        // check responseSender->complete();
        // return responseSender.getStream();
    }
    // remote function listBorrowedBooks() returns stream<Book, error?>|error {
    //     grpc:ResponseSender<Book, error?> responseSender = check new (bookStorage.size());

    //     foreach key, value in bookStorage{
    //         if (!value.availability) {
    //             Book book = {
    //                 id: value.id,
    //                 title: value.title,
    //                 author: value.author,
    //                 optAuthor: value.optAuthor,
    //                 location: value.location,
    //                 isbn: value.isbn,
    //                 availability: value.availability
    //             };
                
    //             check responseSender->send(book);
    //         }
    //     }
    //     check responseSender->complete();

    //     return responseSender;
    // }
    
}

