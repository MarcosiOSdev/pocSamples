//
//  SampleGridView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 10/06/24.
//

import SwiftUI

// iOS 16+
struct SampleGridView: View {
    var body: some View {
        
        VStack {
            ScrollView(.horizontal) {
                Grid ( horizontalSpacing: 20, verticalSpacing: 20 ) {
                    GridRow {
                        Text("Row 1")
                        ForEach(0..<3) { _ in Circle().foregroundColor(.red) }
                    }
                    Text("One Text between Rows")
                        .font(.title)
                    GridRow {
                        Text("Row 2")
                        ForEach(0..<5) { _ in Circle().foregroundColor(.green) }
                    }
                    GridRow {
                        Text("Row 3")
                        ForEach(0..<4) { _ in Circle().foregroundColor(.mint) }
                    }
                    GridRow {
                        Text("Row 4")
                        ForEach(1..<5) { index in
                            if index.isMultiple(of: 2) {
                                Circle().foregroundColor(.blue)
                            } else {
                                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                            }
                        }
                    }
                    GridRow {
                        Text("Row 5")
                        Circle().foregroundColor(.pink)
                        Text("This will take space of 3 cell")
                            .gridCellColumns(3)
                            .font(.title)
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 500)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    SampleGridView()
}
