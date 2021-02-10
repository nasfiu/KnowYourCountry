//
//  CountryInfoTableViewCell.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import SDWebImage
import UIKit

final class CountryInfoTableViewCell: UITableViewCell {
    
    private let placeholderImage = "Imageplaceholder"
    private let imageViewWidth: CGFloat = 60
    private let imageViewHeight: CGFloat = 50
    
    private let backgroundImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: TextSizes.title)
        label.textColor = TextColor.titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: TextSizes.bodyText)
        label.textColor = TextColor.bodyTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupLayout()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundImageView.image = nil
    }

    func updateCellUI(countryInfoItem: CountryDetailItem) {
        titleLabel.text = countryInfoItem.title ?? ""
        descriptionLabel.text = countryInfoItem.description ?? ""
        if let imageUrl = countryInfoItem.image {
            backgroundImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: placeholderImage))
        }
        else {
            backgroundImageView.image = UIImage(named: placeholderImage)
        }
    }
}

private extension CountryInfoTableViewCell {
    
    func addSubViews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
    }
    
// MARK: Layout Constraints
    
    func setupLayout() {
        self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: LayoutConstants.horizontalMargin).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -LayoutConstants.horizontalMargin).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: LayoutConstants.innerMargin).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -LayoutConstants.innerMargin).isActive = true
        
        backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.innerMargin).isActive = true
        backgroundImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.innerMargin).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: LayoutConstants.innerMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: LayoutConstants.innerMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -LayoutConstants.innerMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -LayoutConstants.innerMargin).isActive = true
        
        descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -LayoutConstants.innerMargin).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: LayoutConstants.innerMargin).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -LayoutConstants.innerMargin).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: LayoutConstants.innerMargin).isActive = true
    }
}
