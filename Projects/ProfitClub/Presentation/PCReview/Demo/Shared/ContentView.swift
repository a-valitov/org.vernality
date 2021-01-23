//
//  ContentView.swift
//  Shared
//
//  Created by Rinat Enikeev on 23.01.2021.
//

import SwiftUI
import PCReview

struct ContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ReviewFactory().make(output: nil).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
