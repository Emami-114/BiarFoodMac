//
//  TextFieldSingle.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct TextFieldSingle: View {
    let title: String
    @Binding var text: String
    @State private var isHover = false
    var body: some View {
        
        
        VStack(alignment: .leading,spacing: 10){
            Text(title)
            TextField(title, text: $text,prompt: Text(title))
                .font(.title3)
                .textFieldStyle(.plain)
                
                .padding(.vertical,8)
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isHover ? Color.primary.opacity(0.6) : Color.primary.opacity(0.25)))
                .onHover { onHover in
                    withAnimation(.spring()){
                        self.isHover = onHover
                    }
                }
        }
        
    }
}

struct TextEditSingle: View {
    let title: String
    @Binding var text: String
    var body: some View {
        
        VStack(alignment: .leading,spacing: 10){
            Text(title)
            
            TextEditor(text: $text)
                .font(.title3)
                .padding(.vertical,10)
                .padding(.horizontal)
                .frame(minHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.white.opacity(0.4)))
        }
        
    }
}


struct TextFieldSingle_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TextFieldSingle(title: "Title", text: .constant("Title"))
            TextEditSingle(title: "Title", text: .constant("Title"))

        }
    }
}
