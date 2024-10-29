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
    
    var body: some View {
        VStack {
            Text("Row is \(item.id) - \(item.title)")
                .frame(height: heightSize)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
            
            Divider()
                .foregroundStyle(.white)
                .padding()
        }
    }
}
