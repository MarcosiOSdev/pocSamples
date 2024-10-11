//
//  BrenoContentView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 07/06/24.
//

import SwiftUI

struct BrenoContentView: View {
    private var data  = Array(1...20)
    private let adaptiveColumn = [
        GridItem(.flexible(minimum: 170, maximum: 220)),
        GridItem(.flexible(minimum: 170, maximum: 220))
    ]
    
    private let urlImage = URL(string: "https://s2.glbimg.com/2-Xq_4WE5gZarSJ6sjLBZ20BgsE=/600x0/filters:quality(70)/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2021/w/d/pPWpQOTJus3u4DeVyADQ/bolo-de-cenoura.jpg")!
    
    
        
        var body: some View {
            ScrollView{
                LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        AsyncImage(url: urlImage) { phase in
                            switch phase {
                            case .empty:
                                Color.gray
                            case .success(let image):
                                setupImage(image: image)
                            case .failure:
                                Color.gray
                            @unknown default:
                                Color.gray
                            }
                        }
                        
                    }
                }
                
            } .padding()
        }
    
    @ViewBuilder
    func setupImage(image: Image) -> some View {
        ZStack(alignment: .topTrailing) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:170, height: 220)
                .cornerRadius(10)
                .clipped()
                .allowsHitTesting(false)
            
            Button(action: {
                print("I GOT IT !")
            }, label: {
                Image(systemName: "ellipsis.circle.fill")
            })
            .foregroundStyle(.white)
            .padding(8)
        }
    }
}

#Preview {
    BrenoContentView()
}
