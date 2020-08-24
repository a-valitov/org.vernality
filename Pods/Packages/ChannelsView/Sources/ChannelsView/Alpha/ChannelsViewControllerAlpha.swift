//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/22/20
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

#if canImport(UIKit)
import UIKit
import Channels
import TeleGuideModel

final class ChannelsViewControllerAlpha: UITableViewController {
    var output: ChannelsViewOutput
    var channels: [AnyChannel] = [] { didSet { self.updateUIChannels() } }

    init(output: ChannelsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ChannelsViewControllerAlpha.addBarButtonItemAction))
    }()
    private let cellReuseIdentifier = "ChannelsTableViewCellReuseIdentifier"

    @objc
    private func addBarButtonItemAction(_ sender: Any) {
        self.output.userWantsToAddChannel()
    }
}

extension ChannelsViewControllerAlpha: ChannelsViewInput {
}

// MARK: - UITableViewDelegate
extension ChannelsViewControllerAlpha {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = self.channels[indexPath.row]
        self.output.userWantsToOpenChannel(channel)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let channel = self.channels[indexPath.row]
            self.output.userWantsToDeleteChannel(channel)
        }
    }
}

// MARK: - UITableViewDataSource
extension ChannelsViewControllerAlpha {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellReuseIdentifier)
        }
        let channel = self.channels[indexPath.row]
        cell.textLabel?.text = channel.name
        return cell
    }
}

// MARK: - Update UI
extension ChannelsViewControllerAlpha {
    private func update() {
        self.updateUIChannels()
    }

    private func updateUIChannels() {
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }
}

#endif
