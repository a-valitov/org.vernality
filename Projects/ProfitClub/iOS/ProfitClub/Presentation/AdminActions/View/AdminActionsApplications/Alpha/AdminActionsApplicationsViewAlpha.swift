//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 08.01.2021
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

final class AdminActionsApplicationsViewAlpha: UITableViewController {
    var output: AdminActionsApplicationsViewOutput?

    var actions = [AnyPCAction]()

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
        self.output?.adminActionsApplicationsDidLoad(view: self)

        tableView.register(AdminActionsApplicationsViewAlphaCell.self, forCellReuseIdentifier: AdminActionsApplicationsViewAlphaCell.reuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AdminActionsApplicationsViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return actions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminActionsApplicationsViewAlphaCell.reuseIdentifier, for: indexPath) as! AdminActionsApplicationsViewAlphaCell
        cell.selectionStyle = .none

        let action = actions[indexPath.row]
        cell.actionMessageLabel.text = action.message
        cell.actionDescriptionLabel.text = action.descriptionOf
        cell.actionLinkLabel.text = action.link
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.actionEndDate.text = "до \(dateFormatter.string(from: action.endDate ?? Date()))"
        cell.actionImageView.kf.setImage(with: action.imageUrl)

        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.adminActionsApplications(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension AdminActionsApplicationsViewAlpha: AdminActionsApplicationsViewInput {
    func reload() {
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }

    func hide(action: PCAction) {
        guard let index = actions.firstIndex(of: action.any) else {
            assertionFailure("Organization not found")
            return
        }
        actions.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
