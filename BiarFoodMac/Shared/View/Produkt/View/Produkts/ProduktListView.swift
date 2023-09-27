//
//  ProduktListView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct ProduktListView: View {
    @State private var searchText = ""
    @State private var showAddView = false
    @State private var showEditView = false
    @State private var showDeleteAlert = false
    @State private var selectedDeleteproduct: Product? = nil
    @EnvironmentObject var categoryViewModel : CategorieViewModel
    @StateObject var viewModel = ProductListViewModel()
    @State  var selectedProduct : Product = Product(title: "", desc: "", price: 0.0, categorie: [],brand:"",sale: false, salePrice: 0.0, unit: "", imageUrl: "", unitAmountPrice: "", tax: 0, articleNumber: "", available: false, availableAmount: 0, deposit: false, depositType: "", depositPrice: 0.0, netFillingQuantity: "", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: false,isPublic: true,adult: false,minimumAge: 0)
    
    
    @State var presentDetailView : Bool = false
    var body: some View {
        VStack {
            
            HSplitView{
                GeometryReader{proxy in
                    ScrollView{
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 5), count: proxy.size.width < 750 ? 2 : proxy.size.width < 900 ? 3 : proxy.size.width < 1100 ? 4 : 6)) {
                            ForEach(viewModel.products,id: \.id) { product in
                                ProductRow(product: product,showAlert: {
                                    selectedDeleteproduct = product
                                    showDeleteAlert.toggle()
                                })
                                    
                                    .onTapGesture {
                                        withAnimation(.easeInOut){
                                            selectedProduct = product
                                            presentDetailView = true
                                        }
                                    }
                                    
                            }
                            .alert(isPresented: $showDeleteAlert) {
                                Alert(title: Text("\(selectedDeleteproduct?.title ?? "") Delete"), primaryButton: .destructive(Text("delete"),action: {
                                    deleteAlert(with: selectedDeleteproduct?.id ?? "", imageUrl: selectedDeleteproduct?.imageUrl ?? "")
                                    
                                }), secondaryButton: .cancel())
                            }
                        }
                        .frame(minWidth: 600)
                        
                        
                        
                        
                    }.padding()
                        .frame(minWidth: 600)
                }
                
                
                
                if presentDetailView && showEditView == false {
                    ProductDetailView(product: selectedProduct,showEditView: $showEditView,showDetailView: $presentDetailView)
                        .frame(maxHeight: .infinity)
                }else if showEditView{
                    ProductEditView(product: selectedProduct, showEditView: $showEditView)
                        .environmentObject(categoryViewModel)
                        .frame(maxHeight: .infinity)

                }
                
            }
            
            .ignoresSafeArea(.all,edges: .all)

        }
        .searchable(text: $searchText)
        

    }
    func deleteAlert(with id : String,imageUrl : String){
        viewModel.deleteProduct(wit: id, imageurl: imageUrl)
    }
}

struct ProduktListView_Previews: PreviewProvider {
    static var previews: some View {
        ProduktListView(selectedProduct: .init(title: "", desc: "", price: 0.0, categorie: [],brand:"",sale: false, salePrice: 0.0, unit: "", imageUrl: "", unitAmountPrice: "", tax: 0, articleNumber: "", available: false, availableAmount: 0, deposit: false, depositType: "", depositPrice: 0.0, netFillingQuantity: "", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: false,isPublic: true,adult: true,minimumAge: 18), presentDetailView: false)
    }
}
