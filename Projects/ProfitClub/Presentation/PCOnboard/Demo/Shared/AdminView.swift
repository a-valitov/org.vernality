//
//  AdminView.swift
//  Demo
//
//  Created by Rinat Enikeev on 25.01.2021.
//

import SwiftUI
import PCAdmin
import PCModel

struct AdminView: UIViewControllerRepresentable {
    @EnvironmentObject var user: PCUserSU
    @Binding var appState: AppState?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, AdminModuleOutput {
        func adminUserDidLogout(module: AdminModule) {

        }

        func adminUserWantsToChangeRole(module: AdminModule) {

        }

        var parent: AdminView

        init(_ parent: AdminView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<AdminView>) -> UIViewController {
        return AdminFactory(user: user).make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AdminView>) {
        print(context)
    }
}

