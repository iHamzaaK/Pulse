//
//  NotificationListingTableViewCell.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import UIKit

protocol SwipeableCellDelegate: class {
    func cellDidClose(row: Int)->Void
    func cellDidOpen(row: Int)->Void
    func didTapOnDelete(row: Int)->Void
}
class NotificationListingTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDelete : BaseUIButton!{
        didSet{
            btnDelete.addTarget(self, action: #selector(self.didTapOnDelete), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var lblTag: BaseUILabel!
    @IBOutlet weak var lblTitle: BaseUILabel!
    @IBOutlet weak var imgView: BaseUIImageView!
    @IBOutlet weak var myContentView: BaseUIView!
    let kBounceValue : CGFloat = 20.0
    weak var delegate : SwipeableCellDelegate!
    let leftRightConstraintVal : CGFloat = 0
//    @property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
//    @property (nonatomic, assign) CGPoint panStartPoint;
//    @property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
//    @property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
//    @property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
    var panRecognizer : UIPanGestureRecognizer!
    var panStartPoint : CGPoint!
    var startingRightLayoutConstraintConstant : CGFloat!
    @IBOutlet weak var contentViewLeftConstraint : BaseLayoutConstraint!
    @IBOutlet weak var contentViewRightConstraint : BaseLayoutConstraint!

    
    
    
    var cellViewModel : NotificationListingCellViewModel!{
        didSet{
            self.lblTag.text = cellViewModel.tag
            self.lblTitle.text = cellViewModel.title
            self.setupThumbnailImage()
        }
    }
    func buttonTotalWidth()-> CGFloat{
        return self.frame.width - self.btnDelete.frame.minX
    }
    @objc func panThisCell(recognizer : UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            self.panStartPoint = recognizer.translation(in: self.myContentView)
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
            
            break;
        case .changed:
            let currentPoint = recognizer.translation(in: self.myContentView)
            let deltaX : CGFloat = currentPoint.x - self.panStartPoint.x;
            var panningLeft = false;
              if (currentPoint.x < self.panStartPoint.x) {  //1
                panningLeft = true;
              }

              if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal) { //2
                //The cell was closed and is now opening
                if (!panningLeft) {
                    let constant : CGFloat = max(-deltaX, leftRightConstraintVal); //3
                  if (constant == 20) { //4
                    self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: false)
                  } else {
                    self.contentViewRightConstraint.constant = constant;
                  }
                } else {
                    let constant : CGFloat = min(-deltaX, self.buttonTotalWidth()); //6
                    if (constant == self.buttonTotalWidth()) { //7
                        self.setConstraintsToShowAllButtons(animated:true, notifyDelegateDidOpen: false)
                  } else { //8
                    self.contentViewRightConstraint.constant = constant;
                  }
                }
              }
              else {
                  //The cell was at least partially open.
                    let adjustment : CGFloat = self.startingRightLayoutConstraintConstant - deltaX; //1
                  if (!panningLeft) {
                    let constant :CGFloat = max(adjustment, leftRightConstraintVal); //2
                    if (constant == 20) { //3
                        self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: false)
                    } else { //4
                      self.contentViewRightConstraint.constant = constant;
                    }
                  } else {
                    let constant:CGFloat = min(adjustment, self.buttonTotalWidth()); //5
                    if (constant == self.buttonTotalWidth()) { //6
                        self.setConstraintsToShowAllButtons(animated:true, notifyDelegateDidOpen: false)
                    } else { //7
                      self.contentViewRightConstraint.constant = constant;
                    }
                  }
                }
                self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant; //8
              
            break;
        case .ended:
            if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal) { //1
                //Cell was opening
                var halfOfButtonOne : CGFloat = self.btnDelete.frame.size.width
                
                //CGRectGetWidth(self.button1.frame) / 2; //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
                  //Open all the way
                    self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
                } else {
                  //Re-close
                    self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
                }
              } else {
                //Cell was closing
                
                let  buttonOnePlusHalfOfButton2  : CGFloat = self.btnDelete.frame.size.width
                //(CGRectGetWidth(self.button2.frame) / 2); //4
                
                if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) { //5
                  //Re-open all the way
                    self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
//                  [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                  //Close
                    self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
//                  [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
              }
              break;
        case .cancelled:
            if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal) {
                //Cell was closed - reset everything to 0
                self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
              } else {
                //Cell was open - reset to the open state
                self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
              }
              break;
            
            
        default:
            break
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetConstraintContstantsToZero(animated: false, notifyDelegateDidClose: false)
    }
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @objc func didTapOnDelete(){
        delegate.didTapOnDelete(row: self.tag)
    }
    func openCell(){
        self.setConstraintsToShowAllButtons(animated: false, notifyDelegateDidOpen: false)
    }
    func updateConstraintsIfNeeded(animated: Bool, completion: @escaping ( _ finished : Bool)->Void ) {
        var duration : Double = 0;
          if (animated) {
            duration = 0.1;
          }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
        
        //1

    }
    func resetConstraintContstantsToZero(animated : Bool , notifyDelegateDidClose: Bool){
        
        if (notifyDelegateDidClose) {
            self.delegate.cellDidClose(row: self.tag)//[self.delegate cellDidClose:self];
        }
        if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal &&
              self.contentViewRightConstraint.constant == leftRightConstraintVal) {
            //Already all the way closed, no bounce necessary
            return;
          }

          self.contentViewRightConstraint.constant = -kBounceValue;
          self.contentViewLeftConstraint.constant = kBounceValue;

        self.updateConstraintsIfNeeded(animated: animated) { (finished) in
            self.contentViewRightConstraint.constant = self.leftRightConstraintVal
            self.contentViewLeftConstraint.constant = self.leftRightConstraintVal
            self.updateConstraintsIfNeeded(animated: animated) { (finished) in
                self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant
            }
        }
    }
    func setConstraintsToShowAllButtons(animated : Bool , notifyDelegateDidOpen: Bool){
        if (notifyDelegateDidOpen) {
            self.delegate.cellDidOpen(row: self.tag)
        }
        if (self.startingRightLayoutConstraintConstant == self.buttonTotalWidth() + 10 &&
                self.contentViewRightConstraint.constant == self.buttonTotalWidth() + 10) {
            return;
        }
        //2
        self.contentViewLeftConstraint.constant =  -self.buttonTotalWidth() - kBounceValue;
        self.contentViewRightConstraint.constant = self.buttonTotalWidth() + kBounceValue;
        self.updateConstraintsIfNeeded(animated: animated) { (finished) in
            self.contentViewLeftConstraint.constant = -self.buttonTotalWidth()
            self.contentViewRightConstraint.constant = self.buttonTotalWidth() + 10
            self.updateConstraintsIfNeeded(animated: animated) { (finished) in
                self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.panThisCell(recognizer:)))
        self.panRecognizer.delegate = self;
        self.myContentView.addGestureRecognizer(self.panRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupThumbnailImage(){
        imgView.layer.cornerRadius = 10
        if let bgImageURL = cellViewModel.getImageURL() {
            Utilities.getImageFromURL(imgView:imgView, url: bgImageURL){ (_) in
                self.setNeedsLayout()
            }
        }
        else{
            self.imgView.image = UIImage.init(named: "placeholder")
        }
    }
}
