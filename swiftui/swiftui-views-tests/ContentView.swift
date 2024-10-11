//
//  ContentView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 20/05/24.
//

import SwiftUI

// MARK: -  Content View
struct ContentView: View {
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        
        TabView {
            
            TextWithPriorities()
                .tabItem {
                Image(systemName: "house.fill")
                Text("Priority")
            }
            
            BrenoContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Breno Test")
                }
            
            ShortcutsContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Shortcut MP")
                }
            
            HorizontalElementsToPrintContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("PrintTrack Horiz.")
                }
            
            SampleGridView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Grid View")
                }
            
            AnimationMovingView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Animation Moving")
                }
            
            AnimationFadeInOutView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Animation FadeIn and Out")
                }
        }
//        .accentColor(.green)  Set the color of the selected tab item
        .onAppear { setupTabBarAppearance() }
    }
}


extension ContentView {
    // Configure UITabBarAppearance
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        // Set background color
        appearance.backgroundColor = UIColor.systemGray6
        
        // Apply appearance settings
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Set selected item color (This is similar to `accentColor` in SwiftUI)
        UITabBar.appearance().tintColor = UIColor.systemGreen
        
        // Set unselected item color
        UITabBar.appearance().unselectedItemTintColor = UIColor.blue
    }
}

#Preview {
    TextWithPriorities()
}


struct TextWithPriorities: View {
    var body: some View {
        VStack {
            HStack {
                Text("Texto muito longo que precisa ser truncado")
                    .frame(width: 100) // Define uma largura fixa de 100
                    .lineLimit(1) // Limita a uma linha
                    .truncationMode(.tail) // Trunca no final (mostra "...")
                
                Text("Outro texto")
            }

            Divider()
            
            HStack {
                Text("Texto longo que deve respeitar o espaço")
                    .frame(width: 100) // Define uma largura fixa de 100
                    .layoutPriority(1) // Dá maior prioridade ao layout deste texto
                
                Text("Outro texto")
                    .layoutPriority(0) // Prioridade menor para esse texto
            }

            Divider()
            HStack {
                Text("Texto longo que não deve expandir")
                    .frame(width: 100) // Limita a largura
                    .fixedSize(horizontal: true, vertical: false) // Impede o redimensionamento horizontal do texto
                
                Text("Outro texto")
            }

            
        }
    }
}
