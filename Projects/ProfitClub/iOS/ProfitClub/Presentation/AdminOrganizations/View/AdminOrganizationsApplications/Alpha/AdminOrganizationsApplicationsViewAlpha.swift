//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 03.01.2021
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

final class AdminOrganizationsApplicationsViewAlpha: UITableViewController {
    var output: AdminOrganizationsApplicationsViewOutput?
    
    var organizations = [AnyPCOrganization]()

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
        self.output?.adminOrganizationsApplicationsViewDidLoad(view: self)

        tableView.register(AdminOrganizationsApplicationsViewAlphaCell.self, forCellReuseIdentifier: AdminOrganizationsApplicationsViewAlphaCell.reuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AdminOrganizationsApplicationsViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminOrganizationsApplicationsViewAlphaCell.reuseIdentifier, for: indexPath) as! AdminOrganizationsApplicationsViewAlphaCell
        cell.selectionStyle = .none

        let organization = self.organizations[indexPath.row]
        cell.organizationNameLabel.text = organization.name
        cell.organizationContactNameLabel.text = organization.contact
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = self.organizations[indexPath.row]
        self.output?.adminOrganizationsApplications(view: self, didSelect: organization)
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.adminOrganizationsApplications(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension AdminOrganizationsApplicationsViewAlpha: AdminOrganizationsApplicationsViewInput {
    func reload() {
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }

    func hide(organization: PCOrganization) {
        guard let index = organizations.firstIndex(of: organization.any) else {
            assertionFailure("Organization not found")
            return
        }
        organizations.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
