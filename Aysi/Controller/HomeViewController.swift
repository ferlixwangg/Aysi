//
//  HomeViewController.swift
//  Aysi
//
//  Created by Ferlix Yanto Wang on 25/08/18.
//  Copyright © 2018 Ferlix Yanto Wang. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var tipsContainerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var babyCollectionView: UICollectionView!
    @IBOutlet weak var wifeCollectionView: UICollectionView!
    
    // MARK: - Variables
    // Data for home page
    let weekIndicator: [String] = ["Minggu 1", "Minggu 2", "Minggu 3", "Minggu 4", "Bulan 2", "Bulan 3", "Bulan 4", "Bulan 5", "Bulan 6"]
    
    let minggu1AnakS = [#imageLiteral(resourceName: "Berat Badan Menurun"), #imageLiteral(resourceName: "Bonding IMD"), #imageLiteral(resourceName: "Tangisan Bayi"), #imageLiteral(resourceName: "Tidur belum teratur")]
    let minggu1AnakL = [#imageLiteral(resourceName: "berat badan menurun konten"), #imageLiteral(resourceName: "bonding IMD konten"), #imageLiteral(resourceName: "tangisan bayi konten"), #imageLiteral(resourceName: "tidur belum teratur konten") ]
    let minggu1IstriS = [#imageLiteral(resourceName: "ASI Tidak Keluar"), #imageLiteral(resourceName: "Baby Blue"), #imageLiteral(resourceName: "Istri Shock"), #imageLiteral(resourceName: "Payudara Perih")]
    let minggu1IstriL = [#imageLiteral(resourceName: "ASI tidak keluar konten"), #imageLiteral(resourceName: "baby blues konten"), #imageLiteral(resourceName: "istri kaget konten"), #imageLiteral(resourceName: "payudara perih konten")]
    
    let minggu2AnakS = [#imageLiteral(resourceName: "Bayi Menangiss"), #imageLiteral(resourceName: "Bayi mulai growth spurt"), #imageLiteral(resourceName: "Nyusu dan ngedot teruss"), #imageLiteral(resourceName: "Mengalami Kolikk"), #imageLiteral(resourceName: "mulai menggerakan beberapa bagian tubuh")]
    let minggu2AnakL = [#imageLiteral(resourceName: "bayi menangis konten"), #imageLiteral(resourceName: "growth spurt konten"), #imageLiteral(resourceName: "ingin ngedot terus konten"), #imageLiteral(resourceName: "mengalami kolik konten"), #imageLiteral(resourceName: "mulai menggerakan tubuh konten")]
    let minggu2IstriS = [#imageLiteral(resourceName: "Istri Kerja"), #imageLiteral(resourceName: "Istri Kurang Tidur")]
    let minggu2IstriL = [#imageLiteral(resourceName: "istri kerja konten"), #imageLiteral(resourceName: "istri kurang tidur konten")]
    
    let minggu3AnakS = [#imageLiteral(resourceName: "pup encerr")]
    let minggu3AnakL = [#imageLiteral(resourceName: "pup encer konten")]
    let minggu3IstriS = [#imageLiteral(resourceName: "Istri Sakit Punggung")]
    let minggu3IstriL = [#imageLiteral(resourceName: "istri sakit punggung konten")]
    
    let minggu4AnakS = [#imageLiteral(resourceName: "bayi menolak asipp")]
    let minggu4AnakL = [#imageLiteral(resourceName: "bayi menolak asip konten")]
    let minggu4IstriS = [#imageLiteral(resourceName: "Istri Mulai Lelah"), #imageLiteral(resourceName: "Mulai Terbiasa Hidup Bersama Bayi")]
    let minggu4IstriL = [#imageLiteral(resourceName: "istri mulai lelah konten"), #imageLiteral(resourceName: "mulai terbiasa bayi konten")]
    
    let bulan2AnakS = [#imageLiteral(resourceName: "menggerakan kepala"), #imageLiteral(resourceName: "Three C"), #imageLiteral(resourceName: "waktu tidur bayii")]
    let bulan2AnakL = [#imageLiteral(resourceName: "menggerakan kepala konten"), #imageLiteral(resourceName: "Three C Konten"), #imageLiteral(resourceName: "waktu tidur bayi konten")]
    let bulan2IstriS = [#imageLiteral(resourceName: "Mastitis"), #imageLiteral(resourceName: "Payudara membengkak")]
    let bulan2IstriL = [#imageLiteral(resourceName: "Mastitis konten"), #imageLiteral(resourceName: "Payudara membengkak konten")]
    
    let bulan3AnakS = [#imageLiteral(resourceName: "hearing, improve, vision lebih tajamm"), #imageLiteral(resourceName: "Muncul gigi pertama"), #imageLiteral(resourceName: "Red Flags"), #imageLiteral(resourceName: "Tidak mau menyusuu")]
    let bulan3AnakL = [#imageLiteral(resourceName: "hearing,improve konten"), #imageLiteral(resourceName: "muncul gigi pertama konten"), #imageLiteral(resourceName: "red flags konten"), #imageLiteral(resourceName: "tidak mau menyusu konten")]
    let bulan3IstriS = [#imageLiteral(resourceName: "ASI bocor"), #imageLiteral(resourceName: "Tidak kunjung Haid")]
    let bulan3IstriL = [#imageLiteral(resourceName: "asi bocor konten"), #imageLiteral(resourceName: "tidak kunjung haid konten")]
    
    let bulan4AnakS = [#imageLiteral(resourceName: "Penglihatan buah hati"), #imageLiteral(resourceName: "Red Flagg")]
    let bulan4AnakL = [#imageLiteral(resourceName: "penglihatan buah hati konten"), #imageLiteral(resourceName: "red flag konten")]
    let bulan4IstriS = [#imageLiteral(resourceName: "ASI bauu"), #imageLiteral(resourceName: "Istri Lelah")]
    let bulan4IstriL = [#imageLiteral(resourceName: "asi bau konten"), #imageLiteral(resourceName: "istri lelah konten")]
    
    let bulan5AnakS = [#imageLiteral(resourceName: "red flagg-2"), #imageLiteral(resourceName: "waktu tidurr")]
    let bulan5AnakL = [#imageLiteral(resourceName: "red flag-2 konten"), #imageLiteral(resourceName: "waktu tidur konten")]
    let bulan5IstriS = [#imageLiteral(resourceName: "Lupa menghangatkan ASIP")]
    let bulan5IstriL = [#imageLiteral(resourceName: "lupa menghangatkan asip konten")]
    
    let bulan6AnakS = [#imageLiteral(resourceName: "MPASII"), #imageLiteral(resourceName: "red flag-3")]
    let bulan6AnakL = [#imageLiteral(resourceName: "mpasi konten"), #imageLiteral(resourceName: "redflag-3 konten")]
    let bulan6IstriS = [#imageLiteral(resourceName: "Jenuh Pumping"), #imageLiteral(resourceName: "ASI Tersumbat")]
    let bulan6IstriL = [#imageLiteral(resourceName: "Jenuh pumping konten"), #imageLiteral(resourceName: "ASI tersumbat konten")]
    
    var contentDictionary = [String: HomeContent]()
    
    var clickedCollectionImage = UIImage()
    var contentBaby = [UIImage]()
    var contentWife = [UIImage]()
    
    var leftArrowButton = UIButton()
    var rightArrowButton = UIButton()
    var imageView = UIImageView()
    var navTitle = String()
    
    var titleIndex: Int = 0{
        didSet {
            if titleIndex == weekIndicator.count-1{
                rightArrowButton.isEnabled = false
            } else {
                rightArrowButton.isEnabled = true
            }
            if titleIndex == 0{
                leftArrowButton.isEnabled = false
            } else {
                leftArrowButton.isEnabled = true
            }
        }
    }
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minggu1 = HomeContent(childImageS: minggu1AnakS, childImageL: minggu1AnakL, wifeImageS: minggu1IstriS, wifeImageL: minggu1IstriL)
        let minggu2 = HomeContent(childImageS: minggu2AnakS, childImageL: minggu2AnakL, wifeImageS: minggu2IstriS, wifeImageL: minggu2IstriL)
        let minggu3 = HomeContent(childImageS: minggu3AnakS, childImageL: minggu3AnakL, wifeImageS: minggu3IstriS, wifeImageL: minggu3IstriL)
        let minggu4 = HomeContent(childImageS: minggu4AnakS, childImageL: minggu4AnakL, wifeImageS: minggu4IstriS, wifeImageL: minggu4IstriL)
        let bulan2 = HomeContent(childImageS: bulan2AnakS, childImageL: bulan2AnakL, wifeImageS: bulan2IstriS, wifeImageL: bulan2IstriL)
        let bulan3 = HomeContent(childImageS: bulan3AnakS, childImageL: bulan3AnakL, wifeImageS: bulan3IstriS, wifeImageL: bulan3IstriL)
        let bulan4 = HomeContent(childImageS: bulan4AnakS, childImageL: bulan4AnakL, wifeImageS: bulan4IstriS, wifeImageL: bulan4IstriL)
        let bulan5 = HomeContent(childImageS: bulan5AnakS, childImageL: bulan5AnakL, wifeImageS: bulan5IstriS, wifeImageL: bulan5IstriL)
        let bulan6 = HomeContent(childImageS: bulan6AnakS, childImageL: bulan6AnakL, wifeImageS: bulan6IstriS, wifeImageL: bulan6IstriL)
        
        contentDictionary["Minggu 1"] = minggu1
        contentDictionary["Minggu 2"] = minggu2
        contentDictionary["Minggu 3"] = minggu3
        contentDictionary["Minggu 4"] = minggu4
        contentDictionary["Bulan 2"] = bulan2
        contentDictionary["Bulan 3"] = bulan3
        contentDictionary["Bulan 4"] = bulan4
        contentDictionary["Bulan 5"] = bulan5
        contentDictionary["Bulan 6"] = bulan6
        
        setupNavBarItems()
        babyCollectionView.delegate = self
        babyCollectionView.dataSource = self
        wifeCollectionView.delegate = self
        wifeCollectionView.dataSource = self
        
        // Transparent Nav Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (success, error) in
            if error != nil {
                print("Notification Authorization Unsuccessful")
            } else {
                print("Notification Authorization Successful")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let babyData = UserDefaults.standard.dictionary(forKey: "BabyData")
        let dateUD = babyData?["dob"] as? String
        let bDay = formatter.date(from: "\(dateUD!) 20:00")
        
        let components = Calendar.current.dateComponents([.weekOfYear, .month], from: bDay!, to: Date())
        
        let month = components.month ?? 0
        let week = components.weekOfYear ?? 0
        if week<=1 && month<=0{
            titleIndex = 0
        } else if week==2 && month==0{
            titleIndex = 1
        } else if week==3 && month==0{
            titleIndex = 2
        } else if week==4 && month==0{
            titleIndex = 3
        } else if month==1{
            titleIndex = 4
        } else if month==2{
            titleIndex = 5
        } else if month==3{
            titleIndex = 6
        } else if month>=4{
            titleIndex = 7
        }
        
        setupContent()
    }
    
    // MARK: - Functions
    func setupNavBarItems() {
        let navBarWidth = self.navigationController?.navigationBar.frame.width
        let navBarButtonViewWidth = (navBarWidth! - 140) / 2
        
        // Nav Bar Title
        imageView = UIImageView(image: UIImage(named: "BULAN 6"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 10, y: -7, width: 90, height: 20))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
        
        // Nav bar buttons
        // Left Arrow Button
        leftArrowButton = UIButton(type: .custom)
        leftArrowButton.setImage(UIImage(named: "Left arrow"), for: .normal)
        leftArrowButton.addTarget(self, action: #selector(HomeViewController.prevButtonPressed), for: .touchUpInside)
        let customViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: navBarButtonViewWidth, height: 32))
        leftArrowButton.contentMode = .scaleAspectFit
        leftArrowButton.frame = CGRect(x: customViewLeft.frame.width-30, y: customViewLeft.frame.midY-10, width: 20, height: 22)
        customViewLeft.addSubview(leftArrowButton)
        
        // Right Arrow Button
        rightArrowButton = UIButton(type: .custom)
        rightArrowButton.setImage(UIImage(named: "Right arrow"), for: .normal)
        rightArrowButton.addTarget(self, action: #selector(HomeViewController.nextButtonPressed), for: .touchUpInside)
        rightArrowButton.contentMode = .scaleAspectFit
        
        // Setting Button
        let settingButton = UIButton(type: .custom)
        settingButton.setImage(UIImage(named: "Settings icon"), for: .normal)
        settingButton.addTarget(self, action: #selector(HomeViewController.settingButtonPressed), for: .touchUpInside)
        settingButton.contentMode = .scaleAspectFit
        
        let customViewRight = UIView(frame: CGRect(x: 0, y: 0, width: navBarButtonViewWidth, height: 32))
        rightArrowButton.frame = CGRect(x: 15, y: customViewRight.frame.midY-10, width: 20, height: 22)
        settingButton.frame = CGRect(x: customViewRight.frame.width-20, y: customViewRight.frame.midY-10, width: 24, height: 24)
        customViewRight.addSubview(rightArrowButton)
        customViewRight.addSubview(settingButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customViewLeft)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customViewRight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tipsPageViewController = segue.destination as? TipsPageViewController {
            tipsPageViewController.tipsDelegate = self
        } else if let HomeContentDetailViewController = segue.destination as? HomeContentDetailViewController {
            HomeContentDetailViewController.contentObtained = clickedCollectionImage
            HomeContentDetailViewController.navTitle = navTitle
        }
    }
    
    @objc func settingButtonPressed() {
        performSegue(withIdentifier: "homeToAccountSetting", sender: self)
    }
    
    @objc func nextButtonPressed() {
        titleIndex+=1
        setupContent()
    }
    
    @objc func prevButtonPressed() {
        titleIndex-=1
        setupContent()
    }
    
    func setupContent() {
        imageView.image = UIImage(named: weekIndicator[titleIndex])
        contentWife = (contentDictionary[weekIndicator[titleIndex]]?.wifeImageShown)!
        contentBaby = (contentDictionary[weekIndicator[titleIndex]]?.childImageShown)!
        wifeCollectionView.reloadData()
        babyCollectionView.reloadData()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 100
        
        if offset > 1 {
            offset = 1
        }
        
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        self.navigationController?.navigationBar.backgroundColor = color
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
}

extension HomeViewController: TipsDelegate {
    func tipsPageCount(tipsPageViewController: TipsPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tipsPageIndex(tipsPageViewController: TipsPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.babyCollectionView {
            return contentBaby.count
        } else if collectionView == self.wifeCollectionView {
            return contentWife.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.babyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "babyCell", for: indexPath) as? BabyCollectionViewCell
            
            cell?.imageContent.image = contentBaby[indexPath.row]
            return cell!
        } else if collectionView == self.wifeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wifeCell", for: indexPath) as? WifeCollectionViewCell
            
            cell?.imageContent.image = contentWife[indexPath.row]
            return cell!
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.babyCollectionView{
            clickedCollectionImage = (contentDictionary[weekIndicator[titleIndex]]?.childImageDetail[indexPath.row])!
            navTitle = "Si Buah Hati-1"
        } else if collectionView == self.wifeCollectionView {
            clickedCollectionImage = (contentDictionary[weekIndicator[titleIndex]]?.wifeImageDetail[indexPath.row])!
            navTitle = "Si Belahan Hati-1"
        }
        performSegue(withIdentifier: "homeToContentDetail", sender: self)
    }
}
