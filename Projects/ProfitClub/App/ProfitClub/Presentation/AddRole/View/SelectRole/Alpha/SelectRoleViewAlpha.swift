//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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

extension SelectRoleViewAlpha: SelectRoleViewInput {
}

final class SelectRoleViewAlpha: UIViewController {
    var output: SelectRoleViewOutput?

    private lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = #imageLiteral(resourceName: "onboard-welcome-bg")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var firstSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var supplierCheckbox: UIButton = {
        let checkbox = UIButton()
        checkbox.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        checkbox.setImage(#imageLiteral(resourceName: "checkmark-selected"), for: .selected)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()

    private lazy var supplierLabel: UILabel = {
        let supplier = UILabel()
        supplier.text = "Поставщик"
        supplier.textColor = #colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1)
        supplier.font = UIFont(name: "PlayfairDisplay-Bold", size: 17.0)
        supplier.translatesAutoresizingMaskIntoConstraints = false
        return supplier
    }()

    private lazy var supplierSubtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "юридическое или физическое лицо, поставляющие товары или услуги заказчикам. Регистрация в роли поставщика даст вам возможность рассылать свои комерческие предложения, а так же создавать акции и рассылать их организациям вступившим в клуб."
        subtitle.textColor = #colorLiteral(red: 0.8745098039, green: 0.7921568627, blue: 0.7647058824, alpha: 1)
        subtitle.font = UIFont(name: "Montserrat-Regular", size: 13.0)
        subtitle.numberOfLines = .zero
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()

    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var organizationCheckbox: UIButton = {
        let checkbox = UIButton()
        checkbox.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        checkbox.setImage(#imageLiteral(resourceName: "checkmark-selected"), for: .selected)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()

    private lazy var organizationLabel: UILabel = {
        let organization = UILabel()
        organization.text = "Организация"
        organization.textColor = #colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1)
        organization.font = UIFont(name: "PlayfairDisplay-Bold", size: 17.0)
        organization.translatesAutoresizingMaskIntoConstraints = false
        return organization
    }()

    private lazy var organizationSubtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "организационно-правовая форма юридического лица преследующая прибыль в качестве основной цели своей деятельности. Регистрация в роли организации даст вам возможность участвовать в акциях от поставщиков и принимать или отклонять их коммерческие предложения для успешного ведения вашего бизнесса. Организация может приглашать в клуб своих сотрудников."
        subtitle.textColor = #colorLiteral(red: 0.8745098039, green: 0.7921568627, blue: 0.7647058824, alpha: 1)
        subtitle.font = UIFont(name: "Montserrat-Regular", size: 13.0)
        subtitle.numberOfLines = .zero
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()

    private lazy var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var memberCheckbox: UIButton = {
        let checkbox = UIButton()
        checkbox.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        checkbox.setImage(#imageLiteral(resourceName: "checkmark-selected"), for: .selected)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()

    private lazy var memberLabel: UILabel = {
        let member = UILabel()
        member.text = "Участник"
        member.textColor = #colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1)
        member.font = UIFont(name: "PlayfairDisplay-Bold", size: 17.0)
        member.translatesAutoresizingMaskIntoConstraints = false
        return member
    }()

    private lazy var memberSubtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "участником является лицо, обладающее правом членства в конкретной организации. Стать участником организации в клубе вы можете только по предварительному приглашению."
        subtitle.textColor = #colorLiteral(red: 0.8745098039, green: 0.7921568627, blue: 0.7647058824, alpha: 1)
        subtitle.font = UIFont(name: "Montserrat-Regular", size: 13.0)
        subtitle.numberOfLines = .zero
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()

    private lazy var supplierButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(SelectRoleViewAlpha.supplierButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var organizationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(SelectRoleViewAlpha.organizationButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var memberButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(SelectRoleViewAlpha.memberButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        button.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7843137255, blue: 0.568627451, alpha: 1)
        button.addTarget(self, action: #selector(SelectRoleViewAlpha.continueButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var checkboxes = [UIButton]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.layout()

        checkboxes.append(supplierCheckbox)
        checkboxes.append(organizationCheckbox)
        checkboxes.append(memberCheckbox)
    }

    private func setup() {
        view.backgroundColor = .clear
        navigationItem.title = "Выбор роли"

        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        } else {
            blurEffect = UIBlurEffect(style: .dark)
        }
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.backgroundImageView.addSubview(blurVisualEffectView)
    }

    private var selectedRole: PCRole? {
        didSet {
            self.continueButton.isEnabled = self.selectedRole != nil
        }
    }

    @objc private func continueButtonTouchUpInside(_ sender: Any) {
        if let role = self.selectedRole {
            self.output?.selectRole(view: self, didSelect: role)
        }
    }

    @objc private func memberButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.memberCheckbox.isSelected.toggle()
        if self.memberCheckbox.isSelected {
            self.selectedRole = .member
        }
    }

    @objc private func supplierButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.supplierCheckbox.isSelected.toggle()
        if self.supplierCheckbox.isSelected {
            self.selectedRole = .supplier
        }
    }

    @objc private func organizationButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.organizationCheckbox.isSelected.toggle()
        if self.organizationCheckbox.isSelected {
            self.selectedRole = .organization
        }
    }
}

// MARK: - Layout
extension SelectRoleViewAlpha {
    private func layout() {
        layoutBackgroundImage(in: view)
        layoutScrollView(in: view)
        layoutContentView(in: scrollView)
        layoutFirstView(in: contentView)
        layoutFirstSeparator(in: contentView)
        layoutSupplierCheckBox(in: contentView)
        layoutSupplierLabel(in: contentView)
        layoutSupplierSubtitle(in: contentView)
        layoutSecondView(in: contentView)
        layoutSecondSeparator(in: contentView)
        layoutOrganizationCheckBox(in: contentView)
        layoutOrganizationLabel(in: contentView)
        layoutOrganizationSubtitle(in: contentView)
        layoutThirdView(in: contentView)
        layoutMemberCheckBox(in: contentView)
        layoutMemberLabel(in: contentView)
        layoutMemberSubtitle(in: contentView)
        layoutSupplierButton(in: contentView)
        layoutOrganizationButton(in: contentView)
        layoutMemberButton(in: contentView)
        layoutContinueButton(in: view)
    }

    private func layoutBackgroundImage(in container: UIView) {
        let backgroundImage = backgroundImageView
        container.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }

    private func layoutScrollView(in container: UIView) {
        let scroll = scrollView
        container.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 30.0),
            scroll.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30.0),
            scroll.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30.0)
        ])
    }

    private func layoutContentView(in scroll: UIScrollView) {
        let view = contentView
        scroll.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: 0)
        ])
    }

    private func layoutFirstView(in container: UIView) {
        let view = firstView
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        ])
    }

    private func layoutFirstSeparator(in container: UIView) {
        let separator = firstSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18.0),
            separator.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }

    private func layoutSupplierCheckBox(in container: UIView) {
        let checkbox = supplierCheckbox
        container.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            checkbox.centerYAnchor.constraint(equalTo: firstView.centerYAnchor)
        ])
    }

    private func layoutSupplierLabel(in container: UIView) {
        let label = supplierLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: firstView.topAnchor, constant: 0) // was error!
        ])
    }

    private func layoutSupplierSubtitle(in container: UIView) {
        let subtitle = supplierSubtitle
        container.addSubview(subtitle)
        NSLayoutConstraint.activate([
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0), // storyboard boshqacha
            subtitle.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 0),
            subtitle.bottomAnchor.constraint(equalTo: firstSeparator.topAnchor, constant: -20.0),
            subtitle.topAnchor.constraint(equalTo: supplierLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutSecondView(in container: UIView) {
        let view = secondView
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        ])
    }

    private func layoutSecondSeparator(in container: UIView) {
        let separator = secondSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18.0),
            separator.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }

    private func layoutOrganizationCheckBox(in container: UIView) {
        let checkbox = organizationCheckbox
        container.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            checkbox.centerYAnchor.constraint(equalTo: secondView.centerYAnchor)
        ])
    }

    private func layoutOrganizationLabel(in container: UIView) {
        let label = organizationLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0),
            label.topAnchor.constraint(equalTo: firstSeparator.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: secondView.topAnchor, constant: 0)
        ])
    }

    private func layoutOrganizationSubtitle(in container: UIView) {
        let subtitle = organizationSubtitle
        container.addSubview(subtitle)
        NSLayoutConstraint.activate([
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0), // storyboard boshqacha
            subtitle.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 0),
            subtitle.bottomAnchor.constraint(equalTo: secondSeparator.topAnchor, constant: -20.0),
            subtitle.topAnchor.constraint(equalTo: organizationLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutThirdView(in container: UIView) {
        let view = thirdView
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        ])
    }

    private func layoutMemberCheckBox(in container: UIView) {
        let checkbox = memberCheckbox
        container.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            checkbox.centerYAnchor.constraint(equalTo: thirdView.centerYAnchor)
        ])
    }

    private func layoutMemberLabel(in container: UIView) {
        let label = memberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0),
            label.topAnchor.constraint(equalTo: secondSeparator.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: thirdView.topAnchor, constant: 0)
        ])
    }

    private func layoutMemberSubtitle(in container: UIView) {
        let subtitle = memberSubtitle
        container.addSubview(subtitle)
        NSLayoutConstraint.activate([
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.0), // storyboard boshqacha
            subtitle.topAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: 0),
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0),
            subtitle.topAnchor.constraint(equalTo: memberLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutSupplierButton(in container: UIView) {
        let button = supplierButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: firstSeparator.topAnchor, constant: 0)
        ])
    }

    private func layoutOrganizationButton(in container: UIView) {
        let button = organizationButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: supplierButton.bottomAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: secondSeparator.topAnchor, constant: 0)
        ])
    }

    private func layoutMemberButton(in container: UIView) {
        let button = memberButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: organizationButton.bottomAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }

    private func layoutContinueButton(in container: UIView) {
        let button = continueButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8.0),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
}
