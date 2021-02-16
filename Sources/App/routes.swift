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
}
