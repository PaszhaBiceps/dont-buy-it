//
//  NotesView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 23.05.2022.
//

import SwiftUI

struct NotesView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var dismiss: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Text(ViewStrings.notesViewTitle.localized)
                                .font(.robotoBlack(16))
                                .foregroundColor(colorScheme == .dark ? .white : .appDarkGray)
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                dismiss.toggle()
                            } label: {
                                Image(.closeIcon)
                            }.padding(.trailing, 16)
                        }
                    }.padding(.top, 16)
                    
                    Group {
                        ForEach(Note.allCases, id: \.rawValue) { note in
                            VStack {
                                InfoLabel(color: note.color,
                                          text: note.title)
                                
                                Text(note.description)
                                    .font(.robotoMedium(14))
                                    .foregroundColor(colorScheme == .dark ? .white : .appDarkGray)
                            }.padding(.horizontal, 16)
                        }
                    }.padding(.top, 20)
                }
                
                AppButton(isActive: .constant(true),
                          activeColor: colorScheme == .dark ? .white : .appDarkGray,
                          text: ViewStrings.closeButtonTitle.localized.uppercased()) {
                    dismiss.toggle()
                }.frame(width: 159)
                    .padding(.top, 25)
                    .padding(.bottom, 16)
            }.background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(colorScheme == .dark ? .appDarkGray : .white)
            ).padding(.horizontal,16)
            
            Spacer()
        }.background(.black.opacity(0.5))
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(dismiss: .constant(false))
    }
}
