//
//  VisibleItemsModifier.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 28/10/24.
//

import SwiftUI

struct VisibleItemsModifier: ViewModifier {
    let itemID: Int
    @Binding var visibleItems: Set<Int>
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            if isItemVisible(geometry) {
                                visibleItems.insert(itemID)
                            }
                        }
                        .onDisappear {
                            visibleItems.remove(itemID)
                        }
                }
            )
    }
    
    private func isItemVisible(_ geometry: GeometryProxy) -> Bool {
        let frame = geometry.frame(in: .global)
        return frame.minY >= 0 && frame.maxY <= UIScreen.main.bounds.height
    }
}


extension View {
    func trackVisibility(of itemID: Int, in visibleItems: Binding<Set<Int>>) -> some View {
        self.modifier(VisibleItemsModifier(itemID: itemID, visibleItems: visibleItems))
    }
}
