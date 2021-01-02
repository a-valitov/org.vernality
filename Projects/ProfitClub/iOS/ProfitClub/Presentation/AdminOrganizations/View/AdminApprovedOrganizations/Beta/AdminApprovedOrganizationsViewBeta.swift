//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
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

final class AdminApprovedOrganizationsViewBeta: UITableViewController {
    var output: AdminApprovedOrganizationsViewOutput?

    var organizations: [AnyPCOrganization] = [] {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.output?.adminApprovedOrganizationsDidLoad(view: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizations.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "approvedOrganizationCell", for: indexPath) as! AdminApprovedOrganizationsViewBetaTableViewCell
        cell.selectionStyle = .none

        let organization = self.organizations[indexPath.row]
        // TODO: @temur show organization info
        cell.organizationNameLabel.text = organization.name
        cell.dateLabel.text = "\(Date())"
        return cell
    }
}

extension AdminApprovedOrganizationsViewBeta: AdminApprovedOrganizationsViewInput {
    
}
