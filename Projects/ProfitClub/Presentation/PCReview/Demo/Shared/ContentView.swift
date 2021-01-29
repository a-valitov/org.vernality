//
//  ContentView.swift
//  Shared
//
//  Created by Rinat Enikeev on 23.01.2021.
//

import SwiftUI
import PCReview
import PCModel

struct ContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ReviewFactory(user: PCUserStruct()).make(output: nil).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
