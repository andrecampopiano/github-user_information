//
//  GenericLoadingCell.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

enum GenericLoadingCellIdentifiers: String {
    case titleLabel = "genericLoadingCell_titleLabel_id"
    case descriptionLabel = "genericLoadingCell_descriptionLabel_id"
    case activityView = "genericLoadingCell_activityView_id"
}

class GenericLoadingCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let activityIndicatorScale: CGFloat = 1.25
        static let titleLabelPaddingTop: CGFloat = 100
        static let titleLabelPaddingLeft: CGFloat = 24
        static let titleLabelPaddingRight: CGFloat = 24
        static let activityIndicatorSize: CGFloat = 50
        static let activityIndicatorPaddingTop: CGFloat = 24
        static let descriptionLabelPaddingTop: CGFloat = 24
        static let titleText: String = LocalizableBundle.loadingViewTitle.localize
        static let descriptionText: String = LocalizableBundle.loadingViewSubtitle.localize
    }

    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.accessibilityIdentifier = GenericLoadingCellIdentifiers.titleLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.transform = CGAffineTransform(scaleX: Constants.activityIndicatorScale, y: Constants.activityIndicatorScale)
        view.startAnimating()
        view.accessibilityIdentifier = GenericLoadingCellIdentifiers.activityView.rawValue
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionText
        label.accessibilityIdentifier = GenericLoadingCellIdentifiers.descriptionLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Instantiate
    
    static func instantiate() -> GenericLoadingCell {
        let view = GenericLoadingCell()
        return view
    }
    
    // MARK: - Public Methods
    
    func setup(title: String? = nil, description: String? = nil) {
        if let title = title {
            self.titleLabel.text = title
        }
        if let description = description {
            self.descriptionLabel.text = description
        }
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        setupTitleLabelLayout()
        setupActivityViewLayout()
        setupDescriptioLabelLayout()
    }
    
    private func setupTitleLabelLayout() {
        addSubview(titleLabel)
        titleLabel.anchor(top: safeTopAnchor, paddingTop: Constants.titleLabelPaddingTop)
        titleLabel.anchor(left: safeLeftAnchor, right: safeRightAnchor, paddingLeft: Constants.titleLabelPaddingLeft, paddingRight: Constants.titleLabelPaddingRight)
    }
    
    private func setupActivityViewLayout() {
        addSubview(activityView)
        activityView.anchor(top: titleLabel.safeBottomAnchor, paddingTop: Constants.activityIndicatorPaddingTop)
        activityView.anchor(width: Constants.activityIndicatorSize, height: Constants.activityIndicatorSize)
        activityView.anchor(horizontal: safeCenterXAnchor)
    }
    
    private func setupDescriptioLabelLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: activityView.safeBottomAnchor, bottom: safeBottomAnchor, paddingTop: Constants.descriptionLabelPaddingTop, paddingBottom: Constants.descriptionLabelPaddingTop)
        descriptionLabel.anchor(left: titleLabel.safeLeftAnchor, right: titleLabel.safeRightAnchor)
    }
}
