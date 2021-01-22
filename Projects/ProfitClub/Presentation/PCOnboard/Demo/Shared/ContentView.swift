//
//  ContentView.swift
//  Shared
//
//  Created by Rinat Enikeev on 22.01.2021.
//

import SwiftUI
import PCOnboard

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct OnboardView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return OnboardFactory().make(output: nil).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}
