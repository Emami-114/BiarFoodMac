//
//  AddProductSidbar.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import SwiftUI

struct AddProductSidbar: View {
    @EnvironmentObject var viewModel : AddProductViewModel
    @EnvironmentObject var categoeyViewModel : CategorieViewModel

    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            Toggle("Offentlich", isOn: $viewModel.isPublic)
            Toggle("Kühlware", isOn: $viewModel.isCold)
            Toggle("Altersbeschränkung", isOn: $viewModel.adult)
            if viewModel.adult{
                Picker("Mindestalter", selection: $viewModel.minimumAge) {
                    ForEach(Adult.allCases,id: \.self) { age in
                        Text(age.title).tag(age.age)
                    }
                }
            }
            Section{
                Picker("Einheit", selection: $viewModel.unit) {
                    ForEach(viewModel.unitList,id: \.self) { unit in
                        Text(unit)
                    }
                }
            }
            
            Section{
                Picker("Steuersatz", selection: $viewModel.tax) {
                    ForEach(viewModel.taxList,id: \.self) { tax in
                        Text(tax)
                    }
                }
            }
          
           
            
                VStack(alignment: .leading){
                    Text("Produk Kategorien")
                        .foregroundColor(.gray)
                    let listMainCategory = categoeyViewModel.categories.filter { mainCat in
                        mainCat.type == "Main"
                    }
                    ScrollView(.vertical){
                        ForEach(listMainCategory,id:\.id){category in
                            CheckBoxCategory(category: category, selectedCategories: $viewModel.categorie)
                            let listSubCategory = categoeyViewModel.categories.filter { cate in
                                cate.mainId == category.id
                            }
                            
                            ForEach(listSubCategory) { subCategory in
                                HStack{
//                                    Text("-")
                                    CheckBoxCategory(category: subCategory, selectedCategories: $viewModel.categorie)
                                }.padding(.leading)
                            }
                        }
                    }
                    
                }.padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.3))
                .padding(.top)
                .frame(width: 230,height: 300)
            
        }.frame(width: 230)
    }
}

struct AddProductSidbar_Previews: PreviewProvider {
    static var previews: some View {
        AddProductSidbar()
            .environmentObject(AddProductViewModel())
            .environmentObject(CategorieViewModel())
    }
}
