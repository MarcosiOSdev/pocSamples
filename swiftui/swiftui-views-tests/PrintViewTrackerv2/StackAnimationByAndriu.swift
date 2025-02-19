//
//  StackAnimationByAndriu.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 18/02/25.
//

import SwiftUI

struct StackCardview: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.blue.gradient)
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .shadow(radius: 5)
    }
    
}


struct StackAnimationByAndriu: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: -15) {
                ForEach(0..<4) { index in
                    StackCardview()
                        .visualEffect { content, geometryProxy in
                            content
                                .hueRotation(Angle(degrees: geometryProxy.frame(in: .global).origin.y / 10))
                                .scaleEffect(scale(geometryProxy), anchor: .top)
                                .offset(y: minY(geometryProxy))
                                .offset(y: excessTop(geometryProxy))
                        }
                }
            }
            .padding(.top, 50)
        }
    }
    
    func minY( _ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
        return minY < 0 ? -minY : 0
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let val = 1.0 - (calculateCardPosition(proxy) * scale)
        return val
    }
    
    func excessTop(_ proxy: GeometryProxy, offset: CGFloat = 20) -> CGFloat {
        let p = calculateCardPosition(proxy)
        return -p * offset
    }
    
    func calculateCardPosition(_ proxy: GeometryProxy) -> CGFloat {
        if (minY(proxy) == 0) {
            return 0
        }
        
        let maximumYaxis = proxy.frame(in: .scrollView(axis: .vertical)).maxY
        let height = 200.0
        let progressCard = 1.0 - ((maximumYaxis / height))
        return progressCard
    }
}

#Preview {
    StackAnimationByAndriu()
}
