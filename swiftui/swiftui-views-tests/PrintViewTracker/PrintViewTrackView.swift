//
//  PrintViewTrackView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 27/10/24.
//

import SwiftUI

struct PrintViewTrackView: View {
    @State private var items: [ListItem] = (0...50).map {
        ListItem(id: "\($0)", title: "Item \($0)")
    }
    @State private var visibleItems: Set<String> = []
    
    var body: some View {
        NavigationStack {
            VStack {
                VListVisibleItemsTracking(items: items, visibleItems: $visibleItems) { item in
                    
                    if let idInt = Int(item.id), idInt % 2 == 0 {
                        HorizontalCardView()
                    } else {                        
                        ItemView(item: item)
                    }
                }
                
                // View para mostrar os itens visíveis (debug)
                VStack {
                    Text("Itens visíveis: \(visibleItems.count)")
                    Text(visibleItems.sorted().joined(separator: ", "))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            .navigationTitle("Print View")
        }
    }
}

// Modelo de dados para representar um item rastreável
protocol TrackableItem: Identifiable {
    var id: String { get }
}

// View wrapper para lista com rastreamento
struct VListVisibleItemsTracking<Data: RandomAccessCollection, Content: View>: View where Data.Element: TrackableItem {
    let items: Data
    let content: (Data.Element) -> Content
    @Binding var visibleItems: Set<String>
    
    init(
        items: Data,
        visibleItems: Binding<Set<String>>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.items = items
        self._visibleItems = visibleItems
        self.content = content
    }
    
    var body: some View {
        GeometryReader(content: { proxyVStack in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .modifier(VListVisibilityTracker(id: item.id, sizeParent: proxyVStack.frame(in: .global)))
                    }
                }
            }
            .onPreferenceChange(VisibleItemsPreferenceKey.self) { value in
                visibleItems = value
            }
        })
    }
}
// View modifier to tracker visibility of view
struct VListVisibilityTracker: ViewModifier {
    let id: String
    let sizeParent: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: VisibleItemsPreferenceKey.self,
                            value: isItemVisible(geometry) ? [id] : []
                        )
                }
            )
    }
    
    private func isItemVisible(_ geometry: GeometryProxy) -> Bool {
        let frame = geometry.frame(in: .global)
        let maxFrame = frame.minY + frame.size.height
        
        print("Sizes: id=\(id), item da lista=\(frame.size), item.minY=\(frame.minY), item.maxY=\(frame.maxY), parent.minY \(sizeParent.minY), parent.maxY=\(sizeParent.maxY), maxFrame=\(maxFrame)")
        
        return maxFrame <= sizeParent.maxY && frame.minY >= sizeParent.minY
    }
}


struct VisibleItemsPreferenceKey: PreferenceKey {
    static var defaultValue: Set<String> = []
    
    static func reduce(value: inout Set<String>, nextValue: () -> Set<String>) {
        value.formUnion(nextValue())
    }
}



extension UIApplication {
    var tabBarHeight: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let tabBarHeight = window?.safeAreaInsets.bottom ?? 0 + 49
        return tabBarHeight
    }
}
