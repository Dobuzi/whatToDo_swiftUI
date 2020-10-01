//
//  whatToDoApp.swift
//  whatToDo
//
//  Created by 김종원 on 2020/09/30.
//

import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if Auth.auth().currentUser?.email == nil {
            Auth.auth().signInAnonymously()
            print(Auth.auth().currentUser?.email ?? "no email")
        }
        return true
    }
}

@main
struct whatToDoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
