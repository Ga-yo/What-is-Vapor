//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/05.
//

import Foundation
import Vapor

enum ResponseStatus: Int, Content {
    case ok = 200
    case error = 400
    case unknown = 500
    
    var desc: String {
        switch self{
        case .ok:
            return "요청이 성공했습니다"
        case .error:
            return "요청이 실패했습니다"
        case .unknown:
            return "에러의 원인을 모릅니다"
        }
    }
}

struct ResponseJSON<T: Content>: Content {
    private var status: ResponseStatus
    private var message: String
    private var data: T?
    
    init(data: T) {
        self.status = .ok
        self.message = status.desc
        self.data = data
    }
    
    init(status: ResponseStatus = .ok, message: String = ResponseStatus.ok.desc) {
        self.status = status
        self.message = message
        self.data = nil
    }
    
    init(status: ResponseStatus = .ok, message: String = ResponseStatus.ok.desc, data: T?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

struct Empty: Content { }
