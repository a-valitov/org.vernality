//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 18.01.2021
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
import FittedSheets

extension UIViewController {
    func raise(_ viewController: UIViewController, animated: Bool) {
        var options = SheetOptions(
            pullBarHeight: 24,
            presentingViewCornerRadius: 20,
            shouldExtendBackground: true,
            setIntrensicHeightOnNavigationControllers: true,
            useFullScreenMode: true,
            shrinkPresentingViewController: false,
            useInlineMode: false
        )
        options.transitionDuration = 0.5
        let sheetController = SheetViewController(controller: viewController, sizes: [.intrinsic, .fullscreen], options: options)
        sheetController.minimumSpaceAbovePullBar = 50
        viewController.view.superview?.backgroundColor = .clear
        self.present(sheetController, animated: animated)
    }

    func unraise(animated: Bool, completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
}
