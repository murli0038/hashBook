//
//  NewTagEdit.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 17/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import CoreData
import AssetsLibrary

class Fcell : UICollectionViewCell
{
    @IBOutlet weak var fontName: UILabel!
}
class NewTagEdit: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,DTColorPickerImageViewDelegate
{
    
    
    // MARK: -IBOutlets
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var gallerybtn: UIButton!
    @IBOutlet weak var tagColorbtn: UIButton!
    @IBOutlet weak var tagFontbtn: UIButton!
    @IBOutlet weak var tagWithImage: UIView!
    @IBOutlet weak var takePhoto: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var newEditTag: UILabel!
    @IBOutlet weak var ColorVIew: UIView!
    @IBOutlet weak var tagBackGroundbtn: UIButton!
    @IBOutlet weak var tagTextColorbtn: UIButton!
    @IBOutlet weak var fontColorimage: DTColorPickerImageView!
    @IBOutlet weak var FontView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    // MARK: -Variables
    
    var edTag : String = ""
    var imagePicker = UIImagePickerController()
    var mainImage : UIImage!
    var currentFont = String()
    var EditCore : [NSManagedObject] = []
    
    
    var newTagEdit = newTagCell()
    
    let cell = newTagCell()
    
    // MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)
        
        
        let appD = UIApplication.shared.delegate as! AppDelegate
        let context = appD.persistentContainer.viewContext
        
        let fetcRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetcRequest.sortDescriptors = [NSSortDescriptor(key: "newTag", ascending: true)]
        
        do
        {
            EditCore = try context.fetch(fetcRequest)
            if let score = EditCore[newTagEdit.tag].value(forKey: "newTag")
            {
                newEditTag.text = (score as! String)
                //print(EditCore[newTagEdit.tag])
                
            }
        }
        catch
        {
            print("catch block run")
        }
        
//        newEditTag.text = edTag
//        print("The Tags is :\(edTag)")
        
        gallerybtn.layer.cornerRadius = 10
        tagColorbtn.layer.cornerRadius = 10
        tagFontbtn.layer.cornerRadius = 10
        tagBackGroundbtn.layer.cornerRadius = 10
        tagTextColorbtn.layer.cornerRadius = 10
        
        ColorVIew.isHidden = true
        FontView.isHidden = true
        
        imagePicker.delegate = self
        fontColorimage.delegate = self
        
        
        tagColorbtn.imageView?.contentMode = .scaleAspectFit
        tagColorbtn.setImage(tagColorbtn.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        tagColorbtn.tintColor = .white
        
        tagFontbtn.imageView?.contentMode = .scaleAspectFit
        tagFontbtn.setImage(tagFontbtn.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        tagFontbtn.tintColor = .white
        
        
        //        editTag.backgroundColor = UIColor.clear
        //      newEditTag.textColor = UIColor.white
        
        currentFont = UIFont.familyNames[0]
        newEditTag.font = UIFont.init(name: UIFont.familyNames[0], size: 30.0)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: -CollectionView For Font
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return UIFont.familyNames.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fcell", for: indexPath) as! Fcell
        
        cell.fontName.font = UIFont.init(name: UIFont.familyNames[indexPath.row], size: 18.0)
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentFont = UIFont.familyNames[indexPath.row]
        slider.value = 30.0
        newEditTag.font = UIFont.init(name: UIFont.familyNames[indexPath.row], size: 30.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 80, height: 40)
        
    }
    
    
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
        img.image = mainImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        takePhoto.isHidden = false
        
    }
    // MARK: -GalleryBtn Pressed
    @IBAction func galleryBtnPressed(_ sender: UIButton)
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
        ColorVIew.isHidden = true
        FontView.isHidden = true
        
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
    // MARK: -TagColorBtn Pressed
    @IBAction func tagColorPressed(_ sender: UIButton)
    {
        ColorVIew.fTransition(0.5)
        FontView.isHidden = true
        
        if ColorVIew.isHidden {
            
            ColorVIew.isHidden = false
            
        } else {
            
            ColorVIew.isHidden = true
            
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
    // MARK: -TagFontPressed
    @IBAction func tagFontPressed(_ sender: UIButton)
    {
        ColorVIew.isHidden = true
        
        FontView.fTransition(0.5)
        
        if FontView.isHidden {
            
            FontView.isHidden = false
            
        } else {
            
            FontView.isHidden = true
            
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
    
    
    // MARK: -TagColorModify Pressed
    @IBAction func tagColorModifyPressed(_ sender: UIButton)
    {
        tagBackGroundbtn.setTitleColor(UIColor.white, for: .normal)
        tagTextColorbtn.setTitleColor(UIColor.white, for: .normal)
        
        if sender.tag == 1 {
            
            tagBackGroundbtn.setTitleColor(UIColor.yellow, for: .normal)
            
        } else if sender.tag == 2 {
            
            tagTextColorbtn.setTitleColor(UIColor.yellow, for: .normal)
            
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
    // MARK: -SaveBtn Pressed
    @IBAction func savebtnPressed(_ sender: Any)
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
                let image = self.image(with: self.tagWithImage)
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(yeah)
            self.present(alert, animated: true, completion: nil)
        }
    }
    // MARK: -DoneBtn Pressed
    @IBAction func donebtnPressed(_ sender: Any)
    {
        let image = self.image(with: tagWithImage)
        let shareAll = [image as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    // MARK: -Slider Pressed
    @IBAction func sliderPressed(_ sender: UISlider)
    {
        newEditTag.font = UIFont.init(name: currentFont, size: CGFloat(sender.value))
    }
    
    func imageView(_ imageView: DTColorPickerImageView, didPickColorWith color: UIColor) {
        
        if tagBackGroundbtn.titleColor(for: .normal) == UIColor.yellow
        {
            
            newEditTag.backgroundColor = color
            
        } else {
            
            newEditTag.textColor = color
            
        }
    }
    // MARK: -ViewWill Appear
    override func viewWillAppear(_ animated: Bool)
    {
        
        tagBackGroundbtn.sendActions(for: .touchUpInside)
        
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - Color & Font view Animation
   extension UIView {
       
       func fTransition(_ duration:CFTimeInterval) {
           let animation = CATransition()
           animation.timingFunction = CAMediaTimingFunction(name:
               CAMediaTimingFunctionName.easeInEaseOut)
           animation.type = CATransitionType.fade
           animation.duration = duration
           layer.add(animation, forKey: CATransitionType.fade.rawValue)
       }
   }
   
