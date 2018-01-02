//
//  InnerCell.swift
//  DebugApp
//

//

import UIKit

class OutterCell: UICollectionViewCell ,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private let textCellId = "InnerCell"
    var post: Post? {
        didSet {
            if let numLikes = post?.numLikes {
                likesLabel.text = "\(numLikes) Likes"
            }
            
            if  let numComments = post?.numComments {
                commentsLabel.text = "\(numComments) Comments"
            }
        }
    }
    
    
    let commentButton: UIButton = OutterCell.buttonForTitle(NSLocalizedString( "Comment", comment: "Comment button"), imageName: "")
    let shareButton: UIButton = OutterCell.buttonForTitle(NSLocalizedString( "Share", comment: "Share button"), imageName: "")
    
    let likesLabel: UILabel = OutterCell.setNbrOfLikesNbrOfComments("0 Likes")
    let commentsLabel: UILabel = OutterCell.setNbrOfLikesNbrOfComments("0 Comments")
    
    static func buttonForTitle(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.setImage(UIImage(named: imageName), for: UIControlState())
        button.imageView?.accessibilityIdentifier = "initial"
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    static func setNbrOfLikesNbrOfComments(_ title:  String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "HelveticaNeue", size: 11)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.imageView?.accessibilityIdentifier = "like"
        button.imageView?.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let greyLine : UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    let innerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame :.zero , collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .orange
        layout.estimatedItemSize =  CGSize(width: cv.frame.width, height: 1)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        return cv
        
    }()
    
    
    let likeViewInButonStackView : UIView = {
        let v = UIView()
        return v
    }()
    
    let commentViewInButonStackView : UIView = {
        let v = UIView()
        return v
    }()
    
    let shareViewInButonStackView : UIView = {
        let v = UIView()
        return v
    }()
    
    
    let pageController : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .gray
        pc.pageIndicatorTintColor = .black
        pc.numberOfPages = 3
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    
    func addAndSetUpButtonStackLayout(){
        
        let buttonStackview = UIStackView(arrangedSubviews: [likeViewInButonStackView,commentViewInButonStackView,shareViewInButonStackView])
        buttonStackview.translatesAutoresizingMaskIntoConstraints = false
        buttonStackview.axis = .horizontal
        buttonStackview.distribution = .fillEqually
        
        addSubview(buttonStackview)
        addSubview(greyLine)
        buttonStackview.leftAnchor.constraint(equalTo: self.leftAnchor , constant:  20 ).isActive  = true
        buttonStackview.rightAnchor.constraint(equalTo: self.rightAnchor , constant:  -20 ).isActive  = true
        buttonStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive  = true
        buttonStackview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        greyLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant:  20  ).isActive  = true
        greyLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -20  ).isActive  = true
        greyLine.bottomAnchor.constraint(equalTo: buttonStackview.topAnchor ).isActive  = true
        greyLine.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        
    }
    
    func setUpLikeIconLayout(){
        
        likeButton.leftAnchor.constraint(equalTo: likeViewInButonStackView.leftAnchor   ).isActive  = true
        likeButton.rightAnchor.constraint(equalTo: likeViewInButonStackView.rightAnchor).isActive  = true
        likeButton.centerYAnchor.constraint(equalTo: likeViewInButonStackView.centerYAnchor).isActive  = true
        likeButton.topAnchor.constraint(equalTo: greyLine.bottomAnchor).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //likeButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setUpCommentIconLayout(){
        
        commentButton.leftAnchor.constraint(equalTo: commentViewInButonStackView.leftAnchor ).isActive  = true
        commentButton.rightAnchor.constraint(equalTo: commentViewInButonStackView.rightAnchor  ).isActive  = true
        commentButton.centerYAnchor.constraint(equalTo: commentViewInButonStackView.centerYAnchor).isActive  = true
        commentButton.topAnchor.constraint(equalTo: greyLine.bottomAnchor).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // commentButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setUpShareIconLayout(){
        
        shareButton.leftAnchor.constraint(equalTo: shareViewInButonStackView.leftAnchor  ).isActive  = true
        shareButton.rightAnchor.constraint(equalTo: shareViewInButonStackView.rightAnchor  ).isActive  = true
        shareButton.centerYAnchor.constraint(equalTo: shareViewInButonStackView.centerYAnchor).isActive  = true
        shareButton.topAnchor.constraint(equalTo: greyLine.bottomAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //   shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setUpInnerCollectionViewLayout(){
        
        innerCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        innerCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        innerCollectionView.topAnchor.constraint(equalTo: self.topAnchor ).isActive  = true
        innerCollectionView.bottomAnchor.constraint(equalTo: pageController.topAnchor, constant: -5).isActive = true
    }
    
    func setUpNbrCommentsLikesLayout(){
        
        let v1 : UIView = {
            let v = UIView()
            return v
        }()
        
        let v2 : UIView = {
            let v = UIView()
            return v
        }()
        let buttonStackview = UIStackView(arrangedSubviews: [v1,v2])
        
        buttonStackview.translatesAutoresizingMaskIntoConstraints = false
        buttonStackview.axis = .horizontal
        buttonStackview.distribution = .fillEqually
        //buttonStackview.semanticContentAttribute = .forceLeftToRight
        //buttonStackview.alignment = .firstBaseline
        
        addSubview(buttonStackview)
        
        buttonStackview.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 20).isActive  = true
        buttonStackview.rightAnchor.constraint(equalTo: self.centerXAnchor , constant: -10 ).isActive  = true
        buttonStackview.bottomAnchor.constraint(equalTo: self.greyLine.topAnchor, constant: -5 ).isActive  = true
        buttonStackview.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likesLabel.leftAnchor.constraint(equalTo: v1.leftAnchor ).isActive  = true
        likesLabel.widthAnchor.constraint(equalTo: v1.widthAnchor ).isActive  = true
        likesLabel.topAnchor.constraint(equalTo: v1.topAnchor ).isActive  = true
        likesLabel.bottomAnchor.constraint(equalTo: v1.bottomAnchor).isActive = true
        
        commentsLabel.leftAnchor.constraint(equalTo: v2.leftAnchor ).isActive  = true
        commentsLabel.rightAnchor.constraint(equalTo: v2.rightAnchor ).isActive  = true
        commentsLabel.topAnchor.constraint(equalTo: v2.topAnchor ).isActive  = true
        commentsLabel.bottomAnchor.constraint(equalTo: v2.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = post?.listText?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textCellId, for: indexPath) as! InnerCell
        
        if indexPath.row == 0{
            cell.backgroundColor = .blue
            cell.text.text = post!.listText![0]
            
        }else if  indexPath.row == 1{
            cell.backgroundColor = .green
            cell.text.text = post!.listText![1]
        }else{
            cell.backgroundColor = .yellow
            cell.text.text = post!.listText![2]
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    
    func setUpPageControlLayout(){
        pageController.leftAnchor.constraint(equalTo: self.leftAnchor ).isActive  = true
        pageController.rightAnchor.constraint(equalTo: self.rightAnchor ).isActive  = true
        pageController.heightAnchor.constraint(equalToConstant: 20 ).isActive  = true
        pageController.bottomAnchor.constraint(equalTo: commentsLabel.topAnchor).isActive = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let  pageNumber = targetContentOffset.pointee.x / innerCollectionView.frame.width
        pageController.currentPage = Int(pageNumber)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        addAndSetUpButtonStackLayout()
        
        innerCollectionView.dataSource = self
        innerCollectionView.delegate = self
        innerCollectionView.register(InnerCell.self, forCellWithReuseIdentifier: textCellId)
        
        addSubview(innerCollectionView)
        
        addSubview(pageController)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(commentsLabel)
        addSubview(likesLabel)
        
        setUpLikeIconLayout()
        setUpCommentIconLayout()
        setUpShareIconLayout()
        setUpNbrCommentsLikesLayout()
        setUpPageControlLayout()
        setUpInnerCollectionViewLayout()
    }
    
    
}


