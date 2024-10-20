//
//  VisualEffectHorizontalExample.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 20/10/24.
//

import SwiftUI

struct VisualEffectHorizontalExample: View {
    
    private var screenWidth: CGFloat = .init(UIScreen.main.bounds.width)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            LazyHStack(spacing: 20) {
                ForEach(1..<11) { item in
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(height: 50)
                                .padding(4)
                            Text("\(item)")
                                .foregroundStyle(.white)
                        }
                        .visualEffect { content, geometryProxy in
                            growAndChangeColorEffect(content: content, proxy: geometryProxy)
                        }
                    }
                    .scrollTargetLayout()
                }
            }
            
        }
        .defaultScrollAnchor(.center)
        .contentMargins(.horizontal, screenWidth / 2)
    }
    
    
    private func growAndChangeColorEffect(
        content: EmptyVisualEffect,
        proxy: GeometryProxy
    ) -> some VisualEffect {
        
        let frame = proxy.frame(in: .global)
        let screenWidth = self.screenWidth
        
        // the center X of the screen
        let centerXScreen = screenWidth / 2
        
        // the distance from the center of the screen to the center of the frame
        let distanceX = abs(centerXScreen - frame.midX)
        
        // the scale factor
        let scale = 1.5 - (distanceX / centerXScreen)
        
        // the hue rotation angle
        let hueRotationDegrees = Angle.degrees((1 - distanceX) / -1.50)
        
        return content
            .scaleEffect(scale)
            .hueRotation(hueRotationDegrees)
            .brightness(distanceX / centerXScreen * 0.3)
    }
}


struct VisualEffectExample: View {
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(0..<10) { item in
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.blue)
                        .frame(height: 200)
                        .visualEffect { content, proxy in
                            content
                                .hueRotation(
                                    Angle(degrees: proxy.frame(in: .global).origin.y / 8)
                                )
                        }
                }
                .padding()
            }
        }
        
    }
}
