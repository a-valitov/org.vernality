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

import Foundation

public struct MenuItem {
    public var title: String
    public var image: UIImage?
    public var handler: (() -> Void)?

    public init(title: String, image: UIImage?, handler: (() -> Void)?) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}

public protocol MenuPresenter {
    func present(items: [MenuItem])
}

public protocol MenuPresenterFactory {
    func make() -> MenuPresenter
}
