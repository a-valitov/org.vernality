//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 28.11.2020
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
import Kingfisher

final class CommercialOffersViewAlpha: UITableViewController {
    var output: CommercialOffersViewOutput?
    var commercialOffers = [AnyPCCommercialOffer]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem = UITabBarItem(title: "Поставки", image: #imageLiteral(resourceName: "selectedCommercialOfferItem"), selectedImage: #imageLiteral(resourceName: "commercialOfferItem"))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.commercialOffersDidLoad(view: self)

        tableView.tableFooterView = UIView()
        tableView.register(CommercialOffersViewAlphaCell.self, forCellReuseIdentifier: CommercialOffersViewAlphaCell.reuseIdentifier)
        self.tabBarController?.selectedIndex = 2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commercialOffer = commercialOffers[indexPath.row]
        self.output?.commercialOffers(view: self, didSelect: commercialOffer)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commercialOffers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommercialOffersViewAlphaCell.reuseIdentifier, for: indexPath) as! CommercialOffersViewAlphaCell

        cell.selectionStyle = .none

        let commercialOffer = commercialOffers[indexPath.row]
        cell.commercialOfferMessageLabel.text = commercialOffer.message
        cell.commercialOfferImageView.kf.setImage(with: commercialOffer.imageUrl)
        cell.supplierNameLabel.text = commercialOffer.supplier?.contact
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.commercialOfferCreatedDateLabel.text = "\(dateFormatter.string(from: commercialOffer.createdAt ?? Date()))"

        return cell
    }
}

extension CommercialOffersViewAlpha: CommercialOffersViewInput {
    
}
