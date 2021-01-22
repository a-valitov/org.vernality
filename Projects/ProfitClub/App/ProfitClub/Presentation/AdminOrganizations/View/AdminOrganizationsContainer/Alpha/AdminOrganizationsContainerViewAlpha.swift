//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 03.01.2021
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

final class AdminOrganizationsContainerViewAlpha: UIViewController {
    var output: AdminOrganizationsContainerViewOutput?
    var state: AdminOrganizationsContainerState = .applications {
        didSet {
            updateState()
        }
    }
    var approved: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.approved {
                    self.embed(controller: vc, in: self.approvedOrganizationsContainer)
                }
            }
        }
    }
    var applications: UIViewController? {
        didSet {
            if isViewLoaded {
                if let vc = self.applications {
                    self.embed(controller: vc, in: self.applicationsContainer)
                }
            }
        }
    }

    var tabBarImage: UIImage?
    var tabBarSelectedImage: UIImage?

    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.addTarget(self, action: #selector(AdminOrganizationsContainerViewAlpha.organizationsSegmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor(red: 25/255, green: 24/255, blue: 24/255, alpha: 0.5)], for: .normal)
        segmentedControl.insertSegment(withTitle: "Заявки", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Одобренные", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private lazy var segmentIndicator: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var approvedOrganizationsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var applicationsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return segmentIndicator.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()

    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        #if SWIFT_PACKAGE
        tabBarImage = UIImage(named: "organizationsItem", in: Bundle.module, compatibleWith: nil)
        #else
        tabBarImage = UIImage(named: "organizationsItem", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif
        #if SWIFT_PACKAGE
        tabBarSelectedImage = UIImage(named: "selectedOrganizationsItem", in: Bundle.module, compatibleWith: nil)
        #else
        tabBarSelectedImage = UIImage(named: "selectedOrganizationsItem", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif
        self.tabBarItem = UITabBarItem(title: "Организации", image: tabBarImage, selectedImage: tabBarSelectedImage)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        self.output?.adminOrganizationsContainerDidLoad(view: self)
    }
    
    private func setup() {
        self.tabBarController?.selectedIndex = 0

        segmentedControl.setBackgroundImage(imageWithColor(color: .clear), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(imageWithColor(color: .clear), for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(imageWithColor(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }

    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
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
                self.approvedOrganizationsContainer.isHidden = true
            case .approved:
                self.segmentedControl.selectedSegmentIndex = 1
                self.approvedOrganizationsContainer.isHidden = false
                self.applicationsContainer.isHidden = true
            }
        }
    }

    @objc private func organizationsSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeSegmentedControlLinePosition()
        switch sender.selectedSegmentIndex {
        case 0:
            self.output?.adminOrganizationsContainer(view: self, didChangeState: .applications)
        case 1:
            self.output?.adminOrganizationsContainer(view: self, didChangeState: .approved)
        default:
            break
        }
    }
}

// MARK: - Layout
extension AdminOrganizationsContainerViewAlpha {
    private func layout() {
        layoutSegmentedControlContainerView(in: self.view)
        layoutSegmentedControl(in: self.segmentedControlContainerView)
        layoutSegmentIndicator(in: self.segmentedControlContainerView)
        layoutMembersOfOrganizationContainer(in: self.view)
        layoutApplicationsContainer(in: self.view)
    }

    private func layoutSegmentedControlContainerView(in container: UIView) {
        let containerView = segmentedControlContainerView
        container.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutSegmentedControl(in container: UIView) {
        let segment = segmentedControl
        container.addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            segment.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5.0),
            segment.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5.0)
        ])
    }

    private func layoutSegmentIndicator(in container: UIView) {
        let indicator = segmentIndicator
        container.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.heightAnchor.constraint(equalToConstant: 2.0),
            indicator.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
            indicator.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            leadingDistanceConstraint,
            indicator.widthAnchor.constraint(equalTo: self.segmentedControl.widthAnchor, multiplier: 1 / CGFloat(self.segmentedControl.numberOfSegments))
        ])
    }

    private func layoutMembersOfOrganizationContainer(in container: UIView) {
        let currentContainer = approvedOrganizationsContainer
        container.addSubview(currentContainer)
        NSLayoutConstraint.activate([
            currentContainer.topAnchor.constraint(equalTo: self.segmentedControlContainerView.bottomAnchor, constant: 0),
            currentContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            currentContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            currentContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }

    private func layoutApplicationsContainer(in container: UIView) {
        let pastContainer = applicationsContainer
        container.addSubview(pastContainer)
        NSLayoutConstraint.activate([
            pastContainer.topAnchor.constraint(equalTo: self.segmentedControlContainerView.bottomAnchor, constant: 0),
            pastContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            pastContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            pastContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }
}

extension AdminOrganizationsContainerViewAlpha: AdminOrganizationsContainerViewInput {

}
