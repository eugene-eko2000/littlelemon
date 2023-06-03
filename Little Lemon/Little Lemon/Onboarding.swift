//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false

    static let kFirstName = "first_name_key"
    static let kLastName = "last_name_key"
    static let kEmail = "email_key"
    static let kIsLoggedIn = "is_logged_in"

    func isValidEmail() -> Bool {
        let emailRegex = try! Regex("^[a-zA-Z0-9.!#$%&'*+=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$")
        if let _ = try! emailRegex.wholeMatch(in: email) {
            return true
        }
        return false
    }
    
    var body: some View {
        Header()
        NavigationView{
            VStack {
                NavigationLink(isActive: $isLoggedIn, destination: { Home() }) {
                    EmptyView()
                }
                Hero()
                Form{
                    TextField("First Name", text: $firstName)
                        .autocorrectionDisabled(true)
                    TextField("Last Name", text: $lastName)
                        .autocorrectionDisabled(true)
                    TextField("email", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    Button("Register") {
                        if !firstName.isEmpty && !lastName.isEmpty && isValidEmail() {
                            UserDefaults.standard.set(firstName, forKey: Onboarding.kFirstName)
                            UserDefaults.standard.set(lastName, forKey: Onboarding.kLastName)
                            UserDefaults.standard.set(email, forKey: Onboarding.kEmail)
                            UserDefaults.standard.set(isLoggedIn, forKey: Onboarding.kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .onAppear {
                isLoggedIn = UserDefaults.standard.bool(forKey: Onboarding.kIsLoggedIn)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
