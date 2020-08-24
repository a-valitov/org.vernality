//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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
import Folders
import TeleGuideModel

final class FoldersViewControllerAlpha: UITableViewController {
    var output: FoldersViewOutput
    var folders: [AnyFolder] = [] { didSet { self.updateUIFolders() } }

    init(output: FoldersViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = self.logoutBarButtonItem
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

    private lazy var logoutBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(FoldersViewControllerAlpha.logoutBarButtonItemAction(_:)))
    }()
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(FoldersViewControllerAlpha.addBarButtonItemAction))
    }()
    private let cellReuseIdentifier = "FoldersTableViewCellReuseIdentifier"

    @objc
    private func logoutBarButtonItemAction(_ sender: Any) {
        self.output.userWantsToLogout()
    }

    @objc
    private func addBarButtonItemAction(_ sender: Any) {
        self.output.userWantsToAddFolder()
    }
}

extension FoldersViewControllerAlpha: FoldersViewInput {
    func showAddFolderDialog() {
        let controller = UIAlertController(title: "Add Folder", message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let textFields = controller.textFields, textFields.isEmpty == false, let text = textFields[0].text, text.isEmpty == false else { return }
            self?.output.userWantsToAddFolderWithName(text)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.addTextField(configurationHandler: nil)
        self.present(controller, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension FoldersViewControllerAlpha {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = self.folders[indexPath.row]
        self.output.userWantsToOpenFolder(folder)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let folder = self.folders[indexPath.row]
            self.output.userWantsToDeleteFolder(folder)
        }
    }
}

// MARK: - UITableViewDataSource
extension FoldersViewControllerAlpha {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.folders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellReuseIdentifier)
        }
        let folder = self.folders[indexPath.row]
        cell.textLabel?.text = folder.name
        return cell
    }
}

// MARK: - Update UI
extension FoldersViewControllerAlpha {
    private func update() {
        self.updateUIFolders()
    }

    private func updateUIFolders() {
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }
}

#endif
