//
//  ReviewView.swift
//  Demo
//
//  Created by Rinat Enikeev on 23.01.2021.
//

import SwiftUI
import PCReview
import PCModel

struct ReviewView: UIViewControllerRepresentable {
    @EnvironmentObject var user: PCUserSU
    @Binding var appState: AppState?

    class Coordinator: NSObject, UINavigationControllerDelegate, ReviewModuleOutput {
        func reviewUserDidLogout(module: ReviewModule) {
            
        }

        func reviewUserWantsToAddRole(module: ReviewModule) {

        }

        func reviewUserWantsToEnterAdmin(module: ReviewModule) {
            self.parent.appState = .admin
        }

        func review(module: ReviewModule, userWantsToEnter organization: PCOrganization) {

        }

        func review(module: ReviewModule, userWantsToEnter supplier: PCSupplier) {

        }

        func review(module: ReviewModule, userWantsToEnter member: PCMember) {

        }

        var parent: ReviewView

        init(_ parent: ReviewView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ReviewView>) -> UIViewController {
        return ReviewFactory(user: self.user.any).make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ReviewView>) {
        print(context)
    }
}

