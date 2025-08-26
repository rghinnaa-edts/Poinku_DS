//
//  OnBoarding.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 25/04/25.
//

import UIKit

public class OnBoarding: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: CustomPageControl!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    
    @IBOutlet var vContentContainer: UIView!
    
    public var slides: [OnBoardingSlide] = [] {
        didSet {
            if collectionView != nil && !slides.isEmpty {
                setupInfiniteScrollSlides()
                collectionView.reloadData()
                
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 1, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                    self.currentPage = 1
                    self.setupContent(self.wrapSlides[1])
                }
                
                pageControl.numberOfPages = slides.count
                pageControl.currentPage = 0
            }
        }
    }
    
    public var currentPage = 0
   
    private var oriSlides: [OnBoardingSlide] = []
    private var wrapSlides: [OnBoardingSlide] = []
    private var autoScrollTimer: Timer?
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        vContentContainer.layer.sublayers?.forEach {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        
        applyGradientToContentContainer()
        
        if currentPage == 1 && collectionView.contentOffset.x == 0 {
            let indexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupOnBoarding()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupOnBoarding()
    }
   
    public func viewWillAppear() {
        startAutoScrollTimer()
        stopDisplayLink()
    }
    
    public func viewWillDisappear() {
        stopAutoScrollTimer()
    }
    
    private func setupOnBoarding() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("OnBoarding", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            let nib = UINib(nibName: "OnBoardingCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: OnBoardingCell.identifier)
            
            setupUI()
            startAutoScrollTimer()
        } else {
            print("Failed to load Chip XIB")
        }
    }
    
    private func setupUI() {
        lblTitle.font = Font.H1.font
        lblTitle.textColor = UIColor.grey80
        
        lblDesc.font = Font.Paragraph.P2.Small.font
        lblDesc.textColor = UIColor.grey80
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        pageControl.activeColor = UIColor.blue30
        pageControl.inactiveColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        vContentContainer.backgroundColor = .white
        
        applyGradientToContentContainer()
    }
    
    private func setupInfiniteScrollSlides() {
        oriSlides = slides
        wrapSlides = slides
        
        if !slides.isEmpty {
            let firstSlide = slides[0]
            let lastSlide = slides[slides.count - 1]
            
            wrapSlides.insert(lastSlide, at: 0)
            wrapSlides.append(firstSlide)
        }
    }
    
    private func applyGradientToContentContainer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = vContentContainer.bounds
        
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        
        gradientLayer.locations = [0.85, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        vContentContainer.backgroundColor = .clear
        vContentContainer.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupContent(_ onBoardingSlide: OnBoardingSlide) {
        lblTitle.text = onBoardingSlide.title
        lblDesc.text = onBoardingSlide.description
        
        lblTitle.alpha = 0
        lblDesc.alpha = 0
        
        lblTitle.transform = CGAffineTransform(translationX: 0, y: 20)
        lblDesc.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.lblTitle.alpha = 1
            self.lblTitle.transform = CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.lblDesc.alpha = 1
            self.lblDesc.transform = CGAffineTransform.identity
        })
    }
    
    private func startAutoScrollTimer() {
        stopAutoScrollTimer()
        stopDisplayLink()
        
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScrollTimer() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
   
   private var animationStartTime: CFTimeInterval = 0
   private var animationDuration: CFTimeInterval = 0
   private var animationStartOffset: CGFloat = 0
   private var animationEndOffset: CGFloat = 0
   private var displayLink: CADisplayLink?
    
   @objc private func scrollToNextPage() {
       let nextPage = currentPage + 1
       let width = collectionView.frame.width
       let nextXOffset = CGFloat(nextPage) * width
       
       let startOffset = collectionView.contentOffset.x
       
       displayLink = CADisplayLink(target: self, selector: #selector(updateScroll))
       displayLink?.add(to: .current, forMode: .common)
       
       animationStartTime = CACurrentMediaTime()
       animationDuration = 0.5
       animationStartOffset = startOffset
       animationEndOffset = nextXOffset
       
       currentPage = nextPage
       
       if currentPage == wrapSlides.count - 1 {
           DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.1) {
               self.currentPage = 1
               let newOffset = CGFloat(self.currentPage) * width
               self.collectionView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
               self.pageControl.currentPage = 0
               
               self.setupContent(self.wrapSlides[self.currentPage])
           }
       } else {
           let actualPage = (currentPage - 1) % oriSlides.count
           pageControl.currentPage = actualPage
           setupContent(wrapSlides[currentPage])
       }
   }
   
   @objc private func updateScroll() {
       let elapsed = CACurrentMediaTime() - animationStartTime
       
       if elapsed >= animationDuration {
           stopDisplayLink()
           return
       }
       
       let progress = CGFloat(elapsed / animationDuration)
       let easedProgress = easeInOutQuad(progress)
       
       let currentOffset = animationStartOffset + (animationEndOffset - animationStartOffset) * easedProgress
       
       collectionView.setContentOffset(CGPoint(x: currentOffset, y: 0), animated: false)
       
       if !wrapSlides.isEmpty {
           let width = collectionView.frame.width
           let normalizedOffset = currentOffset / width - 1
           pageControl.scrollProgress = normalizedOffset
       }
   }

   private func easeInOutQuad(_ t: CGFloat) -> CGFloat {
       return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t
   }
   
   private func stopDisplayLink() {
       displayLink?.invalidate()
       displayLink = nil
   }
   
   deinit {
       stopAutoScrollTimer()
       stopDisplayLink()
   }
   
}

extension OnBoarding: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wrapSlides.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
        
        cell.setup(wrapSlides[indexPath.item].image)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating {
            return
        }
        
        let width = scrollView.frame.width
        let contentOffsetX = scrollView.contentOffset.x
        let actualPage = contentOffsetX / width
        
        if actualPage <= 0 {
            let progressInLastPage = actualPage
            let adjustedProgress = CGFloat(oriSlides.count - 1) + progressInLastPage
            pageControl.scrollProgress = adjustedProgress
        } else if actualPage >= CGFloat(wrapSlides.count - 1) {
            let progressPastLastPage = actualPage - CGFloat(wrapSlides.count - 1)
            pageControl.scrollProgress = progressPastLastPage
        } else {
            pageControl.scrollProgress = actualPage - 1
        }
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
        if currentPage == 0 {
            currentPage = wrapSlides.count - 2
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        } else if currentPage == wrapSlides.count - 1 {
            currentPage = 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        setupContent(wrapSlides[currentPage])
        startAutoScrollTimer()
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScrollTimer()
        stopDisplayLink()
    }
}

