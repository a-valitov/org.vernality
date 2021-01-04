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
    func present(title: String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        self.presentAlert(title: title, message: message, buttonTitle: buttonTitle, completion: completion)
    }

    private func presentAlert(title: String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let backView = alert.view.subviews.first?.subviews.first?.subviews.first
        backView?.layer.cornerRadius = 14.0
        backView?.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.7476990582)

        let titleFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let messageFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let attributedTitle = NSAttributedString(string: title, attributes: titleFont)
        let attributedMessage = NSAttributedString(string: message, attributes: messageFont)

        alert.setValue(attributedTitle, forKey: "attributedTitle")
        alert.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "\(buttonTitle)         ", style: .default) { _ in
            completion()
        }
        okAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        let cancelAction = UIAlertAction(title: "Назад", style: .default)
        cancelAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        alert.addAction(okAction)
        alert.addAction(cancelAction)
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

#endif
