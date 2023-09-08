//
//  CheckBoxCategory.swift
//  BiarFoodMac
//
//  Created by Ecc on 30/08/2023.
//

import SwiftUI

struct CheckBoxCategory: View {
    let category : Category
    @Binding var selectedCategories : Set<String>
    var body: some View {
        Button{
            if selectedCategories.contains(category.id ?? ""){
                selectedCategories.remove(category.id ?? "" )
            }else{
                selectedCategories.insert(category.id ?? "")
            }
        }label: {
            HStack{
                Image(systemName: selectedCategories.contains(category.id ?? "") ? "checkmark.square.fill" : "square")
                Text(category.name)
                Spacer()
            }
        }.buttonStyle(.bordered)
    }
}

struct CheckBoxCategory_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxCategory(category: .init(mainId: "",name: "Category", desc: "", type: "Main", imageUrl: ""), selectedCategories: .constant([""]))
    }
}
