//
//  ProductEditView.swift
//  BiarFoodMac
//
//  Created by Ecc on 24/08/2023.
//

import SwiftUI
import Kingfisher
struct ProductEditView: View {
    @ObservedObject var viewModel : ProductsEditViewModel
    @EnvironmentObject var categoriesViewModel : CategorieViewModel
    @Binding var showEditView : Bool
    @State private var imagePickerPresent = false
    @State var onHoverButton = false
    @State var onHoverPhoto = false
    let product : Product
    init(product: Product,showEditView: Binding<Bool>) {
        self.product = product
        self.viewModel = ProductsEditViewModel(product: product)
        self._showEditView = showEditView
    }

    var body: some View {
        VStack {
            HStack{
                CustomCloseButtom {
                    withAnimation(.spring()){
                        showEditView = false
                    }
                }
                Spacer()
            }.padding()
            ScrollView(.vertical,showsIndicators: true) {
                VStack(spacing: 20){
                    if viewModel.selectedImage == nil {
                        KFImage(URL(string: product.imageUrl))
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 2.5)
                            .resizable()
                            .frame(maxWidth: 400,maxHeight: 400)
                            .cornerRadius(25)
                        .clipped()
                        
                    }else{
                        Image(nsImage: viewModel.selectedImage ?? NSImage())
                            .resizable()
                            .frame(maxHeight: 300)
                            .frame(maxWidth: 300)
                            .cornerRadius(20)
                    }
                    CustumMediumButton(text: "Foto ändern") {
                        viewModel.choosePhoto()
                    }
                    

                    TextFieldSingle(title: "Produktname", text: $viewModel.title)
                    TextEditSingle(title: "Produktbeschreibung", text: $viewModel.description)
                    Toggle("Angebote", isOn: $viewModel.sale)

                    HStack{
                        TextFieldSingle(title: "Marke", text: $viewModel.brand)
                        TextFieldSingle(title: "Regulärer Preis (€)", text: $viewModel.price)
                        if viewModel.sale {
                            TextFieldSingle(title: "Angebotspreis (€)", text: $viewModel.salePrice)
                        }
                    }
                   
                    VStack(alignment: .leading){

                        ScrollView(.vertical){
                            ForEach(categoriesViewModel.mainCategories,id:\.id){category in
                                CheckBoxCategory(category: category, selectedCategories: $viewModel.categorie)
                                let listSubCategory = categoriesViewModel.categories.filter { cate in
                                    cate.mainId == category.id
                                }

                                ForEach(listSubCategory) { subCategory in
                                    HStack{
                                        Text("-")
                                        CheckBoxCategory(category: subCategory, selectedCategories: $viewModel.categorie)
                                    }
                                }
                            }
                        }
                    }.frame(width: 250,height: 200)




                    addComponents1()
                    addComponents2()
                    addComponents3()







                    }
                    .padding()

//                .frame(minWidth: 600)
//                .padding(.leading,50)
            }
        }.frame(minWidth: 500)
            .background(BlurView().ignoresSafeArea(.all,edges: .all))
            .animation(.spring(),value: showEditView)


    }

    @ViewBuilder
    func addComponents3() -> some View{
        Text("Nährwertdeklaration")
        Divider()
        Picker("Bezugspunkt", selection: $viewModel.referencePoint) {
            ForEach(viewModel.bezuspunkts,id: \.self) { bezugpunkt in
                Text(bezugpunkt)
            }
        }
        HStack{
            HStack{
                TextFieldSingle(title: "Brennwert kj*", text: $viewModel.calorificKJ)
                TextFieldSingle(title: "Brennwert kcal*", text: $viewModel.caloricValueKcal)
            }
        }

        HStack{
            TextFieldSingle(title: "Fett*", text: $viewModel.fat)
            TextFieldSingle(title: "davon gesättigte Fettsäuren*", text: $viewModel.fatFromSour)
        }

        HStack{
            TextFieldSingle(title: "Kohlenhydrate*", text: $viewModel.carbohydrates)
            TextFieldSingle(title: "davon Zucker*", text: $viewModel.CarbohydratesFromSugar)
        }
        HStack{
            TextFieldSingle(title: "Eiweiß*", text: $viewModel.protein)
            TextFieldSingle(title: "Salz*", text: $viewModel.salt)
        }
        TextEditSingle(title: "Zusätzliche Nährwert Information", text: $viewModel.additionallyWert)

        UploadImageButton(text: "Aktualisieren",uploadProgress: $viewModel.uploadProgress, uploadCompletet: $viewModel.uploadComplete) {
            Task{
                try await viewModel.updateProduct(with: product.id)
                showEditView = false
//                viewModel.resetFields()
            }
        }
       
        .padding(.bottom,100)

    }

    @ViewBuilder
    func addComponents2() -> some View {
        HStack{
            HStack{
                TextFieldSingle(title: "Nettofüllmenge", text: $viewModel.netFillingQuantity)
                Text(viewModel.unit)
            }

            TextFieldSingle(title: "Alkoholgehalt", text: $viewModel.alcoholicContent)
        }

        Picker("Nutri Score", selection: $viewModel.nutriScore) {
            ForEach(NutriScore.allCases,id: \.self) { nutri in
                Text(nutri.rawValue).tag(nutri.rawValue)
            }
        }

        TextEditSingle(title: "Zutaten & Allergene", text: $viewModel.ingredientsAndAlegy)
        TextEditSingle(title: "Lebensmittelunternehmer & Herkunftsort", text: $viewModel.madeIn)

    }

    @ViewBuilder
    func addComponents1() -> some View{
        Toggle("Altersbeschränkung", isOn: $viewModel.adult)
        if viewModel.adult{
            Picker("Mindestalter", selection: $viewModel.minimumAge) {
                ForEach(Adult.allCases,id: \.self) { age in
                    Text(age.title).tag(age.age)
                }
            }
        }
        HStack{
            Picker("Einheit", selection: $viewModel.unit) {
                ForEach(viewModel.unitList,id: \.self) { unit in
                    Text(unit)
                }
            }

            Picker("Steuersatz", selection: $viewModel.tax) {
                ForEach(viewModel.taxList,id: \.self) { tax in
                    Text(tax)
                }
            }
        }

        HStack{
            TextFieldSingle(title: "Produkteinheiten", text: $viewModel.unitAnount)
            TextFieldSingle(title: "Grundeinheiten", text: $viewModel.unitGrundAnount)

//            if !viewModel.unitAnount.isEmpty && !viewModel.unitGrundAnount.isEmpty {
//                Text("\(viewModel.unitAmountPrice())")
//            }
        }

        HStack{
            TextFieldSingle(title: "Artikelnummer", text: $viewModel.articleNumber)
            Picker("Lagerbestand", selection: $viewModel.available) {
                Text("Vorrätig").tag(true)
                Text("Begrenzt").tag(false)
            }
            if !viewModel.available{
                TextFieldSingle(title: "Menge", text: $viewModel.availableAmount)

            }

        }

        HStack{
            Toggle("Pfand", isOn: $viewModel.deposit)
            if viewModel.deposit {
                Picker("Pfandtyp", selection: $viewModel.depositType) {
                    ForEach(Pfand.allCases,id: \.self) { pfand in
                        Text(pfand.title).tag(pfand.title)
                    }
                }

                TextFieldSingle(title: "Pfand Preise", text: $viewModel.depositPrice)
            }
        }
    }
}

struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditView(product: .init(title: "", desc: "", price: 0.0, categorie:[],brand: "",sale: false, salePrice: 0.0, unit: "", imageUrl: "", unitAmountPrice: "", tax: 0, articleNumber: "", available: false, availableAmount: 0, deposit: false, depositType: "", depositPrice: 0.0, netFillingQuantity: "", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: false,isPublic: true,adult: false,minimumAge: 0),showEditView: .constant(false))
            .environmentObject(CategorieViewModel())
    }
}
