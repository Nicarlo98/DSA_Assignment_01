import ballerina/io;

LibrarianClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book createBookRequest = {id: "ballerina", title: "ballerina", author: "ballerina", optAuthor: "ballerina", location: "ballerina", isbn: "ballerina", availability: "available"};
    Book createBookResponse = check ep->createBook(createBookRequest);
    io:println(createBookResponse);

    Book updateBookRequest = {id: "ballerina", title: "ballerina", author: "ballerina", optAuthor: "ballerina", location: "ballerina", isbn: "ballerina", availability: "available"};
    Book updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);

    RemoveBook removeBookRequest = {isbn: "ballerina"};
    check ep->removeBook(removeBookRequest);
    stream<

Book, error?> listBooksResponse = check ep->listBooks();
    check listBooksResponse.forEach(function(Book value) {
        io:println(value);
    });
    stream<

Book, error?> listBorrowedBooksResponse = check ep->listBorrowedBooks();
    check listBorrowedBooksResponse.forEach(function(Book value) {
        io:println(value);
    });

    Users createUsersRequest = {id: "ballerina", name: "ballerina", typeOfUser: "lecturer"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    check createUsersStreamingClient->sendUsers(createUsersRequest);
    check createUsersStreamingClient->complete();
    Responds? createUsersResponse = check createUsersStreamingClient->receiveResponds();
    io:println(createUsersResponse);
}

