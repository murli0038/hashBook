//
//  TagwithPhotoView.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 10/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import CoreData
import AssetsLibrary


class FontCell : UICollectionViewCell
{
    @IBOutlet weak var fontName: UILabel!
}
class TagwithPhotoView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,DTColorPickerImageViewDelegate
{
    
    
    // MARK: -Outlets
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var imageTag: UIImageView!
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var detailTag: UILabel!
    @IBOutlet weak var tagColor: UIButton!
    @IBOutlet weak var tagFont: UIButton!
    @IBOutlet weak var ColorView: UIView!
    @IBOutlet weak var Fontview: UIView!
    @IBOutlet weak var sliderFont: UISlider!
    @IBOutlet weak var tagBackgroundColor: UIButton!
    @IBOutlet weak var tagTextColor: UIButton!
    @IBOutlet weak var fontColorImage: DTColorPickerImageView!
    @IBOutlet weak var tagAndimage: UIView!
    @IBOutlet weak var takePhoto: UILabel!
    
    var visualEffectView = UIVisualEffectView()
    
    
    
    
    
    // MARK: -Variables
    
    var editTag : String = ""
    
    var EditCore : [NSManagedObject] = []
    
    var imagePicker = UIImagePickerController()
    var mainImage : UIImage!
    var currentFont = String()
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)

        
        var blureEffect = UIVisualEffect()
        blureEffect = UIBlurEffect.init(style: UIBlurEffect.Style.dark)
        visualEffectView = UIVisualEffectView.init(effect: blureEffect)
        visualEffectView.alpha = 0.9
     
        
        detailTag.text = editTag
        
        imagePicker.delegate = self
        fontColorImage.delegate = self
        
        
        galleryBtn.layer.cornerRadius = 10
        tagColor.layer.cornerRadius = 10
        tagFont.layer.cornerRadius = 10
        tagBackgroundColor.layer.cornerRadius = 10
        tagTextColor.layer.cornerRadius = 10
        
        ColorView.isHidden = true
        Fontview.isHidden = true
        
        
        currentFont = UIFont.familyNames[0]
        detailTag.font = UIFont.init(name: UIFont.familyNames[0], size: 30.0)
        
        tagColor.imageView?.contentMode = .scaleAspectFit
        tagColor.setImage(tagColor.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        tagColor.tintColor = .white

        tagFont.imageView?.contentMode = .scaleAspectFit
        tagFont.setImage(tagFont.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        tagFont.tintColor = .white
        
        
        detailTag.backgroundColor = UIColor.clear
        detailTag.textColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    // MARK: -CollectionView For Font
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return UIFont.familyNames.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fontCell", for: indexPath) as! FontCell
        
        cell.fontName.font = UIFont.init(name: UIFont.familyNames[indexPath.row], size: 18.0)
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentFont = UIFont.familyNames[indexPath.row]
        sliderFont.value = 30.0
        detailTag.font = UIFont.init(name: UIFont.familyNames[indexPath.row], size: 30.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 80, height: 40)
        
    }
    
    // MARK:-Pick Image From Gallary
    func openCamera() {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
            
            
        } else {
            
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func openGallary() {
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        mainImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageTag.image = mainImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        takePhoto.isHidden = false
        
    }
    // MARK: -GallaryPressed
    @IBAction func gallaryBtnPressed(_ sender: UIButton)
    {
        print("Gallary Pressed")
        let alert = UIAlertController(title: "Select Image from", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            
            self.openCamera()
            self.takePhoto.isHidden = true
            
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
            
            self.openGallary()
            self.takePhoto.isHidden = true
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { _ in
            
            self.takePhoto.isHidden = false
        }))
        self.present(alert, animated: true, completion: nil)
        UIButton.animate(withDuration: 0.1,animations:
            {
                 sender.transform = CGAffineTransform(scaleX: 0.800, y: 0.80)
                //(scaleX: 0.975, y: 0.96)
        },completion:
            { finish in
                
                UIButton.animate(withDuration: 0.2, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
        ColorView.isHidden = true
        Fontview.isHidden = true
    }
    
    // MARK: -TagColorPressed
    @IBAction func tagColorPressed(_ sender: UIButton)
    {
        ColorView.fadeTransition(0.5)
        Fontview.isHidden = true
        
        if ColorView.isHidden {
            
            ColorView.isHidden = false
            
        } else {
            
            ColorView.isHidden = true
            
        }
        UIButton.animate(withDuration: 0.1,animations:
            {
                 sender.transform = CGAffineTransform(scaleX: 0.800, y: 0.80)
                //(scaleX: 0.975, y: 0.96)
        },completion:
            { finish in
                
                UIButton.animate(withDuration: 0.2, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
    }
    // MARK: - Fuction For Tag Font
    @IBAction func tagFontPressed(_ sender: UIButton)
    {
        ColorView.isHidden = true
        
        Fontview.fadeTransition(0.5)
        
        if Fontview.isHidden {
            
            Fontview.isHidden = false
            
        } else {
            
            Fontview.isHidden = true
            
        }
        UIButton.animate(withDuration: 0.1,animations:
            {
                sender.transform = CGAffineTransform(scaleX: 0.800, y: 0.80)
                //(scaleX: 0.975, y: 0.96)
        },completion:
            { finish in
                
                UIButton.animate(withDuration: 0.2, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
        
    }
    // MARK: - Slider
    @IBAction func sliderFontPressed(_ sender: UISlider)
    {
        detailTag.font = UIFont.init(name: currentFont, size: CGFloat(sender.value))
    }
    
    
    // MARK: - Function For Tag Color
    @IBAction func tagColorModify(_ sender: UIButton)
    {
        tagBackgroundColor.setTitleColor(UIColor.white, for: .normal)
        tagTextColor.setTitleColor(UIColor.white, for: .normal)

        if sender.tag == 1 {

            tagBackgroundColor.setTitleColor(UIColor.yellow, for: .normal)

        } else if sender.tag == 2 {

            tagTextColor.setTitleColor(UIColor.yellow, for: .normal)

        }
        UIButton.animate(withDuration: 0.1,animations:
            {
                 sender.transform = CGAffineTransform(scaleX: 0.800, y: 0.80)
                //(scaleX: 0.975, y: 0.96)
        },completion:
            { finish in
                
                UIButton.animate(withDuration: 0.2, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
    }
    func imageView(_ imageView: DTColorPickerImageView, didPickColorWith color: UIColor) {

        if tagBackgroundColor.titleColor(for: .normal) == UIColor.yellow
        {
            
            detailTag.backgroundColor = color
            
        } else {
            
            detailTag.textColor = color
            
        }
     }
    override func viewWillAppear(_ animated: Bool) {

        tagBackgroundColor.sendActions(for: .touchUpInside)

    }
    
    // MARK: -Done Pressed
    @IBAction func donebtnPressed(_ sender: Any)
    {
        let image = self.image(with: tagAndimage)
        let shareAll = [image as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    // MARK: -Save Pressed
    
    @IBAction func savePressed(_ sender: Any)
    {
        if !(takePhoto.isHidden)
        {
            let alert = UIAlertController(title: "Don't Worry !!", message: "Please choose photo from Gallery", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            takePhoto.isHidden = true
            let alert = UIAlertController(title: "Save", message: "Would you like to save photo??", preferredStyle: .alert)
            let yeah = UIAlertAction(title: "Yeah", style: .default) { (action) in
                let image = self.image(with: self.tagAndimage)
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(yeah)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func image(with view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
            
        }
        
        return nil
    }
    
    
    
    
}

// MARK: - Color & Font view Animation
extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
