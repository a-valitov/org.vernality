//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 18.01.2021
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

final class SelectOrganizationViewAlpha: UITableViewController {
    var output: SelectOrganizationViewOutput?
    var organizations = [AnyPCOrganization]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        tableView.backgroundColor = .white
        tableView.register(SelectOrganizationViewAlphaCell.self, forCellReuseIdentifier: SelectOrganizationViewAlphaCell.reuseIdentifier)
    }

    private func setup() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SelectOrganizationViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.selectOrganization(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }

}

// MARK - UITableViewDataSource
extension SelectOrganizationViewAlpha {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = self.organizations[indexPath.row]
        self.output?.selectOrganization(view: self, didSelect: organization)
    }
}

// MARK: - UITableViewDelegate
extension SelectOrganizationViewAlpha {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectOrganizationViewAlphaCell.reuseIdentifier, for: indexPath) as! SelectOrganizationViewAlphaCell
        let chat = self.organizations[indexPath.row]
        cell.organizationNameLabel.text = chat.name
        return cell
    }
}

extension SelectOrganizationViewAlpha: SelectOrganizationViewInput {
    
}
