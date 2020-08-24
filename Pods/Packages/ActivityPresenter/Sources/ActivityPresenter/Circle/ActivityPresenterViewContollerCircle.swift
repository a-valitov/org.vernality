//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/22/20
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

#if canImport(UIKit)
import UIKit

final class ActivityCircleViewController: UIViewController {
    var statusBarStyle = UIStatusBarStyle.default
    var statusBarHidden = false

    let spinnerView = ActivityPresenterSpinnerView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.addSubview(self.spinnerView)
        self.spinnerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.spinnerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.spinnerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.spinnerView.widthAnchor.constraint(equalToConstant: 44),
            self.spinnerView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = UIApplication.shared.topViewController() else { return statusBarStyle }
        if !topVC.isKind(of: ActivityCircleViewController.self) {
            statusBarStyle = topVC.preferredStatusBarStyle
        }
        return statusBarStyle
    }

    override var prefersStatusBarHidden: Bool {
        guard let topVC = UIApplication.shared.topViewController() else { return statusBarHidden }
        if !topVC.isKind(of: ActivityCircleViewController.self) {
            statusBarHidden = topVC.prefersStatusBarHidden
        }
        return statusBarHidden
    }

}

extension UIApplication {
    func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? keyWindow?.rootViewController
        if let top = (base as? UINavigationController)?.topViewController {
            return topViewController(top)
        }
        if let selected = (base as? UITabBarController)?.selectedViewController {
            return topViewController(selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
#endif
