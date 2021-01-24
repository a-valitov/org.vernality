//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 28.11.2020
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

final class MembersOfOrganizationViewAlpha: UITableViewController {
    var output: MembersOfOrganizationViewOutput?
    var members = [AnyPCMember]() {
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
        self.output?.membersOfOrganizationDidLoad(view: self)
        tableView.tableFooterView = UIView()
        tableView.register(MembersOfOrganizationViewAlphaCell.self, forCellReuseIdentifier: MembersOfOrganizationViewAlphaCell.reuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MembersOfOrganizationViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MembersOfOrganizationViewAlphaCell.reuseIdentifier, for: indexPath) as! MembersOfOrganizationViewAlphaCell
        cell.selectionStyle = .none

        let member = members[indexPath.row]
        cell.memberNameLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
        cell.memberImageView.kf.setImage(with: member.imageUrl)

        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.membersOfOrganization(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension MembersOfOrganizationViewAlpha: MembersOfOrganizationViewInput {
    
}
