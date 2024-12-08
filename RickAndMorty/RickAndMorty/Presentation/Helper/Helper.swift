//
//  Helper.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit

extension Optional where Wrapped == String {
    var defaultValue: String {
        switch self {
        case .none:
            return ""
        case .some(let value):
            return value
        }
    }
}

extension Optional where Wrapped == Int {
    var defaultValue: Int {
        switch self {
        case .none:
            return 0
        case .some(let value):
            return value
        }
    }
}
