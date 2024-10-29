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
            
            PrintViewTrackView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("PrintView")
                }
            
            VisualEffectHorizontalExample()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("H Visual Effect")
                }
            
            UsageNavBarFakeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("NavBar SwiftUI Custom")
                }
            
            TextWithPriorities()
                .tabItem {
                Image(systemName: "house.fill")
                Text("Priority")
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
            
            BrenoContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Breno Test")
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
