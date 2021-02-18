//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/16.
//

import Foundation
import Vapor

struct Greeting: Content {
    var hello: String
}

struct Profile: Content {
    var name: String
    var email: String
    var image: Data //파일 업로드의 경우
}

struct Hello: Content {
    var name: String?
}

enum Color: String, Codable {
    case red, blue, green
}

struct CreateUser: Content {
    var name: String
    var username: String
    var age: Int
    var email: String
    var favoriteColor: Color?
}

extension CreateUser: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        //이메일 검증
        validations.add("age", as: Int.self, is: .range(13...))
        //13살 이상
        validations.add("name", as: String.self, is: !.empty)
        //비어있지 않아야함
        validations.add("username", as: String.self, is: .count(3...) && .alphanumeric)
        //3글자 이상, 영숫자만 포함
        validations.add("favoriteColor", as: String.self, is: .in("red", "blue", "green"), required: false)
        //필수가 아님
    }
}
