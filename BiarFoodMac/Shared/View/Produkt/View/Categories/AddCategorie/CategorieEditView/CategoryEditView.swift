//
//  CategoryEditView.swift
//  BiarFoodMac
//
//  Created by Ecc on 05/09/2023.
//

import SwiftUI
import Kingfisher
struct CategoryEditView: View {
    let category: Category
    @ObservedObject var viewModel : CategoriesEditViewModel
    @Binding var showEditView : Bool
    @State private var onHoverPhoto = false
    @State private var isHover = false
    init(category: Category,showEditView: Binding<Bool>){
        self.category = category
        self.viewModel = CategoriesEditViewModel(category: category)
        self._showEditView = showEditView
    }
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 20) {
            ScrollView(.vertical){
                HStack{
                    CustomCloseButtom {
                        withAnimation(.spring()){
                            showEditView = false
                        }
                    }
                    Spacer()
                }.padding()
                
                
                if viewModel.selectedImage == nil {
                    KFImage(URL(string: category.imageUrl))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .fade(duration: 2.5)
                        .resizable()
                        .frame(width: 200,height: 200)
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
                }.padding(.vertical)
               
                
                VStack(spacing: 80){
                    TextFieldSingle(title: "Name", text: $viewModel.title)
            
                
                
                    TextEditSingle(title: "Beschreibung", text: $viewModel.description)
                        .frame(height: 80)
                
                    UploadImageButton(text: "Aktualisieren",uploadProgress: $viewModel.uploadProgress, uploadCompletet: $viewModel.uploadComplete) {
                        Task {
                            try await viewModel.updateCategory(with: category.id ?? "")
                            showEditView = false

                        }
                    }.padding(.vertical)
                
                }
            }.padding()
                .padding(.horizontal)
        }
    }
}

struct CategoryEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEditView(category: .init(mainId: "", name: "Helles Bier", desc: "", type: "", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/category_images%2FD5F32A45-7EA2-4BA8-9254-685E2BFEB9B5?alt=media&token=f4bda168-add9-49e0-961d-0afe72675e49"),showEditView: .constant(false))
    }
}
