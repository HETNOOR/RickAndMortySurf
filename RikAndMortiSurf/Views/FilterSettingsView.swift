//
//  FilterSettingsView.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 19.07.2024.
//

import SwiftUI

struct FilterSettingsView: View {
    @ObservedObject var viewModel: CharacterListViewModel
   
    @Binding var selectedStatus: String?
    @Binding var selectedGender: String?

    let statuses = ["alive", "dead", "unknown"]
    let genders = ["female", "male", "genderless", "unknown"]
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Status")) {
                        HStack(spacing: 4) {
                            ForEach(statuses, id: \.self) { status in
                                Button(action: {
                                    selectedStatus = (selectedStatus == status) ? nil : status
                                }) {
                                    HStack {
                                        Text(status.capitalized)
                                            .foregroundColor(selectedStatus == status ? .white : .black)
                                            .font(.system(size: 12))
                                            .padding(10)
                                    }
                                    .background(selectedStatus == status ? Color.accentColor : Color.white)
                                    .cornerRadius(24)
                                    .shadow(radius: 1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(3)
                    }
                    Section(header: Text("Gender")) {
                        HStack(spacing: 4) {
                            ForEach(genders, id: \.self) { gender in
                                Button(action: {
                                    selectedGender = (selectedGender == gender) ? nil : gender
                                }) {
                                    HStack {
                                        Text(gender.capitalized)
                                            .foregroundColor(selectedGender == gender ? .white : .black)
                                            .font(.system(size: 12))
                                            .padding(10)
                                    }
                                    .background(selectedGender == gender ? Color.accentColor : Color.white)
                                    .cornerRadius(24)
                                    .shadow(radius: 1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(3)
                    }
                    
                    
                    Button(action: {
                        viewModel.status = selectedStatus
                        viewModel.gender = selectedGender
                        viewModel.search()
                        presentationMode.wrappedValue.dismiss() 
                    }, label: {
                        Text("Apply")
                            .frame(width: 200)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .bold()
                    })

                    
                    
                }
           
                
        
                
                
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "multiply")
                    .padding()
            }))
            .navigationBarItems(trailing: Button("Reset") {
                selectedStatus = nil
                selectedGender = nil
                viewModel.status = nil
                viewModel.gender = nil
                viewModel.search()
            }.padding())
        }
    }
}

struct FilterSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSettingsView(
            viewModel: CharacterListViewModel(),
            selectedStatus: .constant(nil),
            selectedGender: .constant(nil)
        )
    }
}
