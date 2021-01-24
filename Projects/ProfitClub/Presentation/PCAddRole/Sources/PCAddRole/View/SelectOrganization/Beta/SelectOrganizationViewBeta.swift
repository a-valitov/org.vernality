//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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

extension SelectOrganizationViewBeta: SelectOrganizationViewInput {
}

final class SelectOrganizationViewBeta: UITableViewController {
    var output: SelectOrganizationViewOutput?
    var organizations = [AnyPCOrganization]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    private let cellReuseIdentifier = "SelectOrganizationViewBetaTableViewCellReuseIdentifier"

    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        self.output?.selectOrganization(view: self, userWantsToRefresh: sender)
    }

}

extension SelectOrganizationViewBeta {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = self.organizations[indexPath.row]
        self.output?.selectOrganization(view: self, didSelect: organization)
    }
}

extension SelectOrganizationViewBeta {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellReuseIdentifier)
        }
        let chat = self.organizations[indexPath.row]
        cell.textLabel?.text = chat.name
        return cell
    }
}
