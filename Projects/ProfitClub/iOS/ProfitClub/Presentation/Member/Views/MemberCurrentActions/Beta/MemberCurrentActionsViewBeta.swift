//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 08.11.2020
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

final class MemberCurrentActionsViewBeta: UITableViewController {
    var output: MemberCurrentActionsViewOutput?
    var actions = [AnyPCAction]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.memberCurrentActionsDidLoad(view: self)
        tableView.tableFooterView = UIView()

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        self.output?.memberCurrentActions(view: self, didSelect: action)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        108
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionsCell", for: indexPath) as! MemberCurrentActionsTableViewCell

        let action = actions[indexPath.row]
        cell.actionMessageLabel.text = action.message
        cell.actionDescriptionLabel.text = action.descriptionOf
        cell.actionLinkLabel.text = action.link
        cell.actionImageView.kf.setImage(with: action.imageUrl)

        return cell
    }

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        self.output?.memberCurrentActions(view: self, tappenOn: sender)
    }

}

extension MemberCurrentActionsViewBeta: MemberCurrentActionsViewInput {
}
