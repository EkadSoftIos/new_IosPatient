//
//  ImageCell.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/6/22.
//

import UIKit

protocol ImageCellPresenter:AnyObject{
    func deleteImage(at indexPath:IndexPath)
}

protocol ImageCellProtocol {
    func config(image:UIImage, indexPath:IndexPath, presenter:ImageCellPresenter)
}


class ImageCell: UICollectionViewCell, ImageCellProtocol {
    
    // MARK: - Outlet variables -
    @IBOutlet weak var epImageView: UIImageView!
    
    // MARK: - private properties -
    private var indexPath:IndexPath!
    private weak var presenter:ImageCellPresenter?
    
    // MARK: - config -
    func config(image: UIImage, indexPath: IndexPath, presenter: ImageCellPresenter) {
        self.indexPath = indexPath
        self.presenter = presenter
        epImageView.image = image
    }
    
    // MARK: - delete Action -
    @IBAction func deleteBtnTapped(_ sender: Any) {
        presenter?.deleteImage(at: indexPath)
    }
    
}
