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

extension OrganizationTabBarViewBeta: OrganizationTabBarViewInput {
    func showLogoutConfirmationDialog() {
        var blurEffect = UIBlurEffect()
        blurEffect = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        blurVisualEffectView.alpha = 0.9
        self.view.addSubview(blurVisualEffectView)
        let controller = UIAlertController(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", preferredStyle: .alert)

        controller.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { [weak self] _ in
            guard let sSelf = self else { return }
            self?.output?.organizationTabBar(view: sSelf, userConfirmToLogout: controller)
            blurVisualEffectView.removeFromSuperview()
        }))

        controller.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            blurVisualEffectView.removeFromSuperview()
        }))

        self.present(controller, animated: true)
    }
}

final class OrganizationTabBarViewBeta: UITabBarController {
    var output: OrganizationTabBarViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Montserrat-Regular", size: 12)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))

        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Profit Club"
        label.font = UIFont(name: "PlayfairDisplay-Bold", size: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .black
    }

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black

        let logoutIcon = #imageLiteral(resourceName: "logout")
        let changeRoleIcon = #imageLiteral(resourceName: "refresh")
        let profileIcon = #imageLiteral(resourceName: "profile")

        let logout = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.output?.organizationTabBar(view: self, userWantsToLogout: sender)
        }

        logout.setValue(logoutIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let changeRole = UIAlertAction(title: "Сменить роль", style: .default) { _ in
            self.output?.organizationTabBar(view: self, userWantsToChangeRole: sender)
        }

        changeRole.setValue(changeRoleIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let profileAction = UIAlertAction(title: "Профиль", style: .default) { _ in
            self.output?.organizationTabBar(view: self, tappedOn: sender)
        }

        profileAction.setValue(profileIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        actionSheet.addAction(profileAction)
        actionSheet.addAction(changeRole)
        actionSheet.addAction(logout)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
}
