//
//  TabButton.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct TabButton: View {
    let image: String
    let title: String
    @Binding var selectedTab: String
    var body: some View {
        
        Button(action: {
            withAnimation(.easeInOut){selectedTab = title}
        },label: {
                   VStack(spacing: 7){
                       Image(systemName: image)
                           .resizable()
                           .scaledToFit()
                           .font(.system(size: 16,weight: .semibold))
                           .foregroundColor(selectedTab == title ? .white : .gray)
                           .frame(width: 40,height: 40)
                       Text(title)
                           .font(.system(size: 11))
                           .fontWeight(.semibold)
                           .foregroundColor(selectedTab == title ? .white : .gray)
                   }

                   .padding(.vertical,8)
                   .padding(.horizontal,15)
                   

                   .contentShape(Rectangle())
                   .background(Color.primary.opacity(selectedTab == title ? 0.15 : 0))
                   .cornerRadius(10)
               
            
        })
//        .frame(height: 80)
        .buttonStyle(PlainButtonStyle())
        
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(image: "xmark", title: "Add Button", selectedTab: .constant("Add Button"))
    }
}
