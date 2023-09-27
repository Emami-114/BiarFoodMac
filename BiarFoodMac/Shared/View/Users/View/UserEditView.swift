//
//  UserEditView.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

struct UserEditView: View {
    let user: User
    @ObservedObject private var viewModel : UserEditViewModel
    @Binding var showEditView : Bool
    init(user: User,showEditView: Binding<Bool>){
        self.user = user
        self._showEditView = showEditView
        self.viewModel = UserEditViewModel(user: user)
    }
    var body: some View {
        VStack(spacing: 20){
            HStack{
                SmallButton(icon: "xmark", fontSize: .title.bold()) {
                    withAnimation(.spring()){
                        showEditView = false
                    }
                }
                Spacer()
            }
            Spacer()
            HStack(spacing: 15){
                TextFieldSingle(title: "Vorname", text: $viewModel.firstName)
                TextFieldSingle(title: "Nachname", text: $viewModel.lastName)
            }
            HStack(spacing: 15){
                TextFieldSingle(title: "E-mail", text: $viewModel.email)
                TextFieldSingle(title: "Telefon-Nummer", text: $viewModel.phoneNumber)
            }
            HStack(spacing: 15){
                Picker("Anrede", selection: $viewModel.salutation) {
                    ForEach(viewModel.salutationList,id: \.self) { salutation in
                        Text(salutation).tag(salutation)
                    }
                }
                Picker("Rolle", selection: $viewModel.rolle) {
                    ForEach(viewModel.rolleList,id: \.self) { rolle in
                        Text(rolle).tag(rolle)
                    }
                }
                
            }
            
            HStack(spacing: 15){
                TextFieldSingle(title: "Starße", text: $viewModel.street)
                TextFieldSingle(title: "Hausnummer", text: $viewModel.houseNumber)
            }
            HStack(spacing: 15){
                TextFieldSingle(title: "PLZ", text: $viewModel.zipCode)
                TextFieldSingle(title: "Land / Region", text: $viewModel.country)
            }
            Toggle("Email Bestätigung", isOn: $viewModel.emailConfirm)
                .font(.title2)
            
            mediumButton(text: "Updaten") {
                viewModel.updateUser(with: user.id)
                showEditView = false
            }
            Spacer()
        }.padding()
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView(user: .init(id: "", salutation: "Herr", firstName: "Abdul Rahman", lastName: "Emami", street: "Stauffenbergstr", houseNumBer: "14", zipCode: "07747", email: "emailTest@gmail.com", rolle: "Kunden", emailConfirm: true, phoneNumber: "01236855", country: "Deutschland"),showEditView: .constant(false))
    }
}
