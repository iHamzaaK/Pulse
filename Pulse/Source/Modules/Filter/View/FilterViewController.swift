//
//  FilterViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

protocol FilterViewProtocol: AnyObject {
  func didTapOnDone(selectedFilter: SelectedFilters) -> Void
}
class FilterViewController: BaseViewController {
  weak var delegate: FilterViewProtocol?

  @IBOutlet weak var btnClose: UIButton!
  var viewModel : FilterViewModel!
  @IBOutlet var txtKeywords : UITextField!
  @IBOutlet var heightConstraintCollectionView : NSLayoutConstraint!
  @IBOutlet var heightConstraintCollectionViewDateTime : NSLayoutConstraint!
  @IBOutlet var collectionViewKeywords: UICollectionView!{
    didSet{
      collectionViewKeywords.tag = 0
      collectionViewKeywords.delegate = self
      collectionViewKeywords.dataSource = self
      collectionViewKeywords.isScrollEnabled = false
      Utilities.registerNibForCollectionView(nibName: "KeywordCollectionViewCell", identifier: "KeywordCollectionViewCell", colView: collectionViewKeywords)
      Utilities.registerNibForCollectionView(
        nibName: "CountryCollectionViewCell",
        identifier: "CountryCollectionViewCell",
        colView: collectionViewKeywords
      )
      collectionViewKeywords.register(UINib(nibName: "FilterHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterHeader")
      

    }
  }
  @IBOutlet var collectionViewCountryDateTime: UICollectionView!{
    didSet{
      collectionViewCountryDateTime.tag = 1
      collectionViewCountryDateTime.delegate = self
      collectionViewCountryDateTime.dataSource = self
      Utilities.registerNibForCollectionView(
        nibName: "DateTimeCollectionViewCell",
        identifier: "DateTimeCollectionViewCell",
        colView: collectionViewCountryDateTime
      )

      collectionViewCountryDateTime
        .register(
          UINib(nibName: "FilterHeader", bundle: nil),
          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterHeader"
        )


    }
  }
  override func viewDidLayoutSubviews() {
    layoutCollectioViewKeywords()
    super.viewDidLayoutSubviews()

  }
  override func viewDidLoad() {
    super.viewDidLoad()
    navBarType = .clearNavBar
    //self.viewModel.getNavigationBar()
    btnClose.setTitle("", for: .normal)
    configureFlowLayout()
    self.view.backgroundColor = UIColor.white
    
  }

  @IBAction func didTapOnDismiss(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func didTapOnSave(_ sender: Any) {
    let selectedFilters = self.viewModel.getAllFilters()
    self.delegate?.didTapOnDone(selectedFilter: selectedFilters)
    self.dismiss(animated: true) {
    }
  }
  private func layoutCollectioViewKeywords(){
    let height = collectionViewKeywords.collectionViewLayout.collectionViewContentSize.height
//    if height > heightConstraintCollectionView.constant {
      heightConstraintCollectionView.constant = height
//    }
    collectionViewKeywords.reloadData()

    self.view.setNeedsLayout()
  }
}

extension FilterViewController {
  private func configureFlowLayout(){
    let layout: UICollectionViewFlowLayout = UICollectionViewLeftAlignedLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.headerReferenceSize = CGSize(width: 0, height: 20)
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 5
    layout.sectionInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)

    collectionViewKeywords.collectionViewLayout = layout



    let layout2 = JEKScrollableSectionCollectionViewLayout()
    layout2.itemSize = CGSize(width: 100, height: 30);
    layout2.headerReferenceSize = CGSize(width: 0, height: 20)
    layout2.minimumInteritemSpacing = 5
    layout2.sectionInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
    collectionViewCountryDateTime.collectionViewLayout = layout2


  }
}
extension FilterViewController: UICollectionViewDataSource, KeywordCollectionDelegate, DateTimeCollectionProtocol, CountryCollectionProtocol {

  func didSelectCountry(row: Int) {
    viewModel.selectedCountry = viewModel.getCountries()[row].title ?? ""
    collectionViewKeywords.reloadData()//reloadSections(IndexSet(integer: 1))
  }
  func didSelectTime(row: Int) {
    viewModel.selectedDateTime = row
    collectionViewCountryDateTime.reloadSections(IndexSet(integer: 0))

  }
  func didTapOnCancel(row: Int) {
    viewModel.didDeleteKeyword(for: row)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.view.setNeedsLayout()
    }
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.rowsForSection(section: section, tag: collectionView.tag)
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.sectionsForCollectionView(tag: collectionView.tag)
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == collectionViewKeywords {
      if indexPath.section == 0 {

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
      let width = collectionView.bounds.width - 2
      cell.delegate = self
      cell.configCell(viewModel: viewModel.cellViewModel(for: indexPath.row), row: indexPath.row, cellWidth: width)
      return cell
      }
      else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as! CountryCollectionViewCell
        let row = indexPath.row
        cell.delegate = self
        let width = collectionView.bounds.width - 10
        cell.configCell(viewModel: viewModel.cellViewModel(for: row), row: row, width: width)
        return cell
      }
    }
    else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateTimeCollectionViewCell", for: indexPath) as! DateTimeCollectionViewCell
        let row = indexPath.row
        cell.delegate = self
        cell.configCell(viewModel: viewModel.cellViewModel(for: row), row: row)
        return cell

    }
  }


}


extension FilterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    if collectionView == collectionViewKeywords {
//      if section == 0 {
//      return CGSize(width: 10, height: 10)
//      }
//      else {
    if collectionView == collectionViewKeywords {
      return  CGSize(width: 10, height: 10)
    }
    return viewModel.sizeForItem(row: indexPath.row, section: indexPath.section, tag: collectionView.tag)
//      }
//    }
//    else {
//        return viewModel.sizeForItem(row: indexPath.row, section: indexPath.section)
//    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:

      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterHeader", for: indexPath) as! FilterHeader
      if collectionView == collectionViewCountryDateTime {
        headerView.lblTitle.text = "Date & Time"//viewModel.title(forSection: indexPath.section)
      }
      else {
        headerView.lblTitle.text = "Countries"
      }
      return headerView
      //      }

    default:
      fatalError()
      //assert(false, "Unexpected element kind")
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

    let height = viewModel.heightForSectionHeader(section: section, tag: collectionView.tag)
    return CGSize(width: Int(collectionView.frame.width), height: height)
//    if collectionView == collectionViewKeywords {
//      if section == 0 {
//        return CGSize.zero
//      }
//    }
//    if collectionView == collectionViewCountryDateTime {
//      return CGSize(width: Int(collectionView.frame.width), height: viewModel.heightForSectionHeader(section: section))
//    }
//    return CGSize.zero
  }
}

extension FilterViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    if let keyword = textField.text, keyword != "" {
      viewModel.addKeywords(keyword: keyword)
//      collectionViewKeywords.invalidateIntrinsicContentSize()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        self.view.setNeedsLayout()
      }
    }
    textField.text = ""

    return true
  }

}
