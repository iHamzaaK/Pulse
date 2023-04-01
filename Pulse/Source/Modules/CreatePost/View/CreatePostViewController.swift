//
//  CreatePostViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 21/11/2020.
//

import UIKit

final class CreatePostViewController: BaseViewController {
  var viewModel : CreatePostViewModel!
  @IBOutlet weak var imgDisplay : BaseUIImageView!
  @IBOutlet weak var lblUserName : BaseUILabel!
  @IBOutlet weak var txtPost : BaseUITextView!
  @IBOutlet weak var btnClose : BaseUIButton!{
    didSet{
      btnClose.addTarget(self, action: #selector(self.didTapOnClose), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnPost : BaseUIButton!{
    didSet{
      btnPost.addTarget(self, action: #selector(self.didTapOnPost), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnAddPhoto : BaseUIButton!{
    didSet{
      btnAddPhoto.addTarget(self, action: #selector(self.didTapOnAddPhotos), for: .touchUpInside)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navBarType = self.viewModel.getNavigationBar()
  }
}

extension CreatePostViewController{
  @objc func didTapOnClose(){
    self.dismiss(animated: true, completion: nil)
  }

  @objc func didTapOnAddPhotos(){}

  @objc  func  didTapOnPost(){
    self.dismiss(animated: true, completion: nil)
  }
}
