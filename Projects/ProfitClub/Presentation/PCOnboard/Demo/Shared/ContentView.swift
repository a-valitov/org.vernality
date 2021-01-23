//
//  ContentView.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI
import PCOnboard

struct ContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return OnboardFactory().make(output: nil).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}
