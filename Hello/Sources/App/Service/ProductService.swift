//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/28.
//

import Foundation
import Vapor

class ProductService {
    var products: [Product] = []
    
    init() {
        let toucan = Product(id: 1, name: "hi", price: 50.00, description: "Famous bird of the zoo")
        let elephant = Product(id: 2, name: "Elephant", price: 85.00, description: "Large creature from Africa")
        let giraffe = Product(id: 3, name: "Giraffe", price: 65.00, description: "Long necked creature")
        
        products.append(toucan)
        products.append(elephant)
        products.append(giraffe)
    }
    
    func getProductById(id: Int) -> Product? {
        return products.first(where: { $0.id == id })
    }
    
    func getProducts() -> [Product] {
        return products
    }
}

extension Application {
    var productService: ProductService {
        .init()
    }
}

//JSON 문자열 Encoding
extension Array {
    typealias CodableArray = [Product]
    
    func codableArrayJSONString() -> String {
        if let array = self as? CodableArray{
            let codedArray = try! JSONEncoder().encode(array)
            
            return String(data: codedArray, encoding: .utf8)!
        }
        return ""
    }
    
    
}
