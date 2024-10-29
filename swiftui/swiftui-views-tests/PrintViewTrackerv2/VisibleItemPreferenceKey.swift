//
//  VisibleItemPreferenceKey.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 28/10/24.
//

import SwiftUI

struct VisibleItemPreferenceKey: PreferenceKey {
    typealias Value = [Int]
    
    static var defaultValue: [Int] = []
    
    static func reduce(value: inout [Int], nextValue: () -> [Int]) {
        value.append(contentsOf: nextValue())
    }
}
