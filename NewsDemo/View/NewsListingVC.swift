//
//  ViewController.swift
// NewsDemo
//
//  Created by Pooja Arora on 26/03/22.
//

import UIKit

class NewsListingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ======== Init ========
    static func initFromStoryboard() -> NewsListingVC {
        let controller = CommonUtility.mainStoryboard.instantiateViewController(withIdentifier: "NewsListingVC") as! NewsListingVC
        return controller
    }
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        getNewsList()
       
    }
}
//MARK:- Table View Delagate Methods
extension NewsListingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsViewModel.instance.aryNewsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.selectionStyle = .none
        
        if let newsCell = cell as? NewsCell {
            let model = NewsViewModel.instance.aryNewsModel[indexPath.row]
            newsCell.lblTitle.text = model.title
            let dateStr =  CommonUtility.sharedInstance.formattedDateFromString(dateString: model.publishedAt)
            newsCell.lblDate.text = dateStr
            newsCell.lblAuthor.text = "Written By:   " + model.author
            newsCell.lblDate.adjustsFontSizeToFitWidth = true
            newsCell.lblWebLink.adjustsFontSizeToFitWidth = true
            newsCell.lblWebLink.attributedText = NSAttributedString(string: model.url, attributes:
                                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
            
            // Add gesture on label
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.webViewTap(_:)))
            newsCell.lblWebLink.isUserInteractionEnabled = true
            newsCell.lblWebLink.addGestureRecognizer(labelTap)
            
            newsCell.imageViewNews.setSDImage(model.urlToImage)
            cell = newsCell
        }
        return cell
    }
    @objc func webViewTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//MARK:- Web service Methods
extension NewsListingVC{
    func getNewsList()  {
        self.startAnimating()
        NewsViewModel.instance.getNewsList { isSuccess, strResponse in
            self.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

