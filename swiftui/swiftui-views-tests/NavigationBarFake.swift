//
//  NavigationBarFake.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 20/10/24.
//

import SwiftUI

struct NavigationBarFake<Title: View, Leading: View, Trailing: View>: View {
    
    // MARK: - Init
    
    init(@ViewBuilder title: () -> Title, leading: () -> Leading = { EmptyView() }, trailing: () -> Trailing = { EmptyView() }) {
        self.title = title()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    // MARK: - Properties
    
    var title: Title
    var leading: Leading
    var trailing: Trailing
    
    // MARK: - Properties (View)
    
    var body: some View {
        ZStack {
            Color.white
            HStack(spacing: 0) {
                leading.padding()
                Spacer()
                trailing.padding()
            }
            HStack {
                title.padding()
            }
        }
        .foregroundStyle(Color.black)
        .frame(height: 50)
    }
    
}


struct UsageNavBarFakeView: View {
    var body: some View {
        VStack {
            NavigationBarFake {
                Text("My App")
            } leading: {
                Button(action: {}) { Image(systemName: "star") }
            } trailing: {
                Button(action: {}) { Image(systemName: "gear") }
            }
            Spacer()
        }
    }
}
