//
//  ImagesViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 31.07.2021.
//

import UIKit
import BSImagePicker
import Photos

class ImagesViewController: UIViewController{
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    private var imagePicker = ImagePickerController()
    
    private var arrayOfImages = [UIImage]()
    
    private let countCells = 2
    private let offset: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reusableIndentify)
    }
    
    private func presentPicker() {
        presentImagePicker(imagePicker,
                           select: { (asset) in
                            print("select")
                           }, deselect: { (asset) in
                            print("deselect")
                           }, cancel: { (assets) in
                            print("cancel")
                           }, finish: { (assets) in
                            print("finish")
                           })
    }
    
    @IBAction func addImagesOnClick(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            //TODO: Open camera
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {[weak self] (action: UIAlertAction) in
            self?.presentPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        let image = arrayOfImages[indexPath.item]
        cell.imageView.image = image
        cell.deleteDidTap = {[weak self, weak collectionView] in
            guard let self = self else { return }
            self.arrayOfImages.remove(at: indexPath.item)
            collectionView?.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        
        let widthCell = frameCV.width / CGFloat(countCells)
        let heghtCell = widthCell
        
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        
        return CGSize(width: widthCell - spacing, height: heghtCell - (offset*2))
    }
}
