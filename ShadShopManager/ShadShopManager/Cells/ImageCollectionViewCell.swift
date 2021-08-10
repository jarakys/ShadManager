//
//  ImageCollectionViewCell.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 31.07.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteDidTap: (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.layer.backgroundColor = UIColor.gray.cgColor
    }
    
    @IBAction func deleteButtonOnClick(_ sender: Any) {
        deleteDidTap?()
    }
}
