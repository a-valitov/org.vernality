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

class ActivityPresenterCircle: ActivityPresenter {

    var counter = 0
    let window = UIWindow(frame: UIScreen.main.bounds)
    let hudViewController: ActivityCircleViewController
    weak var appWindow: UIWindow?

    init() {
        self.hudViewController = ActivityCircleViewController()
        self.window.windowLevel = .normal
        self.hudViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.window.rootViewController = self.hudViewController
    }

    func increment() {
        counter += 1
        if counter == 1 {
            show()
        }
    }

    func decrement() {
        counter -= 1
        if counter == 0 {
            hide()
        }
    }

    private func show() {
        appWindow = UIApplication.shared.keyWindow
        window.makeKeyAndVisible()
        hudViewController.spinnerView.animate()
    }

    private func hide() {
        appWindow?.makeKeyAndVisible()
        appWindow = nil
        window.isHidden = true
        hudViewController.spinnerView.stopAnimating()
    }
}

#endif
