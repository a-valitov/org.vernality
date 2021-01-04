//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 05.01.2021
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

class MenuPresenterActionSheet: MenuPresenter {
    func present(menuFor: Menu, logout: (() -> Void)? = nil, changeRole: (() -> Void)? = nil, openProfile: (() -> Void)? = nil, addRole: (() -> Void)? = nil) {
        self.presentActionSheet(menuFor: menuFor, logout: logout, changeRole: changeRole, openProfile: openProfile, addRole: addRole)
    }

    private func presentActionSheet(menuFor: Menu, logout: (() -> Void)? = nil, changeRole: (() -> Void)? = nil, openProfile: (() -> Void)? = nil, addRole: (() -> Void)? = nil) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black

        let logoutIcon = #imageLiteral(resourceName: "logout")
        let changeRoleIcon = #imageLiteral(resourceName: "refresh")
        let profileIcon = #imageLiteral(resourceName: "profile")
        let addRoleIcon = #imageLiteral(resourceName: "addRoleIcon")

        let logout = UIAlertAction(title: "Выйти", style: .default) { _ in
            logout?()
        }
        logout.setValue(logoutIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let changeRole = UIAlertAction(title: "Сменить роль", style: .default) { _ in
            changeRole?()
        }
        changeRole.setValue(changeRoleIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let profileAction = UIAlertAction(title: "Профиль", style: .default) { _ in
            openProfile?()
        }
        profileAction.setValue(profileIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let addRoleAction = UIAlertAction(title: "Добавить роль", style: .default) { _ in
            addRole?()
        }
        addRoleAction.setValue(addRoleIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        switch menuFor {
        case .review:
            actionSheet.addAction(addRoleAction)
            actionSheet.addAction(logout)
            actionSheet.addAction(cancelAction)
        case .admin:
            actionSheet.addAction(changeRole)
            actionSheet.addAction(logout)
            actionSheet.addAction(cancelAction)
        case .custom:
            actionSheet.addAction(profileAction)
            actionSheet.addAction(changeRole)
            actionSheet.addAction(logout)
            actionSheet.addAction(cancelAction)
        }
        
        actionSheet.show()
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

