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

    class Coordinator: NSObject, UINavigationControllerDelegate, ReviewModuleOutput {
        func reviewUserWantsToLogout(module: ReviewModule) {

        }

        func reviewUserWantsToAddRole(module: ReviewModule) {

        }

        func reviewUserWantsToEnterAdmin(module: ReviewModule) {

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
        return ReviewFactory().make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ReviewView>) {
        print(context)
    }
}

