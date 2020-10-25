//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/14/20
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

final class ActionsContainerViewBeta: UIViewController {
    var output: ActionsContainerViewOutput?
    var state: ActionsContainerState = .current {
        didSet {
            updateState()
        }
    }
    var current: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.current, let container = self.currentContainer {
                    self.embed(controller: vc, in: container)
                }
            }
        }
    }

    var past: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.past, let container = self.pastContainer {
                    self.embed(controller: vc, in: container)
                }
            }
        }
    }

    @IBOutlet weak var currentContainer: UIView!
    @IBOutlet weak var pastContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func actionsSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.output?.actionsContainer(view: self, didChangeState: .current)
        case 1:
            self.output?.actionsContainer(view: self, didChangeState: .past)
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.actionsContainerDidLoad(view: self)
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
            case .current:
                self.segmentedControl.selectedSegmentIndex = 0
                self.currentContainer.isHidden = false
                self.pastContainer.isHidden = true
            case .past:
                self.segmentedControl.selectedSegmentIndex = 1
                self.currentContainer.isHidden = true
                self.pastContainer.isHidden = false
            }
        }
    }
}

extension ActionsContainerViewBeta: ActionsContainerViewInput {
}
