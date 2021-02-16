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
