import Vapor

func routes(_ app: Application) throws {

    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("name") { (req) in
        return "Ethan Hunt"
    }

    //hello/\(name)
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")!
        return "Hello \(name)!"
    }
    
    // foo/bar/baz
    app.get("foo", "bar", "baz") {req in
        return "bar"
    }
    
    //int형
    app.get("number", ":x") {req -> String in
        guard let int = req.parameters.get("x", as: Int.self) else {throw Abort(.badRequest)}
        return "\(int) is a great number"
    }
    
    //hello/foo/bar = foo bar
    app.get("hello", "**") { (req) -> String in
        let name = req.parameters.getCatchall().joined(separator: " ")
        print(app.routes.all)
        return "Hello \(name)"
    }
    
    //경로 그룹
    let users = app.grouped("users")
    
    users.get { req in
        return "group users"
    }
    
    users.get(":id") { req -> String in
        let id = req.parameters.get("id")!
        return "group users \(id)"
    }
    
    app.post("greeting") { (req) -> HTTPResponseStatus in
        let greeting = try req.content.decode(Greeting.self)
        print(greeting.hello)
        return HTTPStatus.ok
    }
    
    //hello?name=\(name) 쿼리문
    app.get("hello") { (req) -> String in
        let hello = try req.query.decode(Hello.self)
        return "Hello. \(hello.name ?? "Anonymous")"
        
        //let name: String? = req.query["name"] 단일값
    }
    
    app.post("users") { (req) -> CreateUser in
        try CreateUser.validate(content: req)
        try CreateUser.validate(query: req)
        let user = try req.content.decode(CreateUser.self)
        return user
    }
}
