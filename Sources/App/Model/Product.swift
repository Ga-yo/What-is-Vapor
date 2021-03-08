//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/28.
//

import Foundation
import Vapor

struct Product: Codable {
    var id: Int
    private var name: String
    private var price: Double
    private var description: String
    
    init(id: Int, name: String, price: Double, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
    }
    
    func asJSONString() -> String {
        let codedProduct = try! JSONEncoder().encode(self)
        return String(data: codedProduct, encoding: .utf8)!
    }
}
