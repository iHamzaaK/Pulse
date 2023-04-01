//
//  NotificationListingTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 15/12/2020.
//

import UIKit

protocol SwipeableCellDelegate: AnyObject {
  func cellDidClose(row: Int)->Void
  func cellDidOpen(row: Int)->Void
  func didTapOnDelete(row: Int)->Void
}

final class NotificationListingTableViewCell: UITableViewCell {
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
  @IBOutlet weak var contentViewLeftConstraint : BaseLayoutConstraint!
  @IBOutlet weak var contentViewRightConstraint : BaseLayoutConstraint!

  let leftRightConstraintVal : CGFloat = 0
  let kBounceValue : CGFloat = 20.0
  weak var delegate : SwipeableCellDelegate!
  var panRecognizer : UIPanGestureRecognizer!
  var panStartPoint : CGPoint!
  var startingRightLayoutConstraintConstant : CGFloat!
  var cellViewModel : NotificationListingCellViewModel!{
    didSet{
      self.lblTag.text = cellViewModel.tag
      self.lblTitle.text = cellViewModel.title
      self.btnComments.setTitle("\(cellViewModel.commentCount)", for: .normal)
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
      break

    case .changed:
      let currentPoint = recognizer.translation(in: self.myContentView)
      let deltaX : CGFloat = currentPoint.x - self.panStartPoint.x;
      var panningLeft = false;
      if (currentPoint.x < self.panStartPoint.x) {  //1
        panningLeft = true;
      }
      if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal) { //2
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
        var halfOfButtonOne : CGFloat = self.btnDelete.frame.size.width //2
        if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
          self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
        } else {
          self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
        }
      } else {
        let  buttonOnePlusHalfOfButton2  : CGFloat = self.btnDelete.frame.size.width
        if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) { //5
          self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
        } else {
          self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
        }
      }
      break;
    case .cancelled:
      if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal) {
        self.resetConstraintContstantsToZero(animated: true, notifyDelegateDidClose: true)
      } else {
        self.setConstraintsToShowAllButtons(animated: true, notifyDelegateDidOpen: true)
      }
      break

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
  }

  func resetConstraintContstantsToZero(animated : Bool , notifyDelegateDidClose: Bool){
    if (notifyDelegateDidClose) {
      self.delegate.cellDidClose(row: self.tag)
    }
    if (self.startingRightLayoutConstraintConstant == leftRightConstraintVal &&
        self.contentViewRightConstraint.constant == leftRightConstraintVal) {
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
    self.selectionStyle = .none
    self.panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.panThisCell(recognizer:)))
    self.panRecognizer.delegate = self;
    self.myContentView.addGestureRecognizer(self.panRecognizer)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
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
