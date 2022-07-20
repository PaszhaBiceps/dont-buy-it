//
//  SplashView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 07.06.2022.
//

import SwiftUI

struct SplashView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var viewModel = SplashViewModel()
    private var navigationBinding: Binding<Bool> {
        Binding<Bool>(get: {
            return viewModel.loadingState == .finished
        }, set: { _ in })
    }
    private var errorBinding: Binding<Bool> {
        Binding<Bool>(get: {
            switch viewModel.loadingState {
            case .error:
                return true
            default:
                return false
            }
        }, set: { _ in })
    }
    private var isLoading: Bool {
        viewModel.loadingState == .loading
    }
    private var hasFailedToFetchData: Bool {
        switch viewModel.loadingState {
        case .error:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.logoSplash)
                
                switch viewModel.loadingState {
                case .loading:
                    loaderView()
                        .padding(.bottom, 50)
                case .error:
                    retryView()
                        .padding(.bottom, 50)
                default:
                    EmptyView()
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
            viewModel.fetchDataIfNeeded()
        }
        .alert("Errror",
               isPresented: errorBinding) {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            switch viewModel.loadingState {
            case .error(let message):
                Text(message)
            default:
                Text("An error occurred")
            }
        }
    }
    
    // MARK: - Views
    private func loaderView() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Text(
                    ViewStrings
                        .loadingResourceMessage
                        .localized
                )
                .font(.robotoRegular(16))
                .foregroundColor(
                    colorScheme == .dark ? .white : .black
                )
                
                ActivityIndicator(isAnimating: .constant(true),
                                  style: .medium)
            }
        }
    }
    
    private func retryView() -> some View {
        VStack {
            Spacer()
            
            VStack {
                Text(
                    ViewStrings
                        .failedToLoadReourcesMessage
                        .localized
                )
                
                Button {
                    viewModel.fetchDataIfNeeded()
                } label: {
                    Text(
                        ViewStrings
                            .retryActionTitle
                            .localized
                    ).foregroundColor(.blue)
                }.padding(.top, 3)

            }
            .padding(.bottom)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
