//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 20.10.2020
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

extension SupplierViewBeta: SupplierViewInput {
}

final class SupplierViewBeta: UIViewController {
    var output: SupplierViewOutput?

    @IBOutlet weak var createAction: UIButton!
    
    @IBAction func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierView(view: self, supplierWantsToCreateAction: sender)
    }

    @IBAction func createCommercialOfferTouchUpInside(_ sender: Any) {
        self.output?.supplier(view: self, wantsToCreateCommercialOffer: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAction.layer.borderWidth = 1
        createAction.layer.borderColor = UIColor.black.cgColor

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))

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
        self.output?.supplier(view: self, tappenOn: sender)
    }
}
