//
//  ButtonStyle.swift
//  BiarFoodMac
//
//  Created by Ecc on 08/09/2023.
//

import SwiftUI

struct CustomCloseButtom: View {
    var icon : String = "xmark"
    var fontSize: Font = .title
    var funktion: () -> Void
    @State private var onHover = false
    var body: some View {
        Button{
            funktion()
        }label: {
            Image(systemName: icon)
                .font(fontSize)
                .padding(5)
                .background(onHover ? Color.primary.opacity(0.4) : Color.primary.opacity(0.15))
                .cornerRadius(8)
        }.buttonStyle(PlainButtonStyle())
            .onHover { onHover in
                withAnimation(.spring()){
                    self.onHover = onHover
                }
            }
    }
}

struct ButtonIcon_Previews: PreviewProvider {
    static var previews: some View {
        CustomCloseButtom(funktion: {})
    }
}
