//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/14/20
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

final class CurrentActionsViewBeta: UITableViewController {
    var output: CurrentActionsViewOutput?
    var actions = [AnyPCAction]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.currentActionsDidLoad(view: self)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = self.actions[indexPath.row]
        self.output?.currentActions(view: self, didSelect: action)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentActionsCell", for: indexPath) as! CurrentActionsTableViewCell

        let action = actions[indexPath.row]
        cell.actionMessageLabel.text = action.message
        cell.actionDescriptionOfLabel.text = action.descriptionOf
        cell.actionLinkLabel.text = action.link
        cell.actionImageView.kf.setImage(with: action.imageUrl)

        return cell
    }
}

extension CurrentActionsViewBeta: CurrentActionsViewInput {
}
