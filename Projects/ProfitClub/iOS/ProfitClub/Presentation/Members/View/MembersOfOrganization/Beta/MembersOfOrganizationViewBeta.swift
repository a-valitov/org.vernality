//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 02.11.2020
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

final class MembersOfOrganizationViewBeta: UITableViewController {
    var output: MembersOfOrganizationViewOutput?
    var members = [AnyPCMember]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.membersOfOrganizationDidLoad(view: self)
        tableView.tableFooterView = UIView()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MembersOfOrganizationViewBeta.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        members.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        81
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MemberViewCell

        let member = members[indexPath.row]
        cell.memberNameLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.membersOfOrganizationDidLoad(view: self)
        sender.endRefreshing()
    }
}

extension MembersOfOrganizationViewBeta: MembersOfOrganizationViewInput {
    
}
