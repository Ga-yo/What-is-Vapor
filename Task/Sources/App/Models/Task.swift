//
//  File.swift
//  
//
//  Created by 이가영 on 2021/08/26.
//

import Fluent
import Vapor

final class Task: Model {
    static let schema = "tasks" //DB 테이블 이름
    
    @ID(key: .id) //모델은 id 프로퍼티를 갖고 고유 식별자 타입이다
    var id: UUID?
    
    @Field(key: "title") //데이터를 저장하기 위한 Field 프로퍼티
    var title: String
    
    @Enum(key: "status") //Field의 한 종류
    var status: Status
    
    @OptionalField(key: "comment") //옵셔널 타입 사용
    var comment: String?
    
    @Timestamp(key: "created_date", on: .create)
    var createdDate: Date?
    
    init() { } //모델은 반드시 빈 이니셜라이저를 가져야한다
    
    init(id: UUID? = nil,
         title: String,
         status: Status,
         comment: String? = nil,
         createdDate: Date? = nil) {
        self.id = id
        self.title = title
        self.status = status
        self.comment = comment
        self.createdDate = createdDate
    }
}

enum Status: String, Codable {
    case toDo, doing, done
}

final class PatchTask: Codable {
    var id: UUID?
    var title: String
    var status: Status
    var comment: String?
}
