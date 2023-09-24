import ballerina/io;

StudentClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    LocateBook locateBookRequest = {isbn: "ballerina"};
    Book locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBook borrowBookRequest = {id: "ballerina", isbn: "ballerina"};
    Book borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
    stream<

Book, error?> listBooksResponse = check ep->listBooks();
    check listBooksResponse.forEach(function(Book value) {
        io:println(value);
    });
}

