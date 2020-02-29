//
//  AddDishViewController.swift
//  FoodieFun
//
//  Created by Aaron Cleveland on 2/7/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import UIKit

class AddExperienceViewController: ShiftableViewController {
    
    @IBOutlet weak var dishName: UITextField!
    @IBOutlet weak var dishPrice: UITextField!
    @IBOutlet weak var dishRating: UITextField!
    @IBOutlet weak var dishReview: UITextView!
    @IBOutlet weak var date: UITextField!
    
    var review: Review?
    var reviewController = ReviewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishName.delegate = self
        dishPrice.delegate = self
        dishRating.delegate = self
        dishReview.delegate = self
        date.delegate = self
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updateViews() {
        guard isViewLoaded,
            let review = review else { return }
        dishName.text = review.menuItem
        dishPrice.text = "\(Double(review.itemPrice))"
        dishRating.text = "\(Int16(review.itemRating))"
        dishReview.text = review.itemReview
        date.text = review.dateVisited
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveReview()
    }
    
    func saveReview() {
        guard let dishName = dishName.text,
            !dishName.isEmpty,
            let dishPrice = dishPrice.text,
            !dishPrice.isEmpty,
            let dishRating = dishRating.text,
            !dishRating.isEmpty,
            let dishReview = dishReview.text,
            !dishReview.isEmpty,
            let dishDate = date.text,
            !dishDate.isEmpty else { return }
        print("INBETWEEN!")
        
        if let review = review {
            let newReview = ReviewRepresentation(id: 0,
                                                 menuItem: dishName,
                                                 itemPrice: Double(dishPrice) ?? 0,
                                                 itemRating: Int(dishRating) ?? 0,
                                                 itemReview: dishReview,
                                                 restaurantID: Int(review.restaurantID),
                                                 reviewedBy: review.reviewedBy ?? "",
                                                 itemImageURL: review.itemImageURL ?? "",
                                                 createdAt: review.createdAt,
                                                 updatedAt: review.updatedAt,
                                                 dateVisited: dishDate)
            
            reviewController.update(oldReview: review,
                                    newReview: newReview)
        } else {
            let newReview = ReviewRepresentation(id: 0,
                                                 menuItem: dishName,
                                                 itemPrice: Double(dishPrice) ?? 0,
                                                 itemRating: Int(dishRating) ?? 0,
                                                 itemReview: dishReview,
                                                 restaurantID: Int(review?.restaurantID ?? 0),
                                                 reviewedBy: review?.reviewedBy ?? "",
                                                 itemImageURL: review?.itemImageURL ?? "",
                                                 createdAt: review?.createdAt,
                                                 updatedAt: review?.updatedAt,
                                                 dateVisited: dishDate)
            reviewController.createReview(reviewRep: newReview)
            print("ADDING REVIEW TO TABLEVIEW")
        }
    }
}

extension AddExperienceViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.endEditing(true)
        return true
    }
}
