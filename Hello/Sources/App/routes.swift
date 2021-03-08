import Vapor

func routes(_ app: Application) throws {

    app.get("galaxies") { (req) in
        Galaxy.query(on: req.db).all()
    }
    app.get { req in
        return "It works!"
    }

    app.get("hi") { req -> String in
        req.logger.info("Hello logs!")
        return "Hello, world!"
    }
    
    app.get("name") { (req) in
        return "Ethan Hunt"
    }

//    hello/\(name)
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
    
    app.get(Constants.Endpoints.products.path) { (req) -> Response in
        let products = app.productService.getProducts()
        return .init(status: .ok,
                     version: req.version,
                     headers: [
                       "Content-Type":
                       "application/json"
                     ],
                     body:
                       .init(string:
                          products.codableArrayJSONString()
                       ))
    }
    
    app.get(Constants.Endpoints.products.path,
            ":\(Constants.Endpoints.singleProduce.path)") { req -> Response in
        let productId = req.parameters.get(
            Constants.Endpoints.singleProduce.rawValue,
            as: Int.self
        ) ?? 0
            
        if let product = app.productService.getProductById(id: productId) {
                return .init(status: .ok,
                         version: req.version,
                         headers: [
                           "Content-Type":
                           "application/json"],
                         body:
                          .init(
                            string: product.asJSONString()
                          ))
        }
            
        return .init(status: .ok,
                 version: req.version,
                 headers: [
                   "Content-Type":
                   "application/json"
                 ],
                 body: .init(string: "No product found."))
        }
}
