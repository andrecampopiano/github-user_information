//
//  GenericCell.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

class GenericCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageNameDefault: String = "image_default"
        static let imageViewSize: CGFloat = 70
        static let imageViewPaddingLeft: CGFloat = 16
        static let imageViewPaddingTop: CGFloat = 16
        static let imageViewPaddingBottom: CGFloat = 16
        static let titleLabelPaddingTop: CGFloat = 8
        static let titleLabelPaddingLeft: CGFloat = 16
        static let titleLabelPaddingRight: CGFloat = 16
        static let subtitleLabelPaddingTop: CGFloat = 4
        static let subtitleLabelPaddingBottom: CGFloat = 8
        static let avatarViewBoderWidth: CGFloat = 2
    }
    
    // MARK: - Properties
    
    private var viewModel: GenericCellViewModelProtocol?
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.cornerRadius = Constants.imageViewSize / 2
        imageView.borderColor = .black
        imageView.borderWidth = Constants.avatarViewBoderWidth
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    func setup(viewModel: GenericCellViewModelProtocol) {
        self.viewModel = viewModel
        bindElements()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func bindElements() {
        viewModel?.title.bind { [weak self] text in
            guard let self = self else { return }
            self.titleLabel.text = text
        }
        
        viewModel?.subtitle.bind { [weak self] text in
            guard let self = self else { return }
            self.subtitleLabel.text = text
        }
        
        viewModel?.imageUrl.bind { [weak self] imageUrl in
            guard let self = self else { return }
            self.avatarView.downloaded(from: imageUrl ?? String())
        }
    }
    
    private func setupLayout() {
        setupImageViewLayout()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupImageViewLayout() {
        addSubview(avatarView)
        avatarView.anchor(width: Constants.imageViewSize,
                          height: Constants.imageViewSize)
        avatarView.anchor(left: safeLeftAnchor,
                          paddingLeft: Constants.imageViewPaddingLeft)
        avatarView.anchor(top: safeTopAnchor,
                          bottom: safeBottomAnchor,
                          paddingTop: Constants.imageViewPaddingTop,
                          paddingBottom: Constants.imageViewPaddingBottom)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: avatarView.safeTopAnchor)
        titleLabel.anchor(left: avatarView.safeRightAnchor,
                          right: safeRightAnchor,
                          paddingLeft: Constants.titleLabelPaddingLeft,
                          paddingRight: Constants.titleLabelPaddingRight)
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.safeBottomAnchor,
                             paddingTop: Constants.subtitleLabelPaddingTop)
        subtitleLabel.anchor(left: avatarView.safeRightAnchor,
                             right: safeRightAnchor,
                             paddingLeft: Constants.titleLabelPaddingLeft,
                             paddingRight: Constants.titleLabelPaddingRight)
    }
}
