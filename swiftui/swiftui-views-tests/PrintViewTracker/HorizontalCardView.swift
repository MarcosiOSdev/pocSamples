//
//  HorizontalCardView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 28/10/24.
//

import SwiftUI

struct HorizontalCardView: View {
    
    let cards = (0...50).map { $0 }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(cards, id: \.self) { card in
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.blue)
                    
                }
            }
            .frame(height: 80)
            .background(Color.yellow)
        }
    }
}
