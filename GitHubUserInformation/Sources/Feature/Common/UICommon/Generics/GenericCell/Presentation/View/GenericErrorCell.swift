//
//  GenericErrorCell.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import UIKit

enum GenericErrorCellIdentifiers: String {
    case titleLabel = "genericErrorCell_titleLabel_id"
    case descriptionLabel = "genericErrorCell_descriptionLabel_id"
    case mainImageView = "genericErrorCell_mainImageView_id"
    case tryAgainButton = "genericErrorCell_tryAgainButton_id"
}

protocol GenericErrorCellDelegate: AnyObject {
    func tryAgain()
}

class GenericErrorCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let errorImageName: String = "icon_warning"
        static let titleLabelPaddingTop: CGFloat = 100
        static let titleText: String = LocalizableBundle.genericErrorTitle.localize
        static let descriptionText: String = LocalizableBundle.genericErrorSubtitle.localize
        static let primaryButtonDefaultText: String = LocalizableBundle.tryAgainButton.localize
    }

    // MARK: - Properties
    
    private weak var delegate: GenericErrorCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .thin, size: .extraBig)
        label.textColor = .neutralBlack
        label.text = Constants.titleText
        label.accessibilityIdentifier = GenericErrorCellIdentifiers.titleLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.tintColor = .secondaryRed
        view.contentMode = .scaleAspectFit
        view.accessibilityIdentifier = GenericErrorCellIdentifiers.mainImageView.rawValue
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionText
        label.font = UIFont(name: .regular, size: .medium)
        label.textColor = .neutralDarkGrey
        label.numberOfLines = .zero
        label.accessibilityIdentifier = GenericErrorCellIdentifiers.descriptionLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.neutralWhite, for: .normal)
        button.backgroundColor = .primaryBlue
        button.titleLabel?.font = UIFont(name: .bold, size: .medium)
        button.setTitle(Constants.primaryButtonDefaultText, for: .normal)
        button.accessibilityIdentifier = GenericErrorCellIdentifiers.tryAgainButton.rawValue
        button.cornerRadius = .size(.nano)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Instantiate
    
    static func instantiate() -> GenericErrorCell {
        let view = GenericErrorCell()
        return view
    }
    
    // MARK: - Public Methods
    
    func setup(title: String? = nil, description: String? = nil, imageName: String? = nil, buttonName: String? = nil, delegate: GenericErrorCellDelegate? = nil) {
        setupProperties(title: title,
                        description: description,
                        imageName: imageName,
                        buttonName: buttonName,
                        delegate: delegate)
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupProperties(title: String? = nil, description: String? = nil, imageName: String? = nil, buttonName: String? = nil, delegate: GenericErrorCellDelegate? = nil) {
        if let title = title, !title.isEmpty {
            self.titleLabel.text = title
        }
        if let description = description, !description.isEmpty {
            self.descriptionLabel.text = description
        }
        
        if let buttonName = buttonName, !buttonName.isEmpty {
            self.primaryButton.setTitle(buttonName, for: .normal)
        }
        self.mainImageView.image = UIImage(named: imageName ?? Constants.errorImageName)
        self.delegate = delegate
    }
    
    private func setupLayout() {
        backgroundColor = .white
        setupTitleLabelLayout()
        setupMainImageViewLayout()
        setupDescriptioLabelLayout()
        setupTryAgainButtonLayout()
    }
    
    private func setupTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.anchor(top: safeTopAnchor,
                          paddingTop: Constants.titleLabelPaddingTop)
        titleLabel.anchor(left: safeLeftAnchor,
                          right: safeRightAnchor,
                          paddingLeft: .spacing(.medium),
                          paddingRight: .spacing(.medium))
    }
    
    private func setupMainImageViewLayout() {
        addSubview(mainImageView)
        mainImageView.anchor(top: titleLabel.safeBottomAnchor,
                             paddingTop: .spacing(.medium))
        mainImageView.anchor(width: .size(.big),
                             height: .size(.big))
        mainImageView.anchor(horizontal: safeCenterXAnchor)
    }
    
    private func setupDescriptioLabelLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: mainImageView.safeBottomAnchor,
                                paddingTop: .spacing(.medium))
        descriptionLabel.anchor(left: titleLabel.safeLeftAnchor,
                                right: titleLabel.safeRightAnchor)
    }
    
    private func setupTryAgainButtonLayout() {
        addSubview(primaryButton)
        primaryButton.anchor(top: descriptionLabel.safeBottomAnchor,
                             bottom: safeBottomAnchor,
                             paddingTop: .spacing(.medium),
                             paddingBottom: .spacing(.medium))
        primaryButton.anchor(height: .size(.large))
        primaryButton.anchor(left: safeLeftAnchor,
                             right: safeRightAnchor,
                             paddingLeft: .spacing(.big),
                             paddingRight: .spacing(.big))
    }
    
    @objc
    private func tryAgain() {
        delegate?.tryAgain()
    }
}
