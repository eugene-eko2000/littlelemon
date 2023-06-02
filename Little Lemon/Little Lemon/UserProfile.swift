//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct UserProfile: View {

    let firstName = UserDefaults.standard.string(forKey: Onboarding.kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: Onboarding.kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: Onboarding.kEmail) ?? ""

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: Onboarding.kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
