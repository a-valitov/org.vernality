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
    var members = [AnyPCMember]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }

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
    func reloadRow(indexPath: IndexPath) {
        members.remove(at: indexPath.row)
        tableView.reloadData()
    }

    func finishAlert(title: String, completion: @escaping () -> Void) {
        var blurEffect = UIBlurEffect()
        blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = tableView.bounds
        self.tableView.addSubview(blurVisualEffectView)

        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)

        let backView = alertController.view.subviews.first?.subviews.first?.subviews.first
        backView?.layer.cornerRadius = 14.0
        backView?.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.7476990582)

        let titleFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let messageFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let attributedTitle = NSAttributedString(string: "\(title) заявку?", attributes: titleFont)
        let attributedMessage = NSAttributedString(string: "\(title) заявку на вступление в организацию", attributes: messageFont)

        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: title, style: .default) { _ in
            blurVisualEffectView.removeFromSuperview()
            completion()
        }
        okAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        let cancelAction = UIAlertAction(title: "Назад", style: .default) { _ in
            blurVisualEffectView.removeFromSuperview()
        }
        cancelAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.preferredAction = okAction
        present(alertController, animated: true)
    }
}
