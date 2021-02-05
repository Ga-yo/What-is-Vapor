import Vapor
import Fluent
import FluentMySQLDriver

public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    let hostname = "127.0.0.1"
    let username = "root"
    let password = "baekbaek777"
    
    app.databases.use(.mysql(
                        hostname: hostname,
                        port: 3306,
                        username: username,
                        password: password,
                        database: "test",
                        tlsConfiguration: .forClient(certificateVerification: .none)),
                      as: .mysql)
    
    app.migrations.add(CreateGalaxy())
    
    try routes(app)
}




