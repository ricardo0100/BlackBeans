//
//  LogInViewModel.swift
//  Beans
//
//  Created by Ricardo Gehrke on 11/01/21.
//

import Foundation
import Combine

class LogInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var alert: AlertMessage?
    
    private let api: APIProtocol
    private let userSettings: UserSettings
    private var cancellables: [AnyCancellable] = []
    
    init(api: APIProtocol, userSettings: UserSettings) {
        self.api = api
        self.userSettings = userSettings
    }
    
    func onTapLogIn() {
        clearErrors()
        validateEmailField()
        validatePasswordField()
        
        if emailError == nil && passwordError == nil {
            api
                .login(email: email, password: password)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        self.handleError(error)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { user in
                    self.userSettings.saveUser(user: user)
                }.store(in: &cancellables)
        }
    }
    
    private func validateEmailField() {
        if email.isEmpty {
            emailError = "E-mail field should not be empty"
            return
        }
        if !isValidEmail(email) {
            emailError = "Inform a valid e-mail"
        }
    }
    
    private func validatePasswordField() {
        if password.isEmpty {
            passwordError = "Password field should not be empty"
            return
        }
        if password.count < 6 {
            passwordError = "Password should cointain at least 6 characters"
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func clearErrors() {
        emailError = nil
        passwordError = nil
    }
    
    private func handleError(_ error: APIError) {
        switch error {
        case .unauthorized:
            self.alert = AlertMessage(title: "Login failed!", message: "The credentials provided are incorrect.")
        case .unknown:
            break
        }
    }
}
