//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 12.01.2021
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
import ProfitClubModel

final class AdminApprovedCommercialOffersViewAlpha: UITableViewController {
    var output: AdminApprovedCommercialOffersViewOutput?

    var commercialOffers: [AnyPCCommercialOffer] = [] {
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
        self.output?.adminApprovedCommercialOffersDidLoad(view: self)

        tableView.register(AdminCommercialOffersApplicationsViewAlphaCell.self, forCellReuseIdentifier: AdminCommercialOffersApplicationsViewAlphaCell.reuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AdminApprovedCommercialOffersViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commercialOffers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminCommercialOffersApplicationsViewAlphaCell.reuseIdentifier, for: indexPath) as! AdminCommercialOffersApplicationsViewAlphaCell

        cell.selectionStyle = .none

        let commercialOffer = self.commercialOffers[indexPath.row]
        cell.commercialOfferMessageLabel.text = commercialOffer.message
        cell.commercialOfferImageView.kf.setImage(with: commercialOffer.imageUrl)
        cell.supplierNameLabel.text = commercialOffer.supplier?.contact
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.commercialOfferCreatedDateLabel.text = "\(dateFormatter.string(from: commercialOffer.createdAt ?? Date()))"

        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.adminApprovedCommercialOffers(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension AdminApprovedCommercialOffersViewAlpha: AdminApprovedCommercialOffersViewInput {

}

