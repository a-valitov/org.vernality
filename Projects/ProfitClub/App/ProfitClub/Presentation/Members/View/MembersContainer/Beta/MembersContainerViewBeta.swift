//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 02.11.2020
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

final class MembersContainerViewBeta: UIViewController {
    var output: MembersContainerViewOutput?
    var state: MembersContainerState = .membersOfOrganization {
        didSet {
            updateState()
        }
    }
    var membersOfOrganization: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.membersOfOrganization, let container = self.membersOfOrganizationContainer {
                    self.embed(controller: vc, in: container)
                }
            }
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

    @IBOutlet weak var membersOfOrganizationContainer: UIView!
    @IBOutlet weak var applicationsContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func membersSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.output?.membersContainer(view: self, didChangeState: .membersOfOrganization)
        case 1:
            self.output?.membersContainer(view: self, didChangeState: .applications)
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.membersContainerDidLoad(view: self)
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
            case .membersOfOrganization:
                self.segmentedControl.selectedSegmentIndex = 0
                self.membersOfOrganizationContainer.isHidden = false
                self.applicationsContainer.isHidden = true
            case .applications:
                self.segmentedControl.selectedSegmentIndex = 1
                self.membersOfOrganizationContainer.isHidden = true
                self.applicationsContainer.isHidden = false
            }
        }
    }

}

extension MembersContainerViewBeta: MembersContainerViewInput {

}
