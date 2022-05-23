//
//  InfoLabel.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 23.05.2022.
//

import SwiftUI

struct InfoLabel: View {
    
    let color: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(.infoIcon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 16, height: 16)
                .foregroundColor(color)
            
            Text(text)
                .font(.robotoMedium(12))
                .foregroundColor(color)
        }
    }
}

struct InfoLabel_Previews: PreviewProvider {
    static var previews: some View {
        InfoLabel(color: .red,
                  text: "Text")
    }
}
