//
//  ViewController.swift
//  Day 6 - WalkThrough with VideoPlayback
//
//  Created by Prashant Gaikwad on 1/6/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    var player: AVPlayer?
    var playerController = AVPlayerLayer()
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainArr : [String] = []
    var subArr : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        
        self.view.layer.insertSublayer(playerController, at: 0)
        
        self.view.bringSubview(toFront: pageControl)
        
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        
        mainArr = ["Welcome","Browse","Search","Running","Your library"]
        subArr = ["Sign up for free music on your phone , tablet and computer.","Explore the tracks , new release and the right playlist for every moment.","Sign up for free music on your phone , tablet and computer.","Explore the tracks , new release and the right playlist for every moment.","Sign up for free music on your phone , tablet and computer."]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        loadVideo()
    }
    
    func loadVideo() {
        
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("splashVideo.m4v not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        playerController.frame = self.view.frame
        playerController.player = player
        self.player?.play()
        
    }
    
    @objc func loopVideo() {
        
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.collectionView.collectionViewLayout = layout
            self.collectionView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
            
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                // let itemWidth = view.bounds.width / 3.0
                // let itemHeight = layout.itemSize.height
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.collectionView.frame.size.height-10)
                layout.invalidateLayout()
            }
    }
}



extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! WalkThroghCollectionViewCell
        print(indexPath.row)
        cell.mainMsgLabel.text = subArr[indexPath.row]
        cell.subMsgLabel.text = mainArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //ScrollView delegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        let pageWidth = scrollView.frame.width
        let index = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        let currentPage = index
        self.pageControl.currentPage = currentPage
        
        /*
        let indexPath = IndexPath(item: 0, section: 0)
        let pageWidth = scrollView.frame.width
        let index = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        if index == 4 {
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
        }
        else{
            let currentPage = index
            self.pageControl.currentPage = currentPage
        }
 */
        
    }
}




