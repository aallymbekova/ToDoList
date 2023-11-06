//
//  TaskListViewCell.swift
//  ToDoList
//
//  Created by darmaraht on 6/11/23.
//

import UIKit

class TaskListViewCell: UITableViewCell {

    static let reuseId = "NewsfeedCodeCell"

    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(cardView)

        cardView.fillSuperview()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

