//
//  ImagesViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 31.07.2021.
//

import UIKit
import PhotosUI


@available(iOS 14, *)
class ImagesViewController: UIViewController{

    var configuration = PHPickerConfiguration()
    var arrayOfImages = [UIImage]()
    
    let countCells = 2
    let offset: CGFloat = 5.0
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBAction func addImagesOnClick(_ sender: UIButton) {
        
        let imgPicker = PHPickerViewController(configuration: configuration)
        imgPicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            
            }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {(action: UIAlertAction) in
        self.present(imgPicker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration.filter = .images
        configuration.selectionLimit = 10
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellImage")
    }


}

@available(iOS 14, *)
extension ImagesViewController: PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
    {
        for result in results{
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {[weak self](object, error) in
                guard let self = self else { return }
                if let image = object as? UIImage {
                    self.arrayOfImages.append(image)
                    DispatchQueue.main.async {
                        self.imagesCollectionView.reloadData()
                    }
                    
                }
            })
        }
        picker.dismiss(animated: true, completion: nil)
        
    }




}
    
@available(iOS 14, *)
extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
        let image = arrayOfImages[indexPath.item]
        cell.imageView.image = image
        cell.deleteDidTap = {[weak self] in
            guard let self = self else { return }
            self.arrayOfImages.remove(at: indexPath.item)
            collectionView.reloadData()
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
