//
//  AddProduktView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI
import PhotosUI

struct AddProduktView: View {
    @StateObject var viewModel = AddProductViewModel()
    @EnvironmentObject var categoeyViewModel : CategorieViewModel
    @State private var imagePickerPresent = false
 
    

    var body: some View {

        HSplitView {
            VStack {
                    ScrollView(.vertical,showsIndicators: true) {
                        VStack(spacing: 20){
                            Image(nsImage: viewModel.selectedImage ?? NSImage())
                                .resizable()
                                .frame(maxHeight: 300)
                                .frame(maxWidth: 300)
                                .cornerRadius(20)
                            
                            mediumButton(text: "Bild auswählen") {
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
              
                            
                            addComponents1()
                            addComponents2()
                            addComponents3()
                           
                           
                            
                            
                            
                             

                            }
                            .padding()

                    }
            }.frame(maxHeight: .infinity)
            
            AddProductSidbar()
                .frame(width: 250)
                .frame(maxHeight: .infinity)
                .environmentObject(viewModel)
                .environmentObject(categoeyViewModel)
        }
          
        
        
    }
    
    @ViewBuilder
    func addComponents3() -> some View{
        Text("Nährwertdeklaration")
        Divider()
        Picker("Bezugspunkt", selection: $viewModel.bezugsPunk) {
            ForEach(viewModel.bezuspunkts,id: \.self) { bezugpunkt in
                Text(bezugpunkt)
            }
        }
        HStack{
            HStack{
                TextFieldSingle(title: "Brennwert kj*", text: $viewModel.brennwertKJ)
                TextFieldSingle(title: "Brennwert kcal*", text: $viewModel.brennwertKcal)
            }
        }
        
        HStack{
            TextFieldSingle(title: "Fett*", text: $viewModel.fett)
            TextFieldSingle(title: "davon gesättigte Fettsäuren*", text: $viewModel.fettDavonSaueren)
        }
        
        HStack{
            TextFieldSingle(title: "Kohlenhydrate*", text: $viewModel.kohlenhydrate)
            TextFieldSingle(title: "davon Zucker*", text: $viewModel.kohlenhydrateDavonZucker)
        }
        HStack{
            TextFieldSingle(title: "Eiweiß*", text: $viewModel.eiweiß)
            TextFieldSingle(title: "Salz*", text: $viewModel.salz)
        }
        TextEditSingle(title: "Zusätzliche Nährwert Information", text: $viewModel.additionallyWert)
        
        
            .toast(isShowing: $viewModel.uploadComplete)
        
        
        UploadImageButton(text: "Produkt erstellen",frameHeight: 60,uploadProgress: $viewModel.uploadProgress, uploadCompletet: $viewModel.uploadComplete) {
            Task{
                try await viewModel.createProduct()
                viewModel.resetFields()
            }
        }            .padding(.bottom,100)

        


        
        
        
    }
    
    @ViewBuilder
    func addComponents2() -> some View {
        HStack{
            HStack{
                TextFieldSingle(title: "Nettofüllmenge", text: $viewModel.nettoFullmenge)
                Text(viewModel.unit)
            }
            
            TextFieldSingle(title: "Alkoholgehalt", text: $viewModel.alkoholgehalt)
        }
        
        Picker("Nutri Score", selection: $viewModel.NutriScore) {
            ForEach(NutriScore.allCases,id: \.self) { nutri in
                Text(nutri.rawValue)
            }
        }
        
        TextEditSingle(title: "Zutaten & Allergene", text: $viewModel.zutatUndAlergie)
        TextEditSingle(title: "Lebensmittelunternehmer & Herkunftsort", text: $viewModel.productCountry)
        
    }
    
    @ViewBuilder
    func addComponents1() -> some View{
  
        
        
        
        HStack{
//            Picker("Einheit", selection: $viewModel.unit) {
//                ForEach(viewModel.unitList,id: \.self) { unit in
//                    Text(unit)
//                }
//            }
//            
//            Picker("Steuersatz", selection: $viewModel.tax) {
//                ForEach(viewModel.taxList,id: \.self) { tax in
//                    Text(tax)
//                }
//            }
        }
        
        HStack{
            TextFieldSingle(title: "Produkteinheiten", text: $viewModel.unitAnount)
            TextFieldSingle(title: "Grundeinheiten", text: $viewModel.unitGrundAnount)
            
            if !viewModel.unitAnount.isEmpty && !viewModel.unitGrundAnount.isEmpty {
                Text("\(viewModel.unitPreise())")
            }
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
            Toggle("Pfand", isOn: $viewModel.pfand)
            if viewModel.pfand {
                Picker("Pfandtyp", selection: $viewModel.pfandArt) {
                    ForEach(Pfand.allCases,id: \.self) { pfand in
                        Text(pfand.title)
                    }
                }

                TextFieldSingle(title: "Pfand Preise", text: $viewModel.pfandPreise)
            }
        }
    }
    
 
}

struct AddProduktView_Previews: PreviewProvider {
    static var previews: some View {
        AddProduktView()
            .frame(height: 1200)
            .environmentObject(CategorieViewModel())
    }
}
