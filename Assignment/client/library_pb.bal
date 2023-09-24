import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F12106C69627261727953797374656D4170701A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22D6010A04426F6F6B120E0A0269641801200128095202696412140A057469746C6518022001280952057469746C6512160A06617574686F721803200128095206617574686F72121C0A096F7074417574686F7218042001280952096F7074417574686F72121A0A086C6F636174696F6E18052001280952086C6F636174696F6E12120A046973626E18062001280952046973626E12420A0C617661696C6162696C69747918072001280E321E2E6C69627261727953797374656D4170702E417661696C6162696C697479520C617661696C6162696C69747922670A055573657273120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D65123A0A0A747970654F665573657218032001280E321A2E6C69627261727953797374656D4170702E7573657254797065520A747970654F665573657222300A0A426F72726F77426F6F6B120E0A0269641801200128095202696412120A046973626E18022001280952046973626E22200A0A4C6F63617465426F6F6B12120A046973626E18012001280952046973626E22200A0A52656D6F7665426F6F6B12120A046973626E18012001280952046973626E22240A08526573706F6E647312180A074D65737361676518012001280952074D6573736167652A2F0A0C417661696C6162696C697479120D0A09617661696C61626C65100012100A0C6E6F74417661696C61626C6510012A250A087573657254797065120C0A086C656374757265721000120B0A0773747564656E7410013297030A094C696272617269616E123C0A0A637265617465426F6F6B12162E6C69627261727953797374656D4170702E426F6F6B1A162E6C69627261727953797374656D4170702E426F6F6B12440A0B637265617465557365727312172E6C69627261727953797374656D4170702E55736572731A1A2E6C69627261727953797374656D4170702E526573706F6E64732801123C0A0A757064617465426F6F6B12162E6C69627261727953797374656D4170702E426F6F6B1A162E6C69627261727953797374656D4170702E426F6F6B12420A0A72656D6F7665426F6F6B121C2E6C69627261727953797374656D4170702E52656D6F7665426F6F6B1A162E676F6F676C652E70726F746F6275662E456D707479123D0A096C697374426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A162E6C69627261727953797374656D4170702E426F6F6B300112450A116C697374426F72726F776564426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A162E6C69627261727953797374656D4170702E426F6F6B300132D0010A0753747564656E74123D0A096C697374426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A162E6C69627261727953797374656D4170702E426F6F6B300112420A0A6C6F63617465426F6F6B121C2E6C69627261727953797374656D4170702E4C6F63617465426F6F6B1A162E6C69627261727953797374656D4170702E426F6F6B12420A0A626F72726F77426F6F6B121C2E6C69627261727953797374656D4170702E426F72726F77426F6F6B1A162E6C69627261727953797374656D4170702E426F6F6B620670726F746F33";

public isolated client class LibrarianClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function createBook(Book|ContextBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/createBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function createBookContext(Book|ContextBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/createBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function updateBook(Book|ContextBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function updateBookContext(Book|ContextBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function removeBook(RemoveBook|ContextRemoveBook req) returns grpc:Error? {
        map<string|string[]> headers = {};
        RemoveBook message;
        if req is ContextRemoveBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/removeBook", message, headers);
    }

    isolated remote function removeBookContext(RemoveBook|ContextRemoveBook req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBook message;
        if req is ContextRemoveBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Librarian/removeBook", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("librarySystemApp.Librarian/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }

    isolated remote function listBooks() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Librarian/listBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function listBooksContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Librarian/listBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function listBorrowedBooks() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Librarian/listBorrowedBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function listBorrowedBooksContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Librarian/listBorrowedBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public isolated client class StudentClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function locateBook(LocateBook|ContextLocateBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        LocateBook message;
        if req is ContextLocateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Student/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function locateBookContext(LocateBook|ContextLocateBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        LocateBook message;
        if req is ContextLocateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Student/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function borrowBook(BorrowBook|ContextBorrowBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBook message;
        if req is ContextBorrowBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Student/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function borrowBookContext(BorrowBook|ContextBorrowBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBook message;
        if req is ContextBorrowBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystemApp.Student/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function listBooks() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Student/listBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function listBooksContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystemApp.Student/listBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUsers(Users message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUsers(ContextUsers message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveResponds() returns Responds|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <Responds>payload;
        }
    }

    isolated remote function receiveContextResponds() returns ContextResponds|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <Responds>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class BookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Book value;|} nextRecord = {value: <Book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextBookStream record {|
    stream<Book, error?> content;
    map<string|string[]> headers;
|};

public type ContextUsersStream record {|
    stream<Users, error?> content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextRemoveBook record {|
    RemoveBook content;
    map<string|string[]> headers;
|};

public type ContextUsers record {|
    Users content;
    map<string|string[]> headers;
|};

public type ContextResponds record {|
    Responds content;
    map<string|string[]> headers;
|};

public type ContextLocateBook record {|
    LocateBook content;
    map<string|string[]> headers;
|};

public type ContextBorrowBook record {|
    BorrowBook content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBook record {|
    string id = "";
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBook record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string id = "";
    string title = "";
    string author = "";
    string optAuthor = "";
    string location = "";
    string isbn = "";
    Availability availability = available;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBook record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Users record {|
    string id = "";
    string name = "";
    userType typeOfUser = lecturer;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Responds record {|
    string Message = "";
|};

public enum Availability {
    available, notAvailable
}

public enum userType {
    lecturer, student
}

