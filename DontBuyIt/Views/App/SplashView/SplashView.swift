//
//  SplashView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 07.06.2022.
//

import SwiftUI

struct SplashView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var storage: Storage
    @ObservedObject private var viewModel = SplashViewModel()
    private var navigationBinding: Binding<Bool> {
        Binding<Bool>(get: {
            switch viewModel.loadingState {
            case .finished(let error):
                if error != nil {
                    return false // FIXME: Think about proper error handling or some means to retry
                } else {
                    return true
                }
            default:
                return false
            }
        }, set: { _ in })
    }
    
    private var isLoading: Bool {
        viewModel.loadingState == .loading
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.logoSplash)
                
                if isLoading {
                    loaderView()
                        .padding(.bottom, 50)
                }
                
                NavigationLink("",
                               isActive: navigationBinding) {
                    MainView()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchDataIfNeeded(storage)
        }
    }
    
    // MARK: - Views
    private func loaderView() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Text(ViewStrings.loadingResourceMessage.localized)
                    .font(.robotoRegular(16))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                ActivityIndicator(isAnimating: .constant(true),
                                  style: .medium)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(Storage())
    }
}
