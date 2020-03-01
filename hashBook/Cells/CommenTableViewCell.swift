//
//  CommenTableViewCell.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 26/01/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import CoreData

class CommenTableViewCell: UITableViewCell
{

    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var editTag: UIButton!
    
    
    //Variables
    var UserData: [NSManagedObject] = []

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func whatsApp(_ sender: UIButton)
    {
        let instagramHooks = "https://api.whatsapp.com/send?phone=858870068"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://wa.me")! as URL)
        }
        
    }
    @IBAction func instaGram(_ sender: UIButton)
    {
        let instagramHooks = "instagram://user?username=nilrajsinh_19"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/")! as URL)
        }
    }
    @IBAction func tweeet(_ sender: UIButton)
    {
        let instagramHooks = "https://twitter.com/MurliSp"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://twitter.com/")! as URL)
        }
    }
    
    @IBAction func LikeBtnPressed(_ sender: UIButton)
    {
            like.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
            LikedTag(tag: lblText.text!)
            
            UIButton.animate(withDuration: 0.1,animations:
                {
                    sender.transform = CGAffineTransform(scaleX: 0.400, y: 0.40)
                    //(scaleX: 0.975, y: 0.96)
            },completion:
                { finish in
                    
                    UIButton.animate(withDuration: 0.2, animations: {
                        sender.transform = CGAffineTransform.identity
                        //self.like.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
                    })
            })
            print("Liked tag : \(lblText.text!)")
        
    }
    func LikedTag(tag:String) {
      
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Like",in: managedContext)!
        
        let person = NSManagedObject(entity: entity,insertInto: managedContext)
        
        person.setValue(lblText.text, forKeyPath: "likedtag")
        
        do {
            try managedContext.save()
            UserData.append(person)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func copyToClipboard(_ sender: UIButton)
    {
        UIPasteboard.general.string = lblText.text
        print("Tag Copied :\(lblText.text!)")
    }
    
    

}
