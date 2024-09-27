//
//  AnimationFadeInOutView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 27/09/24.
//

import SwiftUI

struct AnimationFadeInOutView: View {
    @State private var isButtonInCardA: Bool = true // Track where the button is
    
    var body: some View {
        VStack {
            HStack {
                // CardA
                CardView(title: "CardA") {
                    ZStack {
                        if isButtonInCardA {
                            Button("Move to CardB") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonInCardA.toggle() // Toggle the state
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
                
                Spacer()
                
                // CardB
                CardView(title: "CardB") {
                    VStack {
                        if !isButtonInCardA {
                            Button("Move to CardA") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonInCardA.toggle() // Toggle the state
                                }
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// Helper view for Card
struct CardView<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Spacer()
            content() // Content of the card
            Spacer()
        }
        .frame(width: 150, height: 200)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
