////
////  RecipesBookView.swift
////  Receitas
////
////  Created by Jully Nobre on 02/05/24.
////  Copyright © 2024 Globo.com. All rights reserved.
////
//
//import SwiftUI
////import NetworkClient
////import LegacyDesignSystem
//
//struct Recipe: Identifiable {
//    var id = UUID()
//    var name: String
//    var imageName: String
//}
//
//struct RecipesBookView: View {
//    
////    @ObservedObject var viewModel = RecipesBookViewModel()
//    @State var showMenu = false
//    
//    private let fixedColumn = [
////        GridItem(.adaptive(minimum: 170, maximum: 170))
//        GridItem(.flexible(minimum: 170)),
//        GridItem(.flexible(minimum: 170))
//    ]
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: fixedColumn, spacing: 10) {
//                    ForEach(viewModel.savedRecipes, id: \.id) { recipe in
//                        VStack (alignment: .leading) {
//                            HStack{
//                                Spacer()
//                                Menu {
//                                    Button("Compartilhar", action: placeOrder)
//                                    Button(action: {
//                                        viewModel.removeRecipe(byId: recipe.id)
//                                    }) {
//                                        Text("Remover")
//                                    }
//                                } label: {
//                                    Text(Image(systemName: "ellipsis"))
//                                        .frame(width: 36, height: 36)
//                                        .background(
//                                            Circle()
//                                                .fill(Color(UIColor(white: 1, alpha: 0.4)))
//                                        )
//                                        .foregroundColor(.white)
//                                    
//                                }.padding()
//                            }
//                            Spacer()
//                            Text(recipe.title ?? "")
//                                .foregroundColor(.white)
//                                .font(Font(FontComponent.book50))
//                                .padding()
//                        }
//                        .frame(width: 170, height: 220)
//                        .background(
//                            ZStack{
////                                AsyncImage(url: URL(string: recipe.image!)) { phase in
////                                    if let image = phase.image {
////                                        image.resizable()
////                                            .scaledToFill()
////                                            .frame(width:170, height: 220)
////                                            .clipped()
////                                            .cornerRadius(10)
////                                    } else {
////                                        Color.gray
////                                    }
////                                }
//                                
//                                AsyncImage(url: URL(string: recipe.image!)) { phase in
//                                    switch phase {
//                                    case .empty:
//                                        Color.gray
//                                    case .success(let image):
////                                        showMenu = true
//                                        image.resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .cornerRadius(10)
//                                            .clipped()
//                                            .frame(width:170, height: 220)
//                                    case .failure:
//                                        Color.gray
//                                    @unknown default:
//                                        Color.gray
//                                    }
//                                }
//                                
//                                LinearGradient(colors: [Color(UIColor(white: 1, alpha: 0)), .black], startPoint: .top, endPoint: .bottom)
//                                .cornerRadius(10)
//                            }
//                        )
//                    }
//                }.padding()
//            }
//            .padding(.top)
//        }.navigationTitle("livro de receitas")
//            .onAppear{
//                viewModel.loadSavedRecipes()
//            }
//    }
//    
//    func placeOrder() { }
//}
//
//#Preview {
//    RecipesBookView()
//}
