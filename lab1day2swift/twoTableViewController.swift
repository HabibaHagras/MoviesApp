//
//  twoTableViewController.swift
//  lab1day2swift
//
//  Created by habiba on 4/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import SDWebImage

class twoTableViewController: UITableViewController ,saveNewMovie ,UIImagePickerControllerDelegate {

    
    var selectedImageData: Data?

   
    var ref: saveNewMovie?
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//           if let image = info[.originalImage] as? UIImage {
//               selectedImageData = image.pngData()
//           }
//           dismiss(animated: true, completion: nil)
//       }
//
//       func open_Galary(img: Data) {
//        selectedImageData = img
//       }
    
    
    @IBAction func plusBTN(_ sender: UIBarButtonItem) {
        if let addMovie = storyboard?.instantiateViewController(withIdentifier: "addMovie")
            as? AddNewViewController {
            addMovie.ref = self
             navigationController?.pushViewController(addMovie, animated: true)
        }}
    func save(name: String, img: Data, rating: Float, genre: [String], relaseint: Int) {
        
        let g = DbManager.shared
        g.insertMovie(name: name, rating: Double(rating), genre: genre, releaseYear: relaseint, img: img)
        
        
//
//
//        let newMovie = Movie(name: name, img: img, rating: rating, genre: genre, relaseint: relaseint )
//             movieArr.append(newMovie)
             tableView.reloadData()
        
    }
//    var movieArr: [Movie] = [
//        Movie(name: "Up", img: "https://freepngimg.com/thumb/categories/353.png", rating: 2, genre:["1" , "2"], relaseint:3 ),
//        Movie(name: "CoCo", img: "https://w7.pngwing.com/pngs/15/375/png-transparent-three-minions-kevin-the-minion-animation-film-illumination-entertainment-despicable-me-animation-cartoon-funny-film-thumbnail.png", rating: 3, genre:["1" , "2"], relaseint:3 ),
//        Movie(name: "Sipiderman 3", img: "https://e7.pngegg.com/pngimages/868/656/png-clipart-russell-from-up-movie-russell-in-full-uniform-at-the-movies-cartoons-thumbnail.png", rating: 4, genre:["1" , "2"], relaseint:3 ),
//        Movie(name: "Batman 4", img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqRfQKo5n0JxPV7LDDyUyvfF6j6aoz98-_aUTQxXT3_Q&s", rating: 3, genre:["1" , "2"], relaseint:3 ),
//        Movie(name: "Flashman", img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjD9iDBgVl9bLHvcSOMmHyI7DiBSB7c_w4sCKtCf2guw&s", rating: 1, genre:["1" , "2"], relaseint:3 ),
//     ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let g = DbManager.shared

             return g.retrieveData().count
//            movieArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
           let g = DbManager.shared
                 let movied = g.retrieveData()

                 guard indexPath.row < movied.count else {
                     return cell
                 }

//            let movie = movieArr[indexPath.row]
           // let movied =  g.retrieveData()
            let m = movied[indexPath.row]
//            cell.textLabel?.text=movie.name
//             if let imageUrl = URL(string: movie.img) {
//                    cell.imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
//                }
                    cell.textLabel?.text = m.name
            cell.imageView?.image = UIImage(data: m.img)
 
//            if let imageUrlString = m.img
//
//                as? String, let imageUrl = URL(string: imageUrlString) {
//                cell.imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
//            }
            return cell
        }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                let g = DbManager.shared
                let movied =  g.retrieveData()
            let selectedMovie = movied[indexPath.row].name
            DbManager.shared.deleteMovie(name: selectedMovie)
            tableView.reloadData()
        }
        
        
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        let selectedMovie = movieArr[indexPath.row]
        let g = DbManager.shared
    
        let movied =  g.retrieveData()
              let selectedMovie = movied[indexPath.row]
        if let movieView = storyboard?.instantiateViewController(withIdentifier: "moviekey")
            as? movieViewController {
            movieView.movieName = selectedMovie.name
            movieView.imageUrl = selectedMovie.img
            movieView.ratting = selectedMovie.rating
            movieView.genre = selectedMovie.genre
movieView.relaseint = selectedMovie.relaseint
            navigationController?.pushViewController(movieView, animated: true)
        }
        
    }
    
}
    
    

