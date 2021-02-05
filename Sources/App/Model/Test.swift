//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/05.
//

import Foundation

final class Test: Model, Content {
    static let schema = "galaxies"
    
    @ID(key: .id)
    var id: UUID?
    
    
    @Field(key: "name")
    var name: String
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

struct CreateGalaxy: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("galaxies")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("galaxies").delete()
    }
}
