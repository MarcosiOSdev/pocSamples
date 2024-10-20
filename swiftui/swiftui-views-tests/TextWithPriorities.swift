//
//  TextWithPriorities.swift
//  swiftui-views-tests
//
//  Created by mfelipesp on 20/10/24.
//

import SwiftUI

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

#Preview {
    TextWithPriorities()
}
