//
//  MultiWidgetContentView.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 20/06/24.
//

import SwiftUI

struct MultiWidgetContentView<BodyContent, FooterContent>: View where BodyContent: View , FooterContent: View  {
    
    var headerText: String
    var headerLink: String? = nil
    let bodyContent: () -> BodyContent
    let footerContent: (() -> FooterContent)?
    
    init(
        headerText: String,
        headerLink: String? = nil,
        bodyContent: @escaping () -> BodyContent,
        footerContent: (() -> FooterContent)? = nil
    ) {
        self.headerText = headerText
        self.headerLink = headerLink
        self.bodyContent = bodyContent
        self.footerContent = footerContent
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(headerText)
                Spacer()
                if headerLink != nil {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.blue)
                }
            }.padding()
            
            bodyContent()
            
            footerContent?()
                .padding()
        }
        .frame(maxWidth: .infinity)
    }
}

struct MultiWidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        MultiWidgetContentView(
            headerText: "Suggestion",
            headerLink: "mercadopago://deeplink-header",
            bodyContent: {
                VStack(alignment: .leading) {
                    Text("Hello World")
                    Image(systemName: "globe.americas.fill")
                }
                .font(.largeTitle)
            }, footerContent: {
                Text("Footer HERE ! ")
                    .foregroundStyle(.red)
                    .font(.caption)
                    
            })
    }
}
