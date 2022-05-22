//
//  NavigationHeaderView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 22.05.2022.
//

import SwiftUI

struct NavigationHeaderView: View {
    var body: some View {
        HStack(spacing: 5) {
            Text(
                ViewStrings
                    .navigationHeaderPartOne
                    .localized
            )
                .font(.robotoBlack(14))
                .foregroundColor(.appBlue)
            
            Image(.flagIcon)
            
            Text(
                ViewStrings
                    .navigationHeaderPartTwo
                    .localized
            )
                .font(.robotoBlack(14))
                .foregroundColor(.appYellow)
        }
    }
}

struct NavigationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderView()
    }
}
