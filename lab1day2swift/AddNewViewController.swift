//
//  AddNewViewController.swift
//  lab1day2swift
//
//  Created by habiba on 4/25/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate{
    var ref: saveNewMovie?
   var selectedImageData: Data?

    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var rating: UITextField!
    
    
    @IBOutlet weak var genere: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var imgUrl: UITextField!
    
    @IBAction func SaveNewMovie(_ sender: UIButton) {
//       if let name = titleLabel.text,
//                     let img = imgUrl.text,
//                     let ratingText = rating.text,
//                     let rating = Float(ratingText),
//                     let genreText = genere.text,
//                     let genre = genreText.components(separatedBy: ",") ?? "[]",
//                     let releaseintText = year.text,
//                let releaseint = Int(releaseintText)  {
//        ref?.save(name: name, img: img, rating: rating, genre: genre, releaseint: releaseint)
//                          navigationController?.popViewController(animated: true)
//
//    }
      guard let name = titleLabel.text,
               // let img = imgUrl.text,
                let ratingText = rating.text,
                let rating = Float(ratingText),
                let genreText = genere.text,
                let releaseintText = year.text,
                let releaseint = Int(releaseintText) else {
              print("One of the required fields is nil")
              return
          }
          print("All required fields have valid values")
        

          let genre = genreText.isEmpty ? [] : genreText.components(separatedBy: ",")
          print("Genre: \(genre)")

        ref?.save(name: name, img: selectedImageData!, rating: rating, genre: genre, relaseint: releaseint)
        
//
//        let dbManager = DbManager()
//        dbManager.insertMovie(name: name, rating: Double(rating), genre: genre.joined(separator: ", "), releaseYear: releaseint)

        
          navigationController?.popViewController(animated: true)
           
       }
       
    
    @IBAction func OpenGallery(_ sender: UIButton) {
        let imagePicker :UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImageData = image.pngData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
