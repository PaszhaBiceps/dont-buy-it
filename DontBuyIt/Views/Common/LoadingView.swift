//
//  LoadingView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 01.06.2022.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Environment (\.colorScheme) var colorScheme
    
    let textToShow: String?
    let content: () -> Content
    private var isActivityIndicatorVisible: Bool {
        textToShow != nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .blur(radius: isActivityIndicatorVisible ? 3 : 0)
                    .allowsHitTesting(!isActivityIndicatorVisible)

                if let textToShow = textToShow {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text(textToShow)
                                    .font(.robotoMedium(20))
                                
                                ActivityIndicator(isAnimating: .constant(true),
                                                  style: .large)
                            }
                            .frame(width: geometry.size.width/2,
                                   height: geometry.size.height/5)
                            .background(Color.accentColor)
                            .foregroundColor(Color.primary)
                            .cornerRadius(20)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(textToShow: "Loading...") {
            HStack {}
        }
        
    }
}
