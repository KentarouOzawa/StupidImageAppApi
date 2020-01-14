//
//  ViewController.swift
//  stupidImageWordApp
//
//  Created by 小澤謙太郎 on 2020/01/06.
//  Copyright © 2020 小澤謙太郎. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.requestAuthorization { (states) in
            switch(states){
            case .authorized:break
            case .denied:break
            case .notDetermined:break
            case .restricted:break
            }
           
        }
         getImages(keyword: "funny")
    }
    func getImages(keyword:String){
        let url = "https://pixabay.com/api/?key=14825355-311eea945caf3b0b680a4d9f9&q=\(keyword)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                if imageString == nil{
                    imageString = json["hits"][0]["webformatURL"].string
                     self.mainImageView.sd_setImage(with: URL(string:imageString!), completed: nil)
                }else{
                    self.mainImageView.sd_setImage(with: URL(string:imageString!), completed: nil)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }

    @IBAction func nextObjectButton(_ sender: Any) {
        count = count + 1
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func searchActionButton(_ sender: Any) {
        self.count = 0
        if searchTextField.text == ""{
            getImages(keyword: "funny")
            
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVc = segue.destination as? ShareViewController
        shareVc?.commentString = commentTextView.text
        shareVc?.resultImage = mainImageView.image!
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextView.resignFirstResponder()
        searchTextField.resignFirstResponder()
    }
}

