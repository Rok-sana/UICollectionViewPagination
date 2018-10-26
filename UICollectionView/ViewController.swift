//
//  ViewController.swift
//  UICollectionView
//
//  Created by swstation on 8/3/18.
//  Copyright © 2018 swstation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var data : [Int] = []
    var loading: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        data = Array(stride(from: 0, to: 100, by: 1))
        
       
        collectionView.dataSource = self
        collectionView.delegate = self
   
        
    }

}
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
           cell.myLabel.text = "\(data[indexPath.item])"
            return cell
        }
        fatalError()
    }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.row % 2 == 0 {
                let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in }))
                
                self.present(alert, animated: true, completion: nil)
            }
    }
   
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        print(indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.item == data.count - 3  && !loading {
            loading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(100)) {
                let newData = Array(stride(from: self.data.count, to: self.data.count + 27, by: 1))
                
                var indexPaths:[IndexPath] = []
                for v in newData {
                    indexPaths.append(IndexPath(row:v, section: 0))
                }
                self.data += newData
                UIView.performWithoutAnimation {
                collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: indexPaths)
                    }) { (finish) in
                    self.loading = false
                    }
                }
                
         }
            
            


        }

   }



}
