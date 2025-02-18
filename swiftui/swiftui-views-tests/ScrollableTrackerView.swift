//
//  ScrollableTrackerView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 29/10/24.
//

import SwiftUI


struct ScrollableTrackerView: View {
    @State private var isScrolling = false
    @State private var scrollTimer: Timer?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100, id: \.self) { index in
                    Text("Item \(index)")
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .gesture(
                // Detecta o gesto de arraste na ScrollView
                DragGesture()
                    .onChanged { _ in
                        startScrolling()
                    }
                    .onEnded { _ in
                        scheduleStopScrolling()
                    }
            )
        }
    }
    
    // Função chamada quando o usuário começa a fazer scroll
    private func startScrolling() {
        if !isScrolling {
            isScrolling = true
            print("User started scrolling")
        }
        // Reseta o temporizador quando o usuário está fazendo scroll
        resetScrollTimer()
    }
    
    // Agendar a parada do scroll quando o gesto acabar
    private func scheduleStopScrolling() {
        scrollTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            isScrolling = false
            print("User stopped scrolling")
        }
    }
    
    // Reinicia o temporizador para evitar disparos prematuros
    private func resetScrollTimer() {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
}
