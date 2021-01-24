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
import PCModel

final class ReviewViewAlpha: UITableViewController {
    var output: ReviewViewOutput?
    var isAdministrator: Bool = false {
        didSet {
            if self.isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    
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

    private var rightBarButtonImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        tableView.register(ReviewViewAlphaOrganizationCell.self, forCellReuseIdentifier: ReviewViewAlphaOrganizationCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaSupplierCell.self, forCellReuseIdentifier: ReviewViewAlphaSupplierCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaMemberCell.self, forCellReuseIdentifier: ReviewViewAlphaMemberCell.reuseIdentifier)
        tableView.register(ReviewViewAlphaAdminCell.self, forCellReuseIdentifier: ReviewViewAlphaAdminCell.reuseIdentifier)

        self.output?.reviewViewDidLoad(view: self)
    }

    private enum Section: Int {
        case administrator = 0
        case member = 1
        case organization = 2
        case supplier = 3
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

        #if SWIFT_PACKAGE
        rightBarButtonImage = UIImage(named: "barItem", in: Bundle.module, compatibleWith: nil)
        #else
        rightBarButtonImage = UIImage(named: "barItem", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        let button = UIBarButtonItem(image: rightBarButtonImage, style: .plain, target: self, action: #selector(ReviewViewAlpha.rightBarButtonTouchUpInside(_:)))
        self.navigationItem.rightBarButtonItem  = button
    }

    @objc private func pullToRefreshValueChanged(_ sender: UIRefreshControl) {
        self.output?.review(view: self, userWantsToRefresh: sender)
        sender.endRefreshing()
    }

    @objc private func rightBarButtonTouchUpInside(_ sender: Any) {
        self.output?.review(view: self, tappenOn: sender)
    }
}

extension ReviewViewAlpha: ReviewViewInput {
}

extension ReviewViewAlpha {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .administrator:
            self.output?.reviewUserDidTapOnAdmin(view: self)
        case .member:
            let member = self.members[indexPath.row]
            self.output?.review(view: self, userTappedOn: member)
        case .organization:
            let organization = self.organizations[indexPath.row]
            self.output?.review(view: self, userTappedOn: organization)
        case .supplier:
            let supplier = self.suppliers[indexPath.row]
            self.output?.review(view: self, userTappedOn: supplier)
        }
    }
}

extension ReviewViewAlpha {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            return nil
        }
        switch section {
        case .administrator:
            return nil
        case .member:
            return self.members.isEmpty ? nil : "Участники"
        case .organization:
            return self.organizations.isEmpty ? nil : "Организации"
        case .supplier:
            return self.suppliers.isEmpty ? nil : "Поставщики"
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
        return 4
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        switch section {
        case .administrator:
            return isAdministrator ? 1 : 0
        case .member:
            return self.members.count
        case .organization:
            return self.organizations.count
        case .supplier:
            return self.suppliers.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .administrator:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewViewAlphaAdminCell.reuseIdentifier, for: indexPath) as! ReviewViewAlphaAdminCell
            cell.adminLabel.text = "Администратор"
            return cell
        case .member:
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
        case .organization:
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
        case .supplier:
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
        }
    }
}

