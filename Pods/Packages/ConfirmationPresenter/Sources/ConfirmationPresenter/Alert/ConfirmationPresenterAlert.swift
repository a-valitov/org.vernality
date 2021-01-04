//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 04.01.2021
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

class ConfirmationPresenterAlert: ConfirmationPresenter {
    func present(title: String, message: String, actionTitle: String?, withCancelAction: Bool, completion: @escaping () -> Void) {
        self.presentAlert(title: title, message: message, actionTitle: actionTitle, withCancelAction: withCancelAction, completion: completion)
    }

    private func presentAlert(title: String, message: String, actionTitle: String?, withCancelAction: Bool, completion: @escaping () -> Void) {
        guard let actionTitle = actionTitle else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let bgView = alert.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.layer.cornerRadius = 14.0
            contentView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.7476990582)
        }

        var blurVisualEffectView: UIView?
        if let topView = UIApplication.shared.topViewController()?.view {
            let blurEffect = UIBlurEffect(style: .dark)
            let subview = UIVisualEffectView(effect: blurEffect)
            subview.frame = topView.bounds
            topView.addSubview(subview)
            blurVisualEffectView = subview
        }

        let titleFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let messageFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let attributedTitle = NSAttributedString(string: title, attributes: titleFont)
        let attributedMessage = NSAttributedString(string: message, attributes: messageFont)

        alert.setValue(attributedTitle, forKey: "attributedTitle")
        alert.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "\(actionTitle)         ", style: .default) { _ in
            blurVisualEffectView?.removeFromSuperview()
            completion()
        }
        okAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        let cancelAction = UIAlertAction(title: "Назад", style: .default) { _ in
            blurVisualEffectView?.removeFromSuperview()
        }
        cancelAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        switch withCancelAction {
        case true:
            alert.addAction(okAction)
            alert.addAction(cancelAction)
        case false:
            alert.addAction(okAction)
        }

        alert.preferredAction = okAction
        alert.show()
    }

}

extension UIAlertController {

    func show() {
        self.present(animated: true, completion: nil)
    }

    private func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            self.presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }

    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            self.presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                self.presentFromController(controller: selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
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
        if let presented = base?.presentedViewController, !presented.isBeingDismissed {
            return topViewController(presented)
        }
        return base
    }
}

#endif
