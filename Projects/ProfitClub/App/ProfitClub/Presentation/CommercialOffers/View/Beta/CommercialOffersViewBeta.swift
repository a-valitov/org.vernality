//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 31.10.2020
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

final class CommercialOffersViewBeta: UITableViewController {
    var output: CommercialOffersViewOutput?
    var commercialOffers = [AnyPCCommercialOffer]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.commercialOffersDidLoad(view: self)
        tableView.tableFooterView = UIView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "commercialOfferCell", for: indexPath) as! CommercialOffersViewCell

        let commercialOffer = commercialOffers[indexPath.row]
        cell.commercialOfferMessageLabel.text = commercialOffer.message
        cell.commercialOfferImageView.kf.setImage(with: commercialOffer.imageUrl)
        cell.supplierNameLabel.text = commercialOffer.supplier?.contact

        return cell
    }
}

extension CommercialOffersViewBeta: CommercialOffersViewInput {
    
}
