//
//  UploadImageButton.swift
//  BiarFoodMac
//
//  Created by Ecc on 10/09/2023.
//

import SwiftUI

struct UploadImageButton: View {
    @State private var onHoverButton = false
    var text = "Erstellen"
    var frameHeight: CGFloat = 50
    @Binding var uploadProgress : Double
    @Binding var uploadCompletet : Bool
    var onCreate: () -> Void
    var body: some View {
        Button(action: {
            onCreate()
        }) {
            HStack(spacing: 20){
                if uploadProgress > 0 && uploadProgress < 1 {
                    ProgressView()
                }

                Text(text)
                    .font(.title2)
                    
            }

            .padding(.horizontal)
            .padding(.vertical,10)
            .background(onHoverButton ? Color.primary.opacity(0.4) : Color.primary.opacity(0.2))
            .cornerRadius(10)
        }
        .frame(width: uploadProgress > 0 ? 280 : 200)
        .frame(height: frameHeight)
        .cornerRadius(10)
        .buttonStyle(.plain)
        .onHover { onHover in
            withAnimation(.spring()){
                onHoverButton = onHover

            }
            
        }
        
    }
}


