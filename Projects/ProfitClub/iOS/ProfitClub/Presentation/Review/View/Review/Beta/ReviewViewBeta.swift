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
import ProfitClubModel

extension ReviewViewBeta: ReviewViewInput {
    func showLogoutConfirmationDialog() {
        var blurEffect = UIBlurEffect()
        blurEffect = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        blurVisualEffectView.alpha = 0.9
        self.view.addSubview(blurVisualEffectView)
        let controller = UIAlertController(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", preferredStyle: .alert)

        controller.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { [weak self] _ in
            guard let sSelf = self else { return }
            self?.output?.review(view: sSelf, userConfirmToLogout: controller)
            blurVisualEffectView.removeFromSuperview()
        }))

        controller.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            blurVisualEffectView.removeFromSuperview()
        }))
        
        self.present(controller, animated: true)
    }
}

final class ReviewViewBeta: UITableViewController {
    var output: ReviewViewOutput?
    var username: String?
    var members = [AnyPCMember]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    var organizations = [AnyPCOrganization]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    var suppliers = [AnyPCSupplier]() {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Profit Club"
        label.font = UIFont(name: "PlayfairDisplay-Bold", size: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .black
    }

    @IBAction func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.review(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }

    @IBAction func actionsButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alertController.view.tintColor = .black
        let logoutAction = UIAlertAction(title: "Выход", style: .default) { _ in
            self.output?.review(view: self, userWantsToLogout: sender)
        }

        let addRoleAction = UIAlertAction(title: "Добавить роль", style: .default) { _ in
            self.output?.review(view: self, userWantsToAdd: sender)
        }

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")

        alertController.addAction(addRoleAction)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private let organizationCellReuseIdentifier = "ReviewViewBetaOrganizationCellReuseIdentifier"
    private let memberCellReuseIdentifier = "ReviewViewBetaMemberCellReuseIdentifier"
    private let supplierCellReuseIdentifier = "ReviewViewBetaSupplierCellReuseIdentifier"
}

extension ReviewViewBeta {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let member = self.members[indexPath.row]
            self.output?.review(view: self, userTappedOn: member)
        case 1:
            let organization = self.organizations[indexPath.row]
            self.output?.review(view: self, userTappedOn: organization)
        case 2:
            let supplier = self.suppliers[indexPath.row]
            self.output?.review(view: self, userTappedOn: supplier)
        default:
            break
        }
    }
}

extension ReviewViewBeta {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.members.isEmpty ? nil : "Участники"
        case 1:
            return self.organizations.isEmpty ? nil : "Организации"
        case 2:
            return self.suppliers.isEmpty ? nil : "Поставщики"
        default:
            return nil
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.members.count
        case 1:
            return self.organizations.count
        case 2:
            return self.suppliers.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.memberCellReuseIdentifier, for: indexPath) as! ReviewViewBetaMemberCell
            let member = self.members[indexPath.row]
            cell.fullNameLabel.text = (member.firstName ?? "") + " " + (member.lastName ?? "")
            if let status = member.status {
                switch status {
                case .onReview:
                    cell.statusLabel.text = "На рассмотрении"
                    cell.statusLabel.textColor = .systemOrange
                case .approved:
                    cell.statusLabel.text = "Одобрено"
                    cell.statusLabel.textColor = .systemGreen
                case .excluded:
                    cell.statusLabel.text = "Исключено"
                    cell.statusLabel.textColor = .systemRed
                case .rejected:
                    cell.statusLabel.text = "Отклонено"
                    cell.statusLabel.textColor = .systemRed
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.organizationCellReuseIdentifier, for: indexPath) as! ReviewViewBetaOrganizationCell
            let organization = self.organizations[indexPath.row]
            cell.nameLabel.text = organization.name
            cell.innLabel.text = organization.inn
            cell.phoneLabel.text = organization.phone
            cell.contactLabel.text = organization.contact
            if let status = organization.status {
                switch status {
                case .onReview:
                    cell.statusLabel.text = "На рассмотрении"
                    cell.statusLabel.textColor = .systemOrange
                case .approved:
                    cell.statusLabel.text = "Одобрено"
                    cell.statusLabel.textColor = .systemGreen
                case .excluded:
                    cell.statusLabel.text = "Исключено"
                    cell.statusLabel.textColor = .systemRed
                case .rejected:
                    cell.statusLabel.text = "Отклонено"
                    cell.statusLabel.textColor = .systemRed
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.supplierCellReuseIdentifier, for: indexPath) as! ReviewViewBetaSupplierCell
            let supplier = self.suppliers[indexPath.row]
            cell.nameLabel.text = supplier.name
            cell.innLabel.text = supplier.inn
            cell.phoneLabel.text = supplier.phone
            cell.contactLabel.text = supplier.contact
            if let status = supplier.status {
                switch status {
                case .onReview:
                    cell.statusLabel.text = "На рассмотрении"
                    cell.statusLabel.textColor = .systemOrange
                case .approved:
                    cell.statusLabel.text = "Одобрено"
                    cell.statusLabel.textColor = .systemGreen
                case .excluded:
                    cell.statusLabel.text = "Исключено"
                    cell.statusLabel.textColor = .systemRed
                case .rejected:
                    cell.statusLabel.text = "Отклонено"
                    cell.statusLabel.textColor = .systemRed
                }
            }
            return cell
        default:
            fatalError()
        }
    }
}
