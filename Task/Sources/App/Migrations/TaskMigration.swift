//
//  File.swift
//  
//
//  Created by 이가영 on 2021/08/26.
//

import Fluent

struct TaskMigration: Migration {
    //DB를 변화시키는 동작 수행
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        _ = database.enum("status")
            .case("toDo")
            .case("doing")
            .case("done")
            .create()
        
        return database.enum("status").read().flatMap { status in
            database.schema(Task.schema)
                .id()
                .field("title", .string, .required)
                .field("status", status, .required)
                .field("comment", .string)
                .field("created_date", .datetime, .required)
                .create()
        }
    }
    
    //변화를 되돌리는 동작
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Task.schema).delete()
    }
}
