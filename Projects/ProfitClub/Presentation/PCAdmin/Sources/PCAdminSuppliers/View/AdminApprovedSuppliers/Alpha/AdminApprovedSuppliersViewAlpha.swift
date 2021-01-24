//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 07.01.2021
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
import PCModel
import Kingfisher

final class AdminApprovedSuppliersViewAlpha: UITableViewController {
    var output: AdminApprovedSuppliersViewOutput?

    var suppliers: [AnyPCSupplier] = [] {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.output?.adminApprovedSuppliersDidLoad(view: self)

        tableView.register(AdminApprovedSuppliersViewAlphaCell.self, forCellReuseIdentifier: AdminApprovedSuppliersViewAlphaCell.reuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AdminApprovedSuppliersViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suppliers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminApprovedSuppliersViewAlphaCell.reuseIdentifier, for: indexPath) as! AdminApprovedSuppliersViewAlphaCell
        cell.selectionStyle = .none

        let supplier = self.suppliers[indexPath.row]
        cell.supplierNameLabel.text = supplier.name
        cell.supplierImageView.kf.setImage(with: supplier.imageUrl)

        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.adminApprovedSuppliers(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension AdminApprovedSuppliersViewAlpha: AdminApprovedSuppliersViewInput {

}
