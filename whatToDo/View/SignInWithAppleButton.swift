//
//  SignInWithAppleButton.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/29.
//

import Foundation
import SwiftUI
import AuthenticationServices
import Firebase

struct SignInWithAppleButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    var user = Auth.auth().currentUser
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(
            type: .signIn,
            style: (colorScheme == .dark ? .white : .black)
        )
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}
