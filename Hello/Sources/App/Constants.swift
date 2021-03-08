//
//  File.swift
//  
//
//  Created by 이가영 on 2021/02/28.
//

import Foundation
import Vapor

public enum Constants {
    public enum Endpoints: String {
        case products = "products"
        case singleProduce = "productId"
        
        var path: PathComponent {
            return PathComponent(stringLiteral: self.rawValue)
        }
    }
}
