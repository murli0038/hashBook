//
//  HomeView.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 03/03/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeViewCell : UICollectionViewCell
{
    
    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var tagName: UILabel!
}



class HomeView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,GADBannerViewDelegate,GADInterstitialDelegate
{
    
    var bannerView: GADBannerView!
    
     var interstitial: GADInterstitial!
    
    @IBOutlet weak var backGroundImage: UIImageView!
    var arr = [["Category" : "#Most Popular" ,"Controller" : "most popular", "Cat_Image" : #imageLiteral(resourceName: "trends")],
          ["Category" : "#Getting Tags" ,"Controller" : "getting tags", "Cat_Image" : #imageLiteral(resourceName: "pexels-photo-622135")],
          ["Category" : "#Activity" ,"Controller" : "activity", "Cat_Image" : #imageLiteral(resourceName: "activiti")],
          ["Category" : "#Animal" ,"Controller" : "animal", "Cat_Image" : #imageLiteral(resourceName: "animal")],
          ["Category" : "#Art" ,"Controller" : "art", "Cat_Image" : #imageLiteral(resourceName: "art")],
          ["Category" : "#Days of Week" ,"Controller" : "week", "Cat_Image" : #imageLiteral(resourceName: "week")],
          ["Category" : "#Electronics" ,"Controller" : "electronis", "Cat_Image" : #imageLiteral(resourceName: "Photo70")],
          ["Category" : "#Fashion" ,"Controller" : "fashion", "Cat_Image" : #imageLiteral(resourceName: "fashion-1")],
          ["Category" : "#Feeling" ,"Controller" : "feeling", "Cat_Image" : #imageLiteral(resourceName: "feeling")],
          ["Category" : "#Fitness" ,"Controller" : "fitness", "Cat_Image" : #imageLiteral(resourceName: "fitness")],
          ["Category" : "#Food" ,"Controller" : "food", "Cat_Image" : #imageLiteral(resourceName: "food")],
          ["Category" : "#Funny" ,"Controller" : "funny", "Cat_Image" :  #imageLiteral(resourceName: "funny-1")],
          ["Category" : "#Gaming" ,"Controller" : "gaming", "Cat_Image" :  #imageLiteral(resourceName: "gaming")],
          ["Category" : "#Hobbies" ,"Controller" : "hobbies", "Cat_Image" :  #imageLiteral(resourceName: "hobbies")],
          ["Category" : "#Holidays" ,"Controller" : "holidays", "Cat_Image" :  #imageLiteral(resourceName: "holidays")],
          ["Category" : "#Music" ,"Controller" : "music", "Cat_Image" : #imageLiteral(resourceName: "music")],
          ["Category" : "#Celebration" ,"Controller" : "party", "Cat_Image" : #imageLiteral(resourceName: "party")],
          ["Category" : "#People" ,"Controller" : "people", "Cat_Image" : #imageLiteral(resourceName: "people")],
          ["Category" : "#Photography" ,"Controller" : "photography", "Cat_Image" :  #imageLiteral(resourceName: "photography")],
          ["Category" : "#Places" ,"Controller" : "places", "Cat_Image" : #imageLiteral(resourceName: "places")],
          ["Category" : "#School" ,"Controller" : "school", "Cat_Image" :  #imageLiteral(resourceName: "school")],
          ["Category" : "#Seasonal" ,"Controller" : "seasonal", "Cat_Image" :#imageLiteral(resourceName: "seasonal")],
          ["Category" : "#Selfie" ,"Controller" : "selfie", "Cat_Image" :  #imageLiteral(resourceName: "selfie")],
          ["Category" : "#Sports" ,"Controller" : "sports", "Cat_Image" :  #imageLiteral(resourceName: "sports-1")],
          ["Category" : "#Transportation" ,"Controller" : "transportation", "Cat_Image" : #imageLiteral(resourceName: "transportation-1")],
          ["Category" : "#Travel" ,"Controller" : "travel", "Cat_Image" :  #imageLiteral(resourceName: "travel")],
          ["Category" : "#Weather" ,"Controller" : "weather", "Cat_Image" :  #imageLiteral(resourceName: "weather")],
          ["Category" : "#Work" ,"Controller" : "work", "Cat_Image" :  #imageLiteral(resourceName: "work-1")],
          ["Category" : "#Technology" ,"Controller" : "technology", "Cat_Image" : #imageLiteral(resourceName: "technology")]
      ]
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeViewCell
        cell.tagName.text = arr[indexPath.row]["Category"] as? String
        cell.categoryImg.image = arr[indexPath.row]["Cat_Image"] as? UIImage
        //cell.layer.cornerRadius = 20
        //cell.layer.borderColor = UIColor.gray.cgColor
        //cell.layer.borderWidth = 1
        
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cell.layer.shadowRadius = 7.0
        cell.layer.shadowOpacity = 100.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if interstitial.isReady
               {
                  interstitial.present(fromRootViewController: self)
                }
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "tags") as! Tags
        detail.isFrom = arr[indexPath.item]["Controller"] as! String
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
       func createAndLoadInterstitial() -> GADInterstitial {
           let interstitial = GADInterstitial(adUnitID: "ca-app-pub-2428541974846742/1182926176")
            //let interstitial = GADInterstitial(adUnitID: "ca-app-pub-2428541974846742~3644394400")
         interstitial.delegate = self
         interstitial.load(GADRequest())
         return interstitial
       }
       func adViewDidReceiveAd(_ bannerView: GADBannerView) {
         bannerView.alpha = 0
         UIView.animate(withDuration: 1, animations: {
           bannerView.alpha = 1
         })
       }

       func interstitialDidDismissScreen(_ ad: GADInterstitial) {
         interstitial = createAndLoadInterstitial()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backGroundImage.bounds
        backGroundImage.addSubview(blurView)
        
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
               addBannerViewToView(bannerView)
               
               bannerView.adUnitID = "ca-app-pub-2428541974846742/8935431290"
               //bannerView.adUnitID = "ca-app-pub-2428541974846742~3644394400"
               bannerView.rootViewController = self
                bannerView.load(GADRequest())
                bannerView.delegate = self
               
               
               interstitial = createAndLoadInterstitial()
               interstitial = GADInterstitial(adUnitID: "ca-app-pub-2428541974846742/1182926176")
               //interstitial = GADInterstitial(adUnitID: "ca-app-pub-2428541974846742~3644394400")
               interstitial.delegate = self
               let request = GADRequest()
                  interstitial.load(request)

        // Do any additional setup after loading the view.
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
