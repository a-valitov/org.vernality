//
//  AddRoleView.swift
//  Demo
//
//  Created by Rinat Enikeev on 23.01.2021.
//

import SwiftUI
import PCAddRole
import PCModel

struct AddRoleView: UIViewControllerRepresentable {
    @EnvironmentObject var user: PCUserSU

    class Coordinator: NSObject, UINavigationControllerDelegate, AddRoleModuleOutput {
        func addRole(module: AddRoleModule, didAddSupplier supplier: PCSupplier) {

        }

        func addRole(module: AddRoleModule, didAddOrganization organization: PCOrganization) {

        }

        func addRole(module: AddRoleModule, didAddMember member: PCMember) {

        }

        var parent: AddRoleView

        init(_ parent: AddRoleView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<AddRoleView>) -> UIViewController {
        return AddRoleFactory(user: self.user).make(output: context.coordinator).viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AddRoleView>) {
        print(context)
    }
}

