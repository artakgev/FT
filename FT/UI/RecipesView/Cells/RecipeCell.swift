//
//  RecipeCell.swift
//  FT
//
//  Created by Artak Gevorgyan on 16.10.23.
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import UIKit
import Kingfisher

final class RecipeCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!
    
    // MARK: - Public properties
    
    public var model: Recipe? {
        didSet {
            guard let model = model else { return }
            setupByModel(model)
        }
    }
    // MARK: - Private methods
    
    private func setupByModel(_ model: Recipe) {
        setupLogo(url: model.photoUrlSmall)
        titleLabel.text = model.name
        cuisineLabel.text = model.cuisine
    }
    
    private func setupLogo(url: String?) {
        guard let urlString = url,
              let imageUrl = URL(string: urlString) else { return }
        logoImageView.kf.setImage(with: imageUrl)
    }

    // MARK: - UI elements initialization
        
    private func initLogoImageView() {
//        logoImageView.layer.cornerRadius = logoImageView.frame.width/2
//        logoImageView.backgroundColor = UIColor.tabbarBackground
    }
    
    private func initTitleLabel() {
//        titleLabel.setStyle(typography: Styling.SingleTransactionInfoView.estiblishmentTitleLabelFont,
//                            color: Styling.SingleTransactionInfoView.estiblishmentTitleLabelColor)
    }
    
    private func initAmountLabel() {
        
    }
    
    private func initTimeLabel() {
//        dateLabel.setStyle(typography: Styling.SingleTransactionInfoView.estiblishmentTimeLabelFont,
//                           color: Styling.SingleTransactionInfoView.estiblishmentTimeLabelColor)
    }
    
    private func initIDLabel() {
//        idLabel.setStyle(typography: Styling.SingleTransactionInfoView.estiblishmentIDLabelFont,
//                         color: Styling.SingleTransactionInfoView.estiblishmentIDLabelColor)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        initLogoImageView()
        initTitleLabel()
        initAmountLabel()
        initTimeLabel()
        initIDLabel()
    }

    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
    
}
