//
//  File.swift
//  
//
//  Created by 이가영 on 2021/08/26.
//

import Fluent
import Vapor

//라우트를 그룹화할 수 있도록 RoutCollection 프로토콜을 제공한다
struct TaskController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: showAll)
        tasks.post(use: create)
        tasks.group(":id") { tasks in
            tasks.delete(use: delete)
        }
    }
    
    func showAll(req: Request) throws -> EventLoopFuture<[Task]> {
        print("tasks get")
        return Task.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Task> {
        try Task.validate(content: req)
        let task = try req.content.decode(Task.self)
        return task.create(on: req.db).map { task }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Task.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound)) // Abort라는 기본 오류 타입
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}

extension Task: Content { }
extension Task: Validatable { //Codable은 첫번째 오류가 발생하는 즉시 디코딩을 중지하지만 Validateble API는 요청에서 실패한 모든 유효성 검사를 보고하므로 더 빠르게 원인을 찾을 수 있다
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
        validations.add("status", as: String.self, is: .in("toDo", "doing", "done"))
        validations.add("comment", as: String?.self, required: false)
    }
}
