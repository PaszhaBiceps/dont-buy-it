//
//  AppButton.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct AppButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isActive: Bool
    let showDot: Bool
    let activeColor: Color
    let text: String
    let verticalPadding: CGFloat
    let action: () -> Void
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.appDarkGray : .white
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                if showDot {
                    Circle()
                        .fill(isActive ? activeColor : .appGray)
                        .frame(width: 12, height: 12)
                }

                Text(text)
                    .font(.robotoBold(14))
                    .foregroundColor(isActive ? activeColor : .appGray)
            }
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity)
        })
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isActive ? activeColor : backgroundColor,
                        lineWidth: 3)
        )
        .cornerRadius(20)
        .shadow(color: isActive ? activeColor.opacity(0.3) : .black.opacity(0.3), radius: 3)
    }
    
    init(isActive: Binding<Bool>,
         showDot: Bool = false,
         activeColor: Color,
         text: String,
         verticalPadding: CGFloat = 12,
         action: @escaping (() -> Void)) {
        _isActive = isActive
        self.showDot = showDot
        self.activeColor = activeColor
        self.text = text
        self.verticalPadding = verticalPadding
        self.action = action
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(isActive: .constant(false),
                  showDot: true,
                  activeColor: .green,
                  text: "TEXT",
                  action: {})
            .padding(.horizontal, 12)
    }
}
