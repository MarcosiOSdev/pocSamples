//
//  AnimationStackView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 01/11/24.
//

import SwiftUI

import SwiftUI

struct CardModel: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}

struct StackCardsView: View {
    @State private var scrollOffset: CGFloat = 0
    private let cardHeight: CGFloat = 200
    private let minimizedCardHeight: CGFloat = 60
    private let maxVisibleCards: Int = 5
    private let cardSpacing: CGFloat = 20
    
    let cards: [CardModel] = [
        CardModel(title: "Card Banking", color: .blue),
        CardModel(title: "Card Compound", color: .green),
        CardModel(title: "Card Tarjetas", color: .gray),
        CardModel(title: "Card Activities", color: .pink),
        CardModel(title: "Card Anyway", color: .blue),
        CardModel(title: "Card Tarjetas 2", color: .gray),
        CardModel(title: "Card Compound 2", color: .green)
    ]
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named("scroll")).minY
                )
            }
            .frame(height: 0)
            
            LazyVStack(spacing: cardSpacing) {
                ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                    ASCardView(cardModel: card)
                        .frame(height: cardHeight)
                        .zIndex(Double(cards.count - index))
                        .modifier(StackCardModifier(
                            index: index,
                            scrollOffset: scrollOffset,
                            maxVisibleCards: maxVisibleCards,
                            cardHeight: cardHeight,
                            minimizedHeight: minimizedCardHeight,
                            topPadding: geometry?.safeAreaInsets.top ?? 0
                        ))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = -value
        }
    }
    
    @MainActor
    private var geometry: GeometryProxy? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController?.view as? GeometryProxy
    }
}

struct ASCardView: View {
    let cardModel: CardModel
    
    var body: some View {
        ZStack {
            cardModel.color
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            
            Text(cardModel.title)
                .font(.title2.bold())
                .foregroundColor(.white)
        }
    }
}

struct StackCardModifier: ViewModifier {
    let index: Int
    let scrollOffset: CGFloat
    let maxVisibleCards: Int
    let cardHeight: CGFloat
    let minimizedHeight: CGFloat
    let topPadding: CGFloat
    
    private var threshold: CGFloat {
        cardHeight * 0.5
    }
    
    private var stackPosition: Int {
        min(index, maxVisibleCards - 1)
    }
    
    private func calculateTransform() -> (scale: CGFloat, yOffset: CGFloat, opacity: Double) {
        let baseOffset = cardHeight * CGFloat(index)
        let relativeOffset = scrollOffset - baseOffset
        
        if relativeOffset > threshold {
            let stackIndex = CGFloat(stackPosition)
            let scale = max(1.0 - (stackIndex * 0.05), 0.85)
            let yOffset = topPadding + (minimizedHeight * stackIndex)
            let opacity = max(1.0 - (stackIndex * 0.2), 0.5)
            
            return (scale, yOffset, opacity)
        }
        
        return (1.0, 0, 1.0)
    }
    
    func body(content: Content) -> Content {
        let transform = calculateTransform()
        
        return content
            .scaleEffect(transform.scale)
            .offset(y: transform.yOffset)
            .opacity(transform.opacity)
            .animation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 20, initialVelocity: 0), value: transform.yOffset) as! StackCardModifier.Content
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    StackCardsView()
}
