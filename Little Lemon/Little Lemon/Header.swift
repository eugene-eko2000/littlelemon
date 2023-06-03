//
//  Header.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 03.06.23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Spacer()
            Image("Logo")
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
        }
        .frame(height: 50)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
