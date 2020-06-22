//
//  LoginView.swift
//  BlackBeans
//
//  Created by Ricardo Gehrke on 27/05/20.
//  Copyright © 2020 Ricardo Gehrke Filho. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let errorMessage = Text(viewModel.errorMessage ?? .empty)
            .font(.caption)
            .foregroundColor(.red)
        return Form {
            Section(footer: errorMessage) {
                TextField("E-mail", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                Button(action: viewModel.login) {
                    Text("Login")
                }
            }
            Section {
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up").foregroundColor(Color.blue)
                }
            }
        }.navigationBarTitle("Login")
            .onReceive(Persistency.currentUserPublisher) { user in
                if user != nil {
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
