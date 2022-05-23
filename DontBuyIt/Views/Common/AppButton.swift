//
//  AppButton.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct AppButton: View {
    enum ActiveColor {
        case green
        case red
        case black
        
        var actualColor: Color {
            switch self {
            case .green:
                return .appGreen
            case .red:
                return .appRed
            case .black:
                return .black
            }
        }
        
        var dotIconName: String {
            switch self {
            case .green:
                return .greenDotIcon
            case .red:
                return .redDotIcon
            case .black:
                return .grayDotIcon
            }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    let action: () -> Void
    let showDot: Bool
    let activeColor: ActiveColor
    let text: String
    @Binding var isActive: Bool
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.appDarkGray : .white
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                if showDot {
                    Image(
                        isActive ? activeColor.dotIconName : .grayDotIcon
                    )
                }

                Text(text)
                    .font(.robotoBold(14))
                    .foregroundColor(isActive ? activeColor.actualColor : .appGray)
            }
            .padding(12)
        })
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isActive ? activeColor.actualColor : backgroundColor,
                        lineWidth: 3)
        )
        .cornerRadius(20)
        .shadow(color: isActive ? activeColor.actualColor.opacity(0.3) : .black.opacity(0.3), radius: 3)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(action: {},
                  showDot: true,
                  activeColor: .red,
                  text: "TEXT",
                  isActive: .constant(true))
    }
}
