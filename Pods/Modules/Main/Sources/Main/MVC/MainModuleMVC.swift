//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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
import FittedSheets

final class MainModuleMVC: UIViewController {
    var output: MainModuleOutput?
    var viewController: UIViewController {
        if let view = self.weakView {
            return view
        } else {
            let navigationController = UINavigationController(rootViewController: self)
            navigationController.isNavigationBarHidden = true
            self.weakView = navigationController
            return navigationController
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.output?.mainDidLoad(module: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private weak var weakView: UIViewController?
}

extension MainModuleMVC: MainModule {
    func present(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.topViewController?.present(viewController, animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }

    func pop() {
        self.navigationController?.popViewController(animated: true)
    }

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
        self.navigationController?.topViewController?.present(sheetController, animated: animated)
    }

    func unraise(animated: Bool, completion: (() -> Void)? = nil) {
        self.navigationController?.topViewController?.dismiss(animated: animated, completion: completion)
    }

    func unwindToRoot() {
        if let presented = self.navigationController?.topViewController?.presentedViewController {
            presented.dismiss(animated: false) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        } else {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
#endif
