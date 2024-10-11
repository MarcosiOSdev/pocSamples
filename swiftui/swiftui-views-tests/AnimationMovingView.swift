//
//  AnimationMoving.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 27/09/24.
//

import SwiftUI

struct AnimationMovingView: View {
    @State private var isButtonInCardA: Bool = true // Track where the button is
    @State private var buttonPosition: CGPoint = .zero // Track the button's position
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Card Container
                ZStack {
                    // Card A
                    CardViewMoving(title: "CardA", size: geometry.size)
                        .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5)
                    
                    // Card B
                    CardViewMoving(title: "CardB", size: geometry.size)
                        .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.5)
                    
                    // Button
                    Button("Move") {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            isButtonInCardA.toggle() // Toggle the card
                            
                            // Move the button to the other card
                            buttonPosition = isButtonInCardA ?
                                CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5) :
                                CGPoint(x: geometry.size.width * 0.75, y: geometry.size.height * 0.5)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .position(buttonPosition) // Use position to move the button
                    .onAppear {
                        // Initial position
                        buttonPosition = CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5)
                    }
                }
            }
        }
    }
}

// Card View for layout
struct CardViewMoving: View {
    var title: String
    var size: CGSize
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Spacer()
        }
        .frame(width: size.width * 0.4, height: 200)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

