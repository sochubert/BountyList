//
//  BountyViewController.swift
//  BountyList
//
//  Created by 무빙키 on 2021/07/13.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MVVM
    
    // Model
    // -BountyInfo
    
    
    // View
    // -ListCell
    // ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    // ListCell은 ViewModel로 부터 받은 정보를 뷰 업데이트 하기
    
    // ViewModel
    // -BountyViewModel 만들고 뷰레이어에서 필요한 메서드 만들기
    // 모델 가지고 있기.. BountyInfo들
    
    let viewModel = BountyViewModel()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 준다
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UIColelctionViewDataSource -> 몇개를 보여줄지, 셀은 어떻게 표현할지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as?
                GridCell else {
            return UICollectionViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
            cell.update(info: bountyInfo)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UICollectionViewDelegate -> 셀이 클릭되었을 때, 어쩔까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    
    // UIColelctionViewDelegateFlowlayout -> cell size를 계산한다 (다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
}
    
class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 3300000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 3000000),
        BountyInfo(name: "luffy", bounty: 160000000 ),
        BountyInfo(name: "nami", bounty: 800000),
        BountyInfo(name: "robin", bounty: 77000000),
        BountyInfo(name: "sanji", bounty: 44000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}

    class GridCell: UICollectionViewCell {
        @IBOutlet weak var imgView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var bountyLabel: UILabel!
        
        func update(info: BountyInfo) {
            imgView.image = info.image
            nameLabel.text = info.name
            bountyLabel.text = "\(info.bounty)"
        }
}

