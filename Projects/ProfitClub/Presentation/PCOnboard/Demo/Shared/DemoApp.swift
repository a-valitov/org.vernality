//
//  DemoApp.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI
import PCFontProvider

enum AppState: Int {
    case unauthorized = 0
    case loggedIn = 1
    case registered = 2
    case admin = 3
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
                    if let user = self.user {
                        NavigationLink(
                            destination: ReviewView(appState: $appState).environmentObject(user),
                            tag: .loggedIn,
                            selection: $appState) {
                            NavigationLink(
                                destination: AdminView(appState: $appState).environmentObject(user),
                                tag: .admin,
                                selection: $appState) { EmptyView() }
                        }
                        NavigationLink(
                            destination: AddRoleView().environmentObject(user),
                            tag: .registered,
                            selection: $appState) { EmptyView() }
                    }

                }
            }.onAppear(perform: {
                PCFontProvider.loadFonts()
            })
        }
    }
}
