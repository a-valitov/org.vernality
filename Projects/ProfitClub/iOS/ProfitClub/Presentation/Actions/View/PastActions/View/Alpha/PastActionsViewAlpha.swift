//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 27.11.2020
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

final class PastActionsViewAlpha: UITableViewController {
    var output: PastActionsViewOutput?
    var actions = [AnyPCAction]() {
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
        self.output?.pastActionsDidLoad(view: self)

        tableView.register(PastActionsViewAlphaTableViewCell.self, forCellReuseIdentifier: PastActionsViewAlphaTableViewCell.reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        self.output?.pastActions(view: self, didSelect: action)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        83
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PastActionsViewAlphaTableViewCell.reuseIdentifier, for: indexPath) as! PastActionsViewAlphaTableViewCell

        cell.selectionStyle = .none

        let action = actions[indexPath.row]
        cell.pastActionNameLabel.text = action.message
        cell.pastActionDescriptionLabel.text = action.descriptionOf
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.actionEndDate.text = "до \(dateFormatter.string(from: action.endDate ?? Date()))"
        cell.pastActionImageView.kf.setImage(with: action.imageUrl)

        return cell
    }
}

extension PastActionsViewAlpha: PastActionsViewInput {
    
}
