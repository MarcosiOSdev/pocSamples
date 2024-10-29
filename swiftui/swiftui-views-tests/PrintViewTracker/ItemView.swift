//
//  ItemView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 27/10/24.
//

import SwiftUI

// Exemplo de modelo de item
struct ListItem: TrackableItem, Identifiable {
    let id: String
    let title: String
}


struct ItemView: View {
    
    var item: ListItem
    
    var heightSize: CGFloat {
        let increaseValue = CGFloat(Int(item.id) ?? 1) * 2
        return 150 + increaseValue
    }
    
    var background: Color {
        let listColor = [Color.blue, Color.red, Color.green, Color.gray]
        let idInt = Int(item.id)!
        let index = getIndex(id: idInt)
        return listColor[index]
    }
    
    func getIndex(id: Int) -> Int {
        return id > 3 ? getIndex(id: id - 4) : id
    }
    
    var body: some View {
        Text("Row is \(item.id) - \(item.title)")
            .frame(height: heightSize)
            .frame(maxWidth: .infinity)
            .background(background)
    }
}
