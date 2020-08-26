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

public protocol MainModule: UIViewController {
    var output: MainModuleOutput? { get set }

    func push(_ viewController: UIViewController, animated: Bool)
    func raise(_ viewController: UIViewController, animated: Bool)
    func unraise(animated: Bool, completion: (() -> Void)?)
    func unwindToRoot()
}

public extension MainModule {
    func unraise(animated: Bool) {
        return self.unraise(animated: animated, completion: nil)
    }
}

public protocol MainModuleOutput {
    func mainDidLoad(module: MainModule)
    func mainWillAppear(module: MainModule)
}

public protocol MainModuleFactory {
    func make() -> (module: MainModule, view: UIViewController)
}
#endif
