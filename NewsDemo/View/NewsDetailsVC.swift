//
//  NewsDetailsVC.swift
//  NewsDemo
//
//  Created by Pooja Arora on 27/03/22.
//

import UIKit

class NewsDetailsVC: UIViewController {

    // MARK: - ======== Init ========
    static func initFromStoryboard() -> NewsDetailsVC {
        let controller = CommonUtility.mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        return controller
    }
    
    //MARk:- Outlets
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWebLink: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
   
    var newsData : NewsModel?
    
    //MARK:- View Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK:- Custom Methods
    func initialSetup(){
        self.lblTitle.text = newsData?.title
        let dateStr =  CommonUtility.sharedInstance.formattedDateFromString(dateString: newsData?.publishedAt ?? " ")
        lblDate.text = dateStr
        lblAuthor.attributedText = newsData?.author.htmlToAttributedString
        lblDate.adjustsFontSizeToFitWidth = true
        lblDescription.text = newsData?.description
        lblWebLink.attributedText = NSAttributedString(string: newsData?.url ?? "", attributes:
                                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        if let newsImage = newsData?.urlToImage{
            imageViewNews.setSDImage(newsImage)
        }
        
       
    }
    

}
