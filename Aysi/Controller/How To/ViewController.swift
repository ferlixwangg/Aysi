//
//  ViewController.swift
//  ContainDetail
//
//  Created by Ivan Riyanto on 27/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var currentCategoryAnak = ""
    var currentCategoryIstri = ""
    var objToPass:HowToObject?
    var sectionToPass:Int?
    var imageArr:[String]?
    var rowToPass:Int?
    
    var contentAnak = HowToObject(category: "Pijat-Memijat", object: ContentImages(category: "Pijat-Memijat", title: "Pijat Kepala", categoryImage: "PijatKepala", contentImage: ["PijatKepala1","PijatKepala2","PijatKepala3","PijatKepala4","PijatKepala5","PijatKepala6"]))
    var contentIstri = HowToObject(category: "Pijat-Memijat", object: ContentImages(category: "Pijat-Memijat", title: "Pijat Oksitosin", categoryImage: "PijatOksitosin", contentImage: ["PijatOksitosin1","PijatOksitosin2"]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        setupNavBarItems()
        contentAnak.addContent(category: "Pijat-Memijat", object: ContentImages(category: "Pijat-Memijat", title: "Pijat Dada", categoryImage: "PijatDada", contentImage: ["PijatDada1","PijatDada2","PijatDada3","PijatDada4"]))
        contentAnak.addContent(category: "Pijat-Memijat", object: ContentImages(category: "Pijat-Memijat", title: "Pijat Perut", categoryImage: "PijatPerut", contentImage: ["PijatPerut1","PijatPerut2","PijatPerut3","PijatPerut4","PijatPerut5","PijatPerut6","PijatPerut7"]))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isActive == true{
            return contentAnak.arrCategory.count
        } else {
            return contentIstri.arrCategory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        currentCategoryAnak = contentAnak.arrCategory[indexPath.row]
        currentCategoryIstri = contentIstri.arrCategory[indexPath.row]
        if isActive == true{
            cell.keteranganCollectionView.image = UIImage(named: "\(contentAnak.contentDict[currentCategoryAnak]![indexPath.row].category)")
            cell.kontenCollectionView.reloadData()
            return cell
        } else {
            cell.keteranganCollectionView.image = UIImage(named: "\(contentIstri.contentDict[currentCategoryIstri]![indexPath.row].category)")
            cell.kontenCollectionView.reloadData()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isActive == true{
//            return dictionary[currentCategory].count
            return (contentAnak.contentDict[currentCategoryAnak]?.count)!
            
        } else {
            return (contentIstri.contentDict[currentCategoryIstri]?.count)!
        }
    }
    
    @IBOutlet weak var MyTable: UITableView!

    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupNavBarItems() {
        // Nav Bar Title
        let imageView = UIImageView(image: UIImage(named: "HOW TO Title"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: 0, width: 80, height: 17))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
        
        // Nav bar buttons
        // Left Arrow Button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(ViewController.backButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backButton.contentMode = .scaleAspectFit
        backButton.frame = CGRect(x: 10, y: customViewLeft.frame.midY-10, width: 20, height: 22)
        customViewLeft.addSubview(backButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if isActive == true {
            // cell.daftarGambar.image = UIImage(named: dictionary[currentCategory][indexPath.row].imageName
            cell.daftarGambar.image = UIImage(named: "\(contentAnak.contentDict[currentCategoryAnak]![indexPath.row].categoryImage)")
            cell.gambarLabel.text = contentAnak.contentDict[currentCategoryAnak]![indexPath.row].title
            
        } else {
            cell.daftarGambar.image = UIImage(named: "\(contentIstri.contentDict[currentCategoryIstri]![indexPath.row].categoryImage)")
            cell.gambarLabel.text = contentIstri.contentDict[currentCategoryIstri]![indexPath.row].title
            
        }

//        collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isActive == true{
            objToPass = contentAnak
            sectionToPass = indexPath.section
            rowToPass = indexPath.row
            imageArr = contentAnak.contentDict[contentAnak.arrCategory[indexPath.section]]![indexPath.row].contentImage
            performSegue(withIdentifier: "ToContentDetail", sender: self)
        } else {
            objToPass = contentIstri
            sectionToPass = indexPath.section
            rowToPass = indexPath.row
            imageArr = contentIstri.contentDict[contentAnak.arrCategory[indexPath.section]]![indexPath.row].contentImage
            performSegue(withIdentifier: "ToContentDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToContentDetail") {
            let vc = segue.destination as! ContentDetailViewController
            vc.object = objToPass
            vc.section = sectionToPass
            vc.row = rowToPass
            vc.listOfHowToImages = imageArr
        }
    }
    
    
    //Button
    
    
    
    var isActive:Bool = false

    
    @IBOutlet weak var istriLabel: UIImageView!
    @IBOutlet weak var istriUnderline: UIImageView!
    @IBOutlet weak var anakLabel: UIImageView!
    @IBOutlet weak var anakUnderline: UIImageView!
    
    @IBAction func buttonIstri(_ sender: UIButton) {
        print (isActive)
          isActive = false
        
        if isActive == false{
        
            MyTable.reloadData()
            istriLabel.image = #imageLiteral(resourceName: "Istri1")
            istriUnderline.image = #imageLiteral(resourceName: "Underline2")
            anakLabel.image = #imageLiteral(resourceName: "Anak2")
            anakUnderline.image = #imageLiteral(resourceName: "Underline1")
            
        }
        
        else {
            
            istriLabel.image = #imageLiteral(resourceName: "Istri2")
            istriUnderline.image = #imageLiteral(resourceName: "Underline1")
            
        }
      
    }
    
    
    @IBAction func buttonAnak(_ sender: UIButton) {
        print (isActive)
        
        isActive = true
        
        if isActive == false{
            
            anakLabel.image = #imageLiteral(resourceName: "Anak2")
            anakUnderline.image = #imageLiteral(resourceName: "Underline1")
           
        }
        
        else {
            MyTable.reloadData()
            anakLabel.image = #imageLiteral(resourceName: "Anak1")
            anakUnderline.image = #imageLiteral(resourceName: "Underline2")
            istriLabel.image = #imageLiteral(resourceName: "Istri2")
            istriUnderline.image = #imageLiteral(resourceName: "Underline1")
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

