//
//  OnBoarding2.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 23/06/25.
//

import UIKit

class OnBoarding2: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var imgBackground: UIImageView!
    @IBOutlet var collectionView2: UICollectionView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var pageControl: CustomPageControl!
    @IBOutlet var vContentContainer: UIView!
    
    private var imgBackground2: UIImageView!
    private var isTransitioning = false
    
    var slides: [OnBoarding2Slide] = [] {
        didSet {
            if collectionView2 != nil && !slides.isEmpty {
                setupInfiniteScrollSlides()
                collectionView2.reloadData()
                
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 1, section: 0)
                    self.collectionView2.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                    self.currentPage = 1
                    self.setupContent(self.wrapSlides[1])
                    self.updateBackgroundImage()
                }
                
                pageControl.numberOfPages = slides.count
                pageControl.currentPage = 0
            }
        }
    }
    
    private var oriSlides: [OnBoarding2Slide] = []
    private var wrapSlides: [OnBoarding2Slide] = []
    
    var currentPage = 0
    private var autoScrollTimer: Timer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        vContentContainer.layer.sublayers?.forEach {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        
        applyGradientToContentContainer()
        
        if currentPage == 1 && collectionView2.contentOffset.x == 0 {
            let indexPath = IndexPath(item: 1, section: 0)
            collectionView2.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupOnBoarding()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupOnBoarding()
    }
    
    private func setupOnBoarding() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("OnBoarding2", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            collectionView2.delegate = self
            collectionView2.dataSource = self
            
            let nib = UINib(nibName: "OnBoarding2Cell", bundle: nil)
            collectionView2.register(nib, forCellWithReuseIdentifier: OnBoarding2Cell.identifier)
            
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
        
        collectionView2.backgroundColor = UIColor.clear
        
        imgBackground.contentMode = .scaleAspectFill
        imgBackground.clipsToBounds = true
        
        setupSecondBackgroundImageView()
        
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
    
    private func setupSecondBackgroundImageView() {
        imgBackground2 = UIImageView()
        imgBackground2.contentMode = .scaleAspectFill
        imgBackground2.clipsToBounds = true
        imgBackground2.alpha = 0
        
        if let backgroundIndex = containerView.subviews.firstIndex(of: imgBackground) {
            containerView.insertSubview(imgBackground2, at: backgroundIndex + 1)
        }
        
        imgBackground2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgBackground2.topAnchor.constraint(equalTo: imgBackground.topAnchor),
            imgBackground2.leadingAnchor.constraint(equalTo: imgBackground.leadingAnchor),
            imgBackground2.trailingAnchor.constraint(equalTo: imgBackground.trailingAnchor),
            imgBackground2.bottomAnchor.constraint(equalTo: imgBackground.bottomAnchor)
        ])
    }
    
    private func updateBackgroundImage() {
        guard !wrapSlides.isEmpty else { return }
        
        let width = collectionView2.frame.width
        guard width > 0 else { return }
        
        let contentOffsetX = collectionView2.contentOffset.x
        let progress = contentOffsetX / width
        
        let currentIndex = Int(floor(progress))
        let nextIndex = currentIndex + 1
        let transitionProgress = progress - CGFloat(currentIndex)
        
        let safeCurrentIndex = max(0, min(currentIndex, wrapSlides.count - 1))
        let safeNextIndex = max(0, min(nextIndex, wrapSlides.count - 1))
        
        guard safeCurrentIndex != safeNextIndex && transitionProgress > 0 && transitionProgress < 1 else {
                if transitionProgress == 0 {
                    imgBackground.image = wrapSlides[safeCurrentIndex].imageBackground
                    imgBackground2.alpha = 0
                }
                return
            }
        
        let currentImage = wrapSlides[safeCurrentIndex].imageBackground
        let nextImage = wrapSlides[safeCurrentIndex].imageBackground
        
        if imgBackground.image != currentImage {
            imgBackground.image = currentImage
        }
        
        if imgBackground2.image != currentImage {
            imgBackground2.image = currentImage
        }
        
        let fade = min(max(transitionProgress, 0), 1)
        
        imgBackground2.alpha = fade
    }
    
    private func updateBackgroundImageProgressive() {
        guard !wrapSlides.isEmpty else { return }
        
        let width = collectionView2.frame.width
        guard width > 0 else { return }
        
        let contentOffsetX = collectionView2.contentOffset.x
        let progress = contentOffsetX / width
        
        let currentIndex = Int(floor(progress))
        let nextIndex = currentIndex + 1
        let transitionProgress = progress - CGFloat(currentIndex)
        
        let safeCurrentIndex = max(0, min(currentIndex, wrapSlides.count - 1))
        let safeNextIndex = max(0, min(nextIndex, wrapSlides.count - 1))
        
        imgBackground.image = wrapSlides[safeCurrentIndex].imageBackground
        
        if safeCurrentIndex != safeNextIndex && transitionProgress > 0 {
            imgBackground2.image = wrapSlides[safeNextIndex].imageBackground
            
            let eased = easeInOutQuad(transitionProgress)
            imgBackground2.alpha = eased
        } else if transitionProgress == 0 {
            imgBackground2.alpha = 0
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
    
    private func setupContent(_ onBoardingSlide: OnBoarding2Slide) {
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
       let width = collectionView2.frame.width
       let nextXOffset = CGFloat(nextPage) * width
       
       let startOffset = collectionView2.contentOffset.x
       
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
               self.pageControl.currentPage = 0
               self.collectionView2.setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
               self.pageControl.currentPage = 0
               
               self.setupContent(self.wrapSlides[self.currentPage])
               self.updateBackgroundImage()
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
            imgBackground2.alpha = 0
            return
        }
        
        let progress = CGFloat(elapsed / animationDuration)
        let easedProgress = easeInOutQuad(progress)
        
        let currentOffset = animationStartOffset + (animationEndOffset - animationStartOffset) * easedProgress
        
        collectionView2.setContentOffset(CGPoint(x: currentOffset, y: 0), animated: false)
        
        if !wrapSlides.isEmpty {
            let width = collectionView2.frame.width
            let normalizedOffset = currentOffset / width - 1
            pageControl.scrollProgress = normalizedOffset
            
            updateBackgroundImageProgressive()
        }
    }

    private func easeInOutQuad(_ t: CGFloat) -> CGFloat {
        return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t
    }
    
    private func setBackgroundImageImmediate(_ image: UIImage?) {
        imgBackground.image = image
        imgBackground2.alpha = 0
    }
   
   private func stopDisplayLink() {
       displayLink?.invalidate()
       displayLink = nil
   }
    
   func viewWillAppear() {
       startAutoScrollTimer()
       stopDisplayLink()
   }
   
   func viewWillDisappear() {
       stopAutoScrollTimer()
   }
   
   deinit {
       stopAutoScrollTimer()
       stopDisplayLink()
   }
   
}

extension OnBoarding2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wrapSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoarding2Cell.identifier, for: indexPath) as! OnBoarding2Cell
        
        cell.setup(wrapSlides[indexPath.item].imageIllustration)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != collectionView2 {
            return
        }
        
        let width = scrollView.frame.width
        let contentOffsetX = scrollView.contentOffset.x
        let actualPage = contentOffsetX / width
        
        updateBackgroundImageProgressive()
        
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != collectionView2 {
            return
        }
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
        if currentPage == 0 {
            currentPage = wrapSlides.count - 2
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView2.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        } else if currentPage == wrapSlides.count - 1 {
            currentPage = 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView2.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        setupContent(wrapSlides[currentPage])
        setBackgroundImageImmediate(wrapSlides[currentPage].imageBackground)
        startAutoScrollTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView != collectionView2 {
            return
        }
        
        stopAutoScrollTimer()
        stopDisplayLink()
    }
}
