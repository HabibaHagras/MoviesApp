//
//  movieViewController.swift
//  lab1day2swift
//
//  Created by habiba on 4/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import Cosmos

class movieViewController: UIViewController {
    @IBOutlet weak var releaseint: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var genere: UILabel!
    var movieName: String?
    var imageUrl: Data?
    var ratting:Float?
    var genre:[String]?
    var relaseint:Int?
    @IBOutlet weak var webimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = movieName
          if let ratingValue = ratting {
             rating.text = String(ratingValue)
         }
        if rating != nil {
            cosmosView.rating = Double(ratting ?? 3)
               }
        if let genres = genre {
             genere.text = genres.joined(separator: ", ")
         }
        
         if let relaseint = relaseint {
                  releaseint.text = String(relaseint)
              }
//            if let imageUrlString = imageUrl, let url = URL(string: imageUrlString) {
//                webimg.sd_setImage(with: url, placeholderImage: UIImage(named: "d"))
//            }
        webimg.image = UIImage( data:imageUrl!)
        
        webimg.layer.borderWidth = 1
        webimg.layer.masksToBounds = false
        webimg.layer.borderColor = UIColor.black.cgColor
        webimg.layer.cornerRadius = webimg.frame.height/2
        webimg.clipsToBounds = true
        }
    }


