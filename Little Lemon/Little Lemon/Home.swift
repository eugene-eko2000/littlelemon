//
//  Home.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("Logo")
                Spacer()
                NavigationLink(destination: UserProfile(), label: {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                })
            }
            .frame(height: 50)
            Menu()
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !UserDefaults.standard.bool(forKey: Onboarding.kIsLoggedIn) {
                dismiss()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

