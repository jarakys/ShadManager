//
//  ImagesViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 31.07.2021.
//

import UIKit
import BSImagePicker
import Photos

class ImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    private let photoPicker = UIImagePickerController()
    private var imagePicker = ImagePickerController()
    
    private var arrayOfImages = [UIImage]()
    private let countCells = 2
    private let offset: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPicker.allowsEditing = true
//        photoPicker.sourceType = .camera
        photoPicker.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reusableIndentify)
        
    }
    
    private func presentPicker() {
        presentImagePicker(imagePicker,
                           select: { (asset) in
                           }, deselect: { (asset) in
                           }, cancel: { (assets) in
                           }, finish: { [weak self] (assets) in
                            guard let self = self else { return }
                            self.arrayOfImages = self.getImagesFromAsset(assets: assets)
                            self.imagesCollectionView.reloadData()
                           })
        
    }
    
    private func getImagesFromAsset(assets: [PHAsset]) -> [UIImage] {
        var arrImg = [UIImage]()
        let imgManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        for item in assets{
            imgManager.requestImage(for: item, targetSize: CGSize(width: 250,height: 250), contentMode: PHImageContentMode.aspectFit, options: requestOptions) {(img, _) in
                if let image = img {
                    arrImg.append(image)
                }
            }
        }
        return arrImg
    }
    
    @IBAction func addImagesOnClick(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.present(self.photoPicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {[weak self] (action: UIAlertAction) in
            self?.presentPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusableIndentify, for: indexPath) as! ImageCollectionViewCell
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

extension ImagesViewController {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }
        
        arrayOfImages.append(photo)
        dismiss(animated: true, completion: nil)
    }
}
