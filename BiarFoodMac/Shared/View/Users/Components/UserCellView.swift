//
//  UserCell.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

struct UserCellView: View {
    let user: User
    var body: some View {
        HStack{
            
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(user: .init(id: "", salutation: "Herr", firstName: "Abdul Rahman", lastName: "Emami", street: "Stauffenbergstr", houseNumBer: "14", zipCode: "07747", email: "emailTest@gmail.com", rolle: "Kunden", emailConfirm: true, phoneNumber: "01236855", country: "Deutschland"))
    }
}
