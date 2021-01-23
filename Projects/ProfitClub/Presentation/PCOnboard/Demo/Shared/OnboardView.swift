//
//  OnboardView.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI
import PCOnboard
import PCModel

struct OnboardView: UIViewControllerRepresentable {
    @Binding var user: PCUserSU?
    @Binding var appState: AppState?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, OnboardModuleOutput {
        var parent: OnboardView

        init(_ parent: OnboardView) {
            self.parent = parent
        }

        func onboard(module: OnboardModule, didLogin user: PCUser) {
            self.parent.user = user.su
            self.parent.appState = .loggedIn
        }

        func onboard(module: OnboardModule, didRegister user: PCUser) {
            self.parent.user = user.su
            self.parent.appState = .registered
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardView>) -> UIViewController {
        return OnboardFactory().make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<OnboardView>) {
        print(context)
    }
}

class Coordinator {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
