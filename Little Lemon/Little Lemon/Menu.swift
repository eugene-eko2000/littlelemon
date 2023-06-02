//
//  Menu.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes server with a modern twist.")
            List {
                
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
