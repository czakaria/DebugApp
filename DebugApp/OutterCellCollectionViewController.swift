//
//  OutterCellCollectionViewController.swift
//  DebugApp
//

import UIKit

private let reuseIdentifier = "Cell"

class OutterCellCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout   {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = .red
        self.collectionView?.showsVerticalScrollIndicator = false
        
        // Register cell classes
        self.collectionView?.register(OutterCell.self, forCellWithReuseIdentifier: "OutterCardCell")
        
        
        
        if let path = Bundle.main.path(forResource: "posts", ofType: "json") {
            
            do {
                
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                
                if let postsArray = jsonDictionary?["posts"] as? [[String: AnyObject]] {
                    
                    self.posts = [Post]()
                    
                    for postDictionary in postsArray {
                        let post = Post(dictionary : postDictionary)
                        self.posts.append(post)
                    }
                }
                
            } catch let err {
                print(err)
            }
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = posts.count
        return count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutterCardCell", for: indexPath) as! OutterCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (view.frame.width ) , height: 1000)
        let attributs = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 16)!]
        let largestString = posts[indexPath.item].listText?.max(by: {$1.count > $0.count})
        let estimated = NSString(string: largestString!).boundingRect(with: size, options: .usesLineFragmentOrigin , attributes: attributs, context: nil)
        return CGSize(width: view.frame.width, height: estimated.height + 175)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    
    
    
    
    
}
