//
//  ShortcutsContentView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 07/06/24.
//

import SwiftUI

// MARK: -  Entity to View
struct ShortcutSectionViewData: Identifiable {
    var id: String {
        UUID().uuidString
    }
    var type: String = "SHORTCUT"
    var title: String
    var items: [ShortcutItemViewData]
}

struct ShortcutItemViewData: Identifiable {
    var id: String {
        UUID().uuidString
    }
        
    var title: String
    var badge: String?
}


// MARK: -  Mock to Show
var listShortcutSections: [ShortcutSectionViewData] =
    [
        
        ShortcutSectionViewData(title: "Sugerencia 1",
                                items: [
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                ]),

        ShortcutSectionViewData(title: "Sugerencia 2",
                                items: [
                                    .init(title: "Business Shortcut", badge: "Sales!"),
                                    .init(title: "Business Shortcut"),
                                    .init(title: "Business Shortcut")
                                ]),
        
        ShortcutSectionViewData(title: "Sugerencia 3",
                                items: [
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                ]),

        ShortcutSectionViewData(title: "Sugerencia 4",
                                items: [
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                ]),

        ShortcutSectionViewData(title: "Sugerencia 5",
                                items: [
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                    .init(title: "Business Shortcut", badge: "NOVIDADE"),
                                ]),
        ShortcutSectionViewData(title: "Sugerencia 6",
                                items: [
                                    .init(title: "Business Shortcut", badge: "TEXT MUY LARGO ACA"),
                                    .init(title: "Business Shortcut"),
                                    .init(title: "Business Shortcut"),
                                    .init(title: "Business Shortcut"),
                                    .init(title: "Business Shortcut"),
                                ]),

    ]

struct ShortcutsContentView: View {
    
    @State
    private var searchText: String = ""
    
    private var listForShow: [ShortcutSectionViewData] {
        let listSearched = listShortcutSections.filter { $0.title.contains(searchText) }
        return listSearched.isEmpty ? listShortcutSections : listSearched
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listForShow) { section in
                    if section.type == "SHORTCUT" {
                        ShortcutSectionView(shorcutSection: section)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .listRowSeparator(.hidden)
            
        }
        .searchable(text: $searchText, prompt: "Digite aqui ...")
        .navigationViewStyle(StackNavigationViewStyle())
        .listRowSeparator(.hidden)
    }
}

// MARK: -  Shortcut Sections
struct ShortcutSectionView: View {
    
    private let shorcutSection: ShortcutSectionViewData
    
    init(shorcutSection: ShortcutSectionViewData) {
        self.shorcutSection = shorcutSection
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(shorcutSection.title)
                .font(.system(size: 18, weight: .bold))
                .padding(4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(shorcutSection.items) { shortcutItem in
                        ShortcutItemView(shortcutItem: shortcutItem).padding(4)
                    }
                }
            }
        }
        .onAppear {
            print("[Trying Print] ShortcutSectionView HERE IS \(self.shorcutSection.title)")
        }
        
    }
}


// MARK: -  Shortcut Item
struct ShortcutItemView: View {
    
    private let badge: String?
    private let title: String
    
    init(shortcutItem: ShortcutItemViewData) {
        self.badge = shortcutItem.badge
        self.title = shortcutItem.title
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#F5F5F5"))
                    .stroke(Color(hex: "#F5F5F5"), lineWidth: 4)
                    .frame(width: 56, height: 56)
                
                Image(.locales)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                    .foregroundColor(.blue)
                
                if let badge {
                    BadgeView(text: badge)
                        .offset(y: 28)
                }
            }
            
            Text(title)
                .font(.system(size: 12))
                .frame(width: 72, height: 30)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
        .frame(width: 72, height: 94)
    }
}

// MARK: -  Supports UI

struct BadgeView: View {
    
    private let maxWidget: CGFloat
    private let textColor: Color
    private let backgroundColor: Color
    private let text: String
    
    init(
        text: String,
        maxWidget: CGFloat = 80,
        textColor: Color = .white,
        backgroundColor: Color = Color(hex: "#009EE3")
    ) {
        self.text = text
        self.maxWidget = maxWidget
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    
    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .lineLimit(2)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(Capsule())
            .frame(maxWidth: maxWidget)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
