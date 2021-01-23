//
//  DemoApp.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI

enum AppState: Int {
    case unauthorized = 0
    case loggedIn = 1
    case registered = 2
}

@main
struct DemoApp: App {
    @State private var user: PCUserSU?
    @State private var appState: AppState? = .unauthorized

    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    OnboardView(user: $user, appState: $appState)
                    NavigationLink(
                        destination: ReviewView(),
                        tag: .loggedIn,
                        selection: $appState) { EmptyView() }
                    NavigationLink(
                        destination: AddRoleView(),
                        tag: .registered,
                        selection: $appState) { EmptyView() }
                }
            }
        }
    }
}
