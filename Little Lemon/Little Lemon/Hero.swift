//
//  Hero.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 03.06.23.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 15)
                Text("Little lemon")
                    .foregroundColor(Color("Yellow"))
                    .font(Font.custom("MarkaziText-Regular", size: 64))
                    .fontWeight(.medium)
                Spacer()
            }
            HStack {
                Spacer()
                    .frame(width: 15)
                Text("Chicago")
                    .foregroundColor(Color("TextForeground"))
                    .font(Font.custom("MarkaziText-Regular", size: 40))
                Spacer()
            }
            HStack {
                Spacer().frame(width: 15)
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes server with a modern twist.")
                    .foregroundColor(Color("TextForeground"))
                    .font(Font.custom("Karla-VariableFont_wght.ttf", size: 18))
                    .fontWeight(.regular)
                Spacer()
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer().frame(width: 15)
            }
            Spacer()
                .frame(height: 20)
        }
        .background(Color("Green"))
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
