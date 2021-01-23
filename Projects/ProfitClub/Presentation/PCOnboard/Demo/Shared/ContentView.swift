//
//  ContentView.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI
import PCOnboard
import PCModel

struct ContentView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, OnboardModuleOutput {
        var parent: ContentView

        init(_ parent: ContentView) {
            self.parent = parent
        }

        func onboard(module: OnboardModule, didLogin user: PCUser) {
            print(user)
        }

        func onboard(module: OnboardModule, didRegister user: PCUser) {
            print(user)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ContentView>) -> UIViewController {
        return OnboardFactory().make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ContentView>) {
        print(context)
    }
}

class Coordinator {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
