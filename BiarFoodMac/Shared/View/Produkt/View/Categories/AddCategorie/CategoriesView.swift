//
//  AddCategorie.swift
//  BiarFoodMac
//
//  Created by Ecc on 25/08/2023.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var viewModel : CategorieViewModel
    @State private var selectedDeleteCategory : Category? = nil
    @State var onHoverPhoto = false
    @State var showRemoveAlert = false
    @State var showEditView = false
    @State private var isHover = false
    @State  var pickerSelected: Category
    var body: some View {
        
        HSplitView{
            createCategorieView()
                .padding()
                .frame(maxWidth: 500,maxHeight: .infinity)
            if showEditView{
                if let selectedDeleteCategory = selectedDeleteCategory{
                    CategoryEditView(category: selectedDeleteCategory,showEditView: $showEditView)
                }
                
            }else {
                categorieListView()

            }
              

        }
        .onAppear{
            viewModel.fetchCategories()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .ignoresSafeArea(.all,edges: .all)
    }
    
    @ViewBuilder
    func categorieListView() -> some View{
        
        VStack(alignment: .leading,spacing: 20){
            
            @State var listMainCategory = viewModel.categories.filter { mainCat in
                mainCat.type == "Main"
            }
            List(viewModel.mainCategories,id: \.id){category in
                    CategorieRowView(categorie: category,height: 60,showRemoveAlert: {
                        selectedDeleteCategory = category
                        showRemoveAlert.toggle()
                    }) {
                        selectedDeleteCategory = category
                        showEditView.toggle()
                        }
                

                  @State var listSubCategory = viewModel.categories.filter { cate in
                        cate.mainId == category.id
                    }
                    if !listSubCategory.isEmpty {
                        
                        ForEach(listSubCategory ,id: \.id, content: { subCat in
                            HStack{
                                Text("--")
                                CategorieRowView(categorie: subCat,height: 40,showRemoveAlert : {
                                    selectedDeleteCategory = subCat
                                    showRemoveAlert.toggle()
                                }) {
                                    selectedDeleteCategory = subCat
                                    showEditView.toggle()
                                    
                                }


                            }.padding(.horizontal)
                                
                        })
                  
                    }
                        
                }.listStyle(.plain)
                .alert(isPresented: $showRemoveAlert) {
                    Alert(title: Text("Kategorie Löschen"),
                          primaryButton: .destructive(Text("Löschen"),action: {
                        if let selectedDeleteCategory = selectedDeleteCategory{
                            viewModel.deleteCategory(wit: selectedDeleteCategory.id ?? "", imageurl: selectedDeleteCategory.imageUrl)

                        }
                    }),
                          secondaryButton: .cancel())
                }
            
            
            
            
        }
        
    }
    
    @ViewBuilder
    func createCategorieView() -> some View{
        
        VStack(alignment: .leading,spacing: 20){
            Text("Hier kannst du die Produkt-Kategorien für deinen Shop verwalten. Um die Reihenfolge der Kategorien in der Besucheransicht (Frontend) zu ändern, kannst du diese per Drag-and-drop zur gewünschten Position ziehen. Um mehr Kategorien pro Bearbeiten-Seite auflisten zu lassen, klicke bitte oben rechts auf den Link „Ansicht anpassen“.")
                .font(.footnote)
            
            VStack(alignment: .leading){
                TextFieldSingle(title: "Name", text: $viewModel.title)
                    .help("Der Name ist das, was auf deiner App angezeigt wird.")

                Text("Der Name ist das, was auf deiner App angezeigt wird.")
                    .font(.footnote)
            }
            
            VStack(alignment: .leading){
                TextEditSingle(title: "Beschreibung", text: $viewModel.description)
                    .help("Hier kannst du beschreibung von Kategorie hinzufügen")

                    .frame(maxHeight: 250)
                Text("Die Beschreibung wird standardmäßig nicht angezeigt, kann aber bei einigen Themes angezeigt werden.")
                    .font(.footnote)
            }
            
               
            
           
     

            Picker("Übergeordnete Kategorie", selection: $viewModel.selectedCategorie) {
                ForEach(viewModel.categories,id: \.id) {category  in
                    Button{
                        viewModel.selectedCategorie = category
                    }label: {
                        Text(category.name)
                    }.tag(category.self)
                   
                }
            }
           
            if let selectedImage = viewModel.selectedImage {
                    Image(nsImage: selectedImage)
                        .resizable()
                        .frame(maxHeight: 150)
                        .frame(maxWidth: 150)
                        .cornerRadius(10)
                }
           
            CustumMediumButton(text: viewModel.selectedImage == nil ? "Kategorie bild" : "Bild Löschen") {
                if viewModel.selectedImage == nil{
                    viewModel.choosePhoto()
                } else { viewModel.selectedImage = nil}
            }
            
            UploadImageButton(text: "Kategorie hinzufügen", uploadProgress: $viewModel.uploadProgress, uploadCompletet: $viewModel.uploadComplete) {
                if viewModel.selectedCategorie == Category(mainId: "",name: "", desc: "", type: "",imageUrl: ""){
                    viewModel.type = "Main"
                    Task {
                        try await viewModel.createCategorie()
                        viewModel.resetCategoryFiels()
                    }
                }else{
                    viewModel.type = "Sub"
                    Task {
                        try await viewModel.createCategorie()
                        viewModel.resetCategoryFiels()

                    }
                    
                }
            }
         
        }.padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity)

        
    }
    
}

