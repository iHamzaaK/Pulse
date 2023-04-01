//
//  ToolbarPickerView.swift
//  Halal
//
//  Created by hamza Ahmed on 26.11.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation
import UIKit

protocol ToolbarPickerViewDelegate: class {
  func didTapDone()
  func didTapCancel()
}

class customPickerView : UIView, UIPickerViewDataSource, UIPickerViewDelegate{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }

  private var pickerView : UIPickerView!
  public weak var toolbarDelegate: ToolbarPickerViewDelegate?
  var pickerData : [String] = [String]()
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func createPicker(){
    let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

    let barAccessory = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
    barAccessory.barStyle = .default
    barAccessory.isTranslucent = false
    barAccessory.items = [cancelButton, spaceButton, btnDone]
    self.addSubview(barAccessory)
    pickerView = UIPickerView(frame: CGRect(x: 0, y: barAccessory.frame.height, width: self.frame.width, height: self.frame.height-barAccessory.frame.height))
    pickerView.delegate = self
    pickerView.dataSource = self
    //           pickerView = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    pickerView.backgroundColor = UIColor.white
    self.addSubview(pickerView)

  }
  @objc func doneTapped() {
    self.toolbarDelegate?.didTapDone()
  }

  @objc func cancelTapped() {
    self.toolbarDelegate?.didTapCancel()
  }

}
class ToolbarPickerView: UIPickerView {

  public private(set) var toolbar: UIToolbar?
  public weak var toolbarDelegate: ToolbarPickerViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  private func commonInit() {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = .black
    toolBar.sizeToFit()

    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true

    self.toolbar = toolBar
  }

  @objc func doneTapped() {
    self.toolbarDelegate?.didTapDone()
  }

  @objc func cancelTapped() {
    self.toolbarDelegate?.didTapCancel()
  }
}
