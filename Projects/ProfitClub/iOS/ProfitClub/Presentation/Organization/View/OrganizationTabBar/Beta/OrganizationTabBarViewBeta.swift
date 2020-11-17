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
    
}

final class OrganizationTabBarViewBeta: UITabBarController {
    var output: OrganizationTabBarViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Montserrat-Regular", size: 12)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))
    }

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black

        let logoutIcon = #imageLiteral(resourceName: "logout")
        let changeRoleIcon = #imageLiteral(resourceName: "refresh")
        let profileIcon = #imageLiteral(resourceName: "profile")

        let logout = UIAlertAction(title: "Выйти", style: .cancel) { _ in

        }

        logout.setValue(logoutIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let changeRole = UIAlertAction(title: "Сменить роль", style: .default) { _ in

        }

        changeRole.setValue(changeRoleIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        let profileAction = UIAlertAction(title: "Профиль", style: .default) { _ in
            self.output?.organizationTabBar(view: self, tappedOn: sender)
        }

        profileAction.setValue(profileIcon.withRenderingMode(.alwaysOriginal), forKey: "image")

        actionSheet.addAction(profileAction)
        actionSheet.addAction(changeRole)
        actionSheet.addAction(logout)
        present(actionSheet, animated: true)
    }
}
