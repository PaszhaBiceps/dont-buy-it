//
//  NotesView.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 23.05.2022.
//

import SwiftUI

struct NotesView: View {
    
    enum Note: String, CaseIterable {
        case temporarySuspended
        case reductionOfBusiness
        case suspensionOfInvestments
        case workInTheCountryOfAgressor
        case russianBrand
        
        var color: Color {
            switch self {
            case .temporarySuspended:
                return .appGreen
            case .reductionOfBusiness,
                    .suspensionOfInvestments:
                return .appYellow
            case .workInTheCountryOfAgressor,
                    .russianBrand:
                return .appRed
            }
        }
        
        var title: String {
            switch self {
            case .temporarySuspended:
                return ViewStrings
                    .temprorarySuspendedTitle
                    .localized
            case .reductionOfBusiness:
                return ViewStrings
                    .reductionOfBusinessTitle
                    .localized
            case .suspensionOfInvestments:
                return ViewStrings
                    .suspensionOfInvestmentsTitle
                    .localized
            case .workInTheCountryOfAgressor:
                return ViewStrings
                    .workInTheCountryOfTheAggressorTitle
                    .localized
            case .russianBrand:
                return ViewStrings
                    .russianBrandTitle
                    .localized
            }
        }
        
        var description: String {
            switch self {
            case .temporarySuspended:
                return ViewStrings
                    .temporarySuspendedDescription
                    .localized
            case .reductionOfBusiness:
                return ViewStrings
                    .reductionOfBusinessDescription
                    .localized
            case .suspensionOfInvestments:
                return ViewStrings
                    .suspensionOfInvestmentsDescription
                    .localized
            case .workInTheCountryOfAgressor:
                return ViewStrings
                    .workInTheCountryOfTheAggressorDescription
                    .localized
            case .russianBrand:
                return ViewStrings
                    .russianBrandDescritpion
                    .localized
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Text(ViewStrings.notesViewTitle.localized)
                                .font(.robotoBlack(16))
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                
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
                            }.padding(.horizontal, 16)
                        }
                    }.padding(.top, 20)
                }
                
                AppButton(isActive: .constant(true),
                          activeColor: .black,
                          text: ViewStrings.closeButtonTitle.localized.uppercased()) {
                    
                }.frame(width: 159)
                    .padding(.top, 25)
                    .padding(.bottom, 16)
            }.background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
            ).padding(.horizontal,16)
            
            Spacer()
        }.background(.black.opacity(0.5))
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
