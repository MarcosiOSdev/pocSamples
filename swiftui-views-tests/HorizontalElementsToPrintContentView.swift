//
//  HorizontalElementsToPrintContentView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 10/06/24.
//

import SwiftUI

struct HorizontalElementsToPrintContentView: View {
    private var data = Array(1...20)
    
    private var adaptiveColumn = [
        GridItem(.flexible(minimum: 0, maximum: 250)),
        GridItem(.flexible(minimum: 0, maximum: 250)),
        GridItem(.flexible(minimum: 0, maximum: 250))
    ]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: adaptiveColumn) {
                    ForEach(data, id: \.self) { item in
                        Text("\(item)")
                            .frame(width: 250, height: 250, alignment: .center)
                            .background(.blue)
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .font(.title)
                            .onAppear(perform: {
                                print("Item is printed: \(item)")
                            })
                    }
                }
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    HorizontalElementsToPrintContentView()
}
