import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.migrations.add(TaskMigration())

    app.databases.use(.postgres(
        hostname: Environment.get("localhost") ?? "localhost",
        port: Environment.get("5432").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("igayeong") ?? "igayeong",
        password: Environment.get("") ?? "vapor_password",
        database: Environment.get("my_database") ?? "my_database"
    ), as: .psql)

    // register routes
    try routes(app)
}
