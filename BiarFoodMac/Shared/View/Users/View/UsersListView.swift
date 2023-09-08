//
//  UsersListView.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel = UsersViewModel()
    @State private var selectedUser : User? = nil
    @State private var showEditView = false
    @State private var showAlert = false
    var body: some View {
        HSplitView {
            Table(viewModel.users ?? []) {
                TableColumn("Anrede", value: \.salutation)
                TableColumn("Vorname", value: \.firstName)
                TableColumn("Nachname", value: \.lastName)
                TableColumn("Email", value: \.email)
                TableColumn("E-mail Bestätig"){user in
                    if user.emailConfirm{Text("Ja")}else {Text("Nein")}}
                TableColumn("Rolle", value: \.rolle)
                TableColumn("Bearbeiten") { use in
                    HStack(spacing: 10){
                        ButtonIcon(icon:"square.and.pencil",fontSize: .title2){
                            self.selectedUser = use
                            self.showEditView = true
                        }.help("Benutzer Bearbeiten")
                        ButtonIcon(icon: "trash.fill", fontSize: .title2){
                            self.selectedUser = use
                            self.showAlert.toggle()
                        }.help("Benutzer Löschen")
                    }
                }
            }.tableStyle(.bordered)
            if showEditView{
                if let selectedUser = selectedUser{
                    UserEditView(user: selectedUser, showEditView: $showEditView)
                        .frame(minWidth: 400,maxWidth: 600)
                        .frame(maxHeight: .infinity)

                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Benutzer Löschen"), primaryButton: .destructive(Text("Löschen"),action: {
                if let selectedUser = selectedUser {
                    viewModel.deleteUser(with: selectedUser.id)
                }
            }), secondaryButton: .cancel())
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
