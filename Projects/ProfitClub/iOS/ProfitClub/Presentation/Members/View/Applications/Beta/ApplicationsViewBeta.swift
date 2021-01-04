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

final class ApplicationsViewBeta: UITableViewController {
    var output: ApplicationsViewOutput?
    var members = [AnyPCMember]() 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.applicationsDidLoad(view: self)
        tableView.tableFooterView = UIView()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ApplicationsViewBeta.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "applicationsCell", for: indexPath)

        return cell
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.applications(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }
}

extension ApplicationsViewBeta: ApplicationsViewInput {
    func reload() {
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }

    func hide(member: PCMember) {
        guard let index = members.firstIndex(of: member.any) else {
            assertionFailure("Member not found")
            return
        }
        members.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
}
