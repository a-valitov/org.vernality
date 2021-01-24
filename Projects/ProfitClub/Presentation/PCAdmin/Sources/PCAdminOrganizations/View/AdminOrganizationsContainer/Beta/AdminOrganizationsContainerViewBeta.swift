//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import UIKit

final class AdminOrganizationsContainerViewBeta: UIViewController {
    var output: AdminOrganizationsContainerViewOutput?
    var state: AdminOrganizationsContainerState = .applications {
        didSet {
            updateState()
        }
    }
    var applications: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.applications, let container = self.applicationsContainer {
                    self.embed(controller: vc, in: container)
                }
            }
        }
    }
    var approved: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.approved, let container = self.approvedContainer {
                    self.embed(controller: vc, in: container)
                }
            }
        }
    }
    @IBOutlet weak var approvedContainer: UIView!
    @IBOutlet weak var applicationsContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func organizationsSegmentedControlValueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.output?.adminOrganizationsContainer(view: self, didChangeState: .applications)
        case 1:
            self.output?.adminOrganizationsContainer(view: self, didChangeState: .approved)
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.adminOrganizationsContainerDidLoad(view: self)
    }

    private func embed(controller: UIViewController, in view: UIView) {
        self.addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        controller.didMove(toParent: self)
    }

    private func updateState() {
        if isViewLoaded {
            switch self.state {
            case .applications:
                self.segmentedControl.selectedSegmentIndex = 0
                self.applicationsContainer.isHidden = false
                self.approvedContainer.isHidden = true
            case .approved:
                self.segmentedControl.selectedSegmentIndex = 1
                self.applicationsContainer.isHidden = true
                self.approvedContainer.isHidden = false
            }
        }
    }
}

extension AdminOrganizationsContainerViewBeta: AdminOrganizationsContainerViewInput {

}
