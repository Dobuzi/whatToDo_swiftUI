//
//  SignInView.swift
//  toDoList
//
//  Created by 김종원 on 2020/09/29.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack(spacing: 100) {
            if let _ = Auth.auth().currentUser?.email {
                Button(action: {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: \(signOutError)")
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Sign Out")
                })
                .frame(width: 200, height: 45)
            } else {
                SignInWithAppleButton()
                    .frame(width: 200, height: 45)
                    .onTapGesture {
                        self.coordinator = SignInWithAppleCoordinator()
                        if let coordinator = self.coordinator {
                            coordinator.startSignInWithAppleFlow {
                                print("You successfully signed in")
                                print("\(Auth.auth().currentUser?.email ?? "no email")")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
