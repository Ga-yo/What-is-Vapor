import Vapor
import Fluent
import FluentMySQLDriver

public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
//    내 모델이랑
//    디비 이름이
    app.databases.use(.mysql(
                        hostname: "127.0.0.1",
                        port: 3306,
                        username: "root",
                        password: "baekbaek777",
                        database: "galaxies",
                        tlsConfiguration: .forClient(certificateVerification: .none)),
                      as: .mysql)
//    app.migrations.add(User.self, to: .mysql)
//    app.migrations.add(Article.self, to: DatabaseID.mysql)

    //기본 인코드 및 디코더 구성
    let encoder = JSONEncoder()
    ContentConfiguration.global.use(encoder: encoder, for: .json)
    
    app.routes.defaultMaxBodySize = "500kb"
    app.routes.caseInsensitive = true // 대소문자를 구분하지 않는 라우팅
    
    app.migrations.add(CreateGalaxy())
    try routes(app)
}




