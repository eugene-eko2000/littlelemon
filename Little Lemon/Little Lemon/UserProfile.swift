//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct UserProfile: View {

    @State var firstName =
        UserDefaults.standard.string(forKey: Onboarding.kFirstName) ?? ""
    @State var lastName =
        UserDefaults.standard.string(forKey: Onboarding.kLastName) ?? ""
    @State var email =
        UserDefaults.standard.string(forKey: Onboarding.kEmail) ?? ""

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("Logo")
            VStack(alignment: .leading) {
                Text("Personal Information")
                    .font(Font.custom("Karla-Bold", size: 24))
                    .bold()
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                TextField("First Name", text: $firstName)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(.roundedBorder)
                TextField("Last Name", text: $lastName)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(.roundedBorder)
                TextField("email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(.roundedBorder)
            }
            VStack(alignment: .center) {
                HStack {
                    Button("Save changes") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: Onboarding.kFirstName)
                            UserDefaults.standard.set(lastName, forKey: Onboarding.kLastName)
                            UserDefaults.standard.set(email, forKey: Onboarding.kEmail)
                            dismiss()
                        }
                    }
                    .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .foregroundColor(Color("TextForeground"))
                    .background(Color("Green"))
                    .cornerRadius(20)
                    .padding(.top, 10)
                    Spacer()
                        .frame(width: 15)
                    Button("Dismiss") {
                        dismiss()
                    }
                    .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .foregroundColor(Color("TextForeground"))
                    .background(Color("Green"))
                    .cornerRadius(20)
                    .padding(.top, 10)
                    Spacer()
                        .frame(width: 15)
                    Button("Log Out") {
                        UserDefaults.standard.set(false, forKey: Onboarding.kIsLoggedIn)
                        dismiss()
                    }
                    .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .foregroundColor(.black)
                    .background(Color("Yellow"))
                    .cornerRadius(20)
                    .padding(.top, 10)
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
