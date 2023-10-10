//
//  CreateSliderView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI

struct CreateSliderView: View {
    @StateObject private var viewModel = SliderAddViewModel()
    @State var isHoverChoosePhoto = false
    @State var isHoverCreateButton = false
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 30){
                Image(nsImage: viewModel.selectedImage ?? NSImage())
                    .resizable()
                    .frame(minWidth: 150,minHeight: 150)
                    .frame(maxWidth: 250,maxHeight: 250)
                    .cornerRadius(25)
                
                CustumMediumButton(text: "Bild auswählen") {
                    viewModel.choosePhoto()
                }
                Toggle("Öffentlich", isOn: $viewModel.isPublic)

                TextFieldSingle(title: "Title", text: $viewModel.title)
                TextEditSingle(title: "Beschreibung", text: $viewModel.desc)
                
                    .toast(isShowing: $viewModel.uploadComplete,text: "Slider erfolgreich erstellt")
                
                UploadImageButton(text: "Slider erstellen",uploadProgress: $viewModel.uploadProgress, uploadCompletet: $viewModel.uploadComplete) {
                    Task{
                        try await viewModel.createSlider()
                        viewModel.clearFields()
                    }
                }

            }
        }.padding()
        
    }
}

struct CreateSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSliderView()
    }
}
