//
//  ButtonConfirm.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

struct ButtonConfirm: View {
    @State private var isHover = false
    var text = "Erstellen"
    var onCreate: () -> Void
    var body: some View {
        Button{
            onCreate()
        }label: {
            VStack{
                Text(text)
                
            }
                .frame(minWidth: 60,maxWidth: 160)
                .frame(height: 50,alignment: .center)
            
                .background(isHover ? Color.primary.opacity(0.5) : Color.primary.opacity(0.2))
                .cornerRadius(10)

        }.buttonStyle(PlainButtonStyle())
            .onHover { isHover in
                withAnimation(.spring()){
                    self.isHover = isHover
                    
                }
            }
    }
}


struct ButtonConfirm_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConfirm(onCreate: {})
    }
}
