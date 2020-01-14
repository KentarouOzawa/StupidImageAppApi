//
//  ShareViewController.swift
//  stupidImageWordApp
//
//  Created by 小澤謙太郎 on 2020/01/07.
//  Copyright © 2020 小澤謙太郎. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    var commentString = String()
    var resultImage = UIImage()
    
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontForContentSizeCategory = true

        // Do any additional setup after loading the view.
    }
    func takeScreenShot(){
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsGetImageFromCurrentImageContext()
    }
   @IBAction func share(_ sender: Any) {
        takeScreenShot()
        let items = [screenShotImage] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC,animated: true,completion: nil)
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
