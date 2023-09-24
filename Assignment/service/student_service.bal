import ballerina/grpc;

 //type BookMemories record {
//     string id;
//     string title;
//     string author;
//     string optAuthor;
//     string location;
//     string isbn;
//     boolean availability;
// };

// type BorrowBook record {
//     string isbn;
// };

// type LocateBook record {
//     string isbn;
// };

map<BookMemory> bookStorages = {};
table<Book> key() bookTables = table [];
@grpc:Descriptor {value: LIBRARY_DESC}
service "Student" on ep {

    remote function locateBook(LocateBook value) returns Book|error {
        string isbn = value.isbn;
        BookMemory? bookMemory = bookStorages[isbn];

        if (bookMemory != null) {
            Book book = {
                id: bookMemory.id,
                title: bookMemory.title,
                author: bookMemory.author,
                optAuthor: bookMemory.optAuthor,
                location: bookMemory.location,
                isbn: bookMemory.isbn,
                availability: bookMemory.availability
            };
            return book;
        } else {
            return error("404 Book not found!");
        }
    }
    remote function borrowBook(BorrowBook value) returns Book|error {
        string isbn = value.isbn;
        BookMemory? bookMemory = bookStorages[isbn];

        if (bookMemory != null) {
            if (bookMemory.availability) {
                bookMemory.availability = notAvailable;
                bookStorage[isbn] = bookMemory;

                Book book = {
                    id: bookMemory.id,
                    title: bookMemory.title,
                    author: bookMemory.author,
                    optAuthor: bookMemory.optAuthor,
                    location: bookMemory.location,
                    isbn: bookMemory.isbn,
                    availability: bookMemory.availability
                };
                return book;
            } else {
                return error("Book is already borrowed!");
            }
        } else {
            return error("404 Book not found!");
        }
    }
    remote function listBooks() returns stream<Book, error?>|error {
      stream<Book, error?> bookStream = stream from var book in bookTables.toArray()
            select book;

        return bookStream;
}
}
