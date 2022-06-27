//
//  NotesView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 23.05.2022.
//

import SwiftUI

struct NotesView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var viewModel = NotesViewModel()
    @Binding var dismiss: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    headerView()
                        .padding(.top, 16)
                    
                    contentScrollView()
                        .frame(maxHeight: 415)
                }
                
                closeButton()
                    .padding(.top, 10)
                    .padding(.bottom, 16)
            }.background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(
                        colorScheme == .dark ? .appDarkGray : .white
                    )
            ).padding(.horizontal, 16)
            
            Spacer()
        }
        .background(.black.opacity(0.5))
    }
    
    // MARK: - Views
    private func headerView() -> some View {
        ZStack {
            HStack {
                Text(ViewStrings.notesViewTitle.localized)
                    .font(.robotoBlack(16))
                    .foregroundColor(
                        colorScheme == .dark ? .white : .appDarkGray
                    )
            }
            
            HStack {
                Spacer()
                
                Button {
                    dismiss.toggle()
                } label: {
                    Image(.closeIcon)
                }.padding(.trailing, 16)
            }
        }
    }
    
    private func contentScrollView() -> some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            ForEach(viewModel.grades, id: \.id) { grade in
                VStack {
                    InfoLabel(color: grade.color ?? .clear,
                              text: grade.name ?? "")
                    
                    Text(grade.description ?? "")
                        .font(.robotoMedium(14))
                        .foregroundColor(colorScheme == .dark ? .white : .appDarkGray)
                }.padding(.horizontal, 16)
                    .padding(.top, 15)
            }
        }
    }
    
    private func closeButton() -> some View {
        AppButton(isActive: .constant(true),
                  activeColor: colorScheme == .dark ? .white : .appDarkGray,
                  text: ViewStrings.closeButtonTitle.localized.uppercased()) {
            dismiss.toggle()
        }.frame(width: 159)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(dismiss: .constant(false))
    }
}
