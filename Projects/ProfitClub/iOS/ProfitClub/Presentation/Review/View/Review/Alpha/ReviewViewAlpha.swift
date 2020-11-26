//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 25.11.2020
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

final class ReviewViewAlpha: UITableViewController {
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
        setup()

        tableView.register(ReviewViewAlphaOrganizationCell.self, forCellReuseIdentifier: ReviewViewAlphaOrganizationCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaSupplierCell.self, forCellReuseIdentifier: ReviewViewAlphaSupplierCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaMemberCell.self, forCellReuseIdentifier: ReviewViewAlphaMemberCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaAdminCell.self, forCellReuseIdentifier: ReviewViewAlphaAdminCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setup() {
        self.navigationItem.hidesBackButton = true
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .white

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ReviewViewAlpha.pullToRefreshValueChanged(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl

        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Profit Club"
        label.font = UIFont(name: "PlayfairDisplay-Bold", size: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "barItem"), style: .plain, target: self, action: #selector(ReviewViewAlpha.rightBarButtonTouchUpInside(_:)))
        self.navigationItem.rightBarButtonItem  = button
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.review(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }

    @objc private func rightBarButtonTouchUpInside(_ sender: Any) {
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
}

extension ReviewViewAlpha: ReviewViewInput {
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

extension ReviewViewAlpha {
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

extension ReviewViewAlpha {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.members.isEmpty ? nil : "Участник"
        case 1:
            return self.organizations.isEmpty ? nil : "Организации"
        case 2:
            return self.suppliers.isEmpty ? nil : "Поставщики"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headrView = UIView()

        let headerLabel = UILabel(frame: CGRect(x: 20, y: 20, width:
        tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "PlayfairDisplay-Regular", size: 18.0)
        headerLabel.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7013859161)
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headrView.addSubview(headerLabel)

        return headrView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewViewAlphaMemberCell.reuseIdentifier, for: indexPath) as! ReviewViewAlphaMemberCell
            let member = self.members[indexPath.row]
            cell.memberFullnameLabel.text = (member.firstName ?? "") + " " + (member.lastName ?? "")
            if let status = member.status {
                switch status {
                case .onReview:
                    cell.memberStatusLabel.text = "На рассмотрении"
                    cell.memberStatusLabel.textColor = .systemOrange
                case .approved:
                    cell.memberStatusLabel.text = "Одобрено"
                    cell.memberStatusLabel.textColor = .systemGreen
                case .excluded:
                    cell.memberStatusLabel.text = "Исключено"
                    cell.memberStatusLabel.textColor = .systemRed
                case .rejected:
                    cell.memberStatusLabel.text = "Отклонено"
                    cell.memberStatusLabel.textColor = .systemRed
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewViewAlphaOrganizationCell.reuseIdentifier, for: indexPath) as! ReviewViewAlphaOrganizationCell
            let organization = self.organizations[indexPath.row]
            cell.organizationNameLabel.text = organization.name
            cell.organizationINNLabel.text = organization.inn
            cell.organizationPhoneNumberLabel.text = organization.phone
            cell.organizationContactLabel.text = organization.contact
            if let status = organization.status {
                switch status {
                case .onReview:
                    cell.organizationStatusLabel.text = "На рассмотрении"
                    cell.organizationStatusLabel.textColor = .systemOrange
                case .approved:
                    cell.organizationStatusLabel.text = "Одобрено"
                    cell.organizationStatusLabel.textColor = .systemGreen
                case .excluded:
                    cell.organizationStatusLabel.text = "Исключено"
                    cell.organizationStatusLabel.textColor = .systemRed
                case .rejected:
                    cell.organizationStatusLabel.text = "Отклонено"
                    cell.organizationStatusLabel.textColor = .systemRed
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewViewAlphaSupplierCell.reuseIdentifier, for: indexPath) as! ReviewViewAlphaSupplierCell
            let supplier = self.suppliers[indexPath.row]
            cell.supplierNameLabel.text = supplier.name
            cell.supplierINNLabel.text = supplier.inn
            cell.supplierPhoneNumberLabel.text = supplier.phone
            cell.supplierContactLabel.text = supplier.contact
            if let status = supplier.status {
                switch status {
                case .onReview:
                    cell.supplierStatusLabel.text = "На рассмотрении"
                    cell.supplierStatusLabel.textColor = .systemOrange
                case .approved:
                    cell.supplierStatusLabel.text = "Одобрено"
                    cell.supplierStatusLabel.textColor = .systemGreen
                case .excluded:
                    cell.supplierStatusLabel.text = "Исключено"
                    cell.supplierStatusLabel.textColor = .systemRed
                case .rejected:
                    cell.supplierStatusLabel.text = "Отклонено"
                    cell.supplierStatusLabel.textColor = .systemRed
                }
            }
            return cell
        default:
            fatalError()
        }
    }
}

