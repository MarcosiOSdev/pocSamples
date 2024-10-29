//
//  PrintViewTrackV2View.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 28/10/24.
//

import SwiftUI

struct PrintViewTrackV2View: View {
    @State private var visibleItems: Set<String> = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100, id: \.self) { index in
                    ItemView(item: ListItem(id: String(index), title: String(index)))
                        .modifier(VListVisibilityTracker(id: String(index), sizeParent: .zero))
                }
            }
        }
        .onPreferenceChange(VisibleItemsPreferenceKey.self) { value in
            visibleItems = value
        }
        .onChange(of: visibleItems) { newVisibleItems in
            print("Currently visible items: \(newVisibleItems)")
        }
    }
}


