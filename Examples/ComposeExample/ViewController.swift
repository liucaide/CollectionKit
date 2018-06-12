//
//  ViewController.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-07-23.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit
import CollectionKit

let bodyInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
let headerInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)

func space(_ height: CGFloat) -> SpaceProvider {
  return SpaceProvider(sizeStrategy: (.fill, .absolute(height)))
}

class ViewController: CollectionViewController {

  let examples: [(String, UIViewController.Type)] = [
    ("Horizontal Gallery", HorizontalGalleryViewController.self),
    ("Grid", GridViewController.self),
    ("Articles", ArticleExampleViewController.self),
    ("Reload", ReloadDataViewController.self),
    ("Reload Animation", ReloadAnimationViewController.self),
    ("Header", HeaderExampleViewController.self),
    ("Chat", MessagesViewController.self),
    ("Presenters", PresenterExampleViewController.self)
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    let examplesSection = BasicProviderBuilder
      .with(data: examples)
      .with(viewUpdater: { (view: ExampleView, data: (String, UIViewController.Type), at: Int) in
        view.populate(title: data.0, contentViewControllerType: data.1)
      })
      .with(layout: FlowLayout(lineSpacing: 30).inset(by: bodyInset))
      .with(sizeSource: { (_, _, size) -> CGSize in
        return CGSize(width: size.width, height: max(360, UIScreen.main.bounds.height * 0.7))
      })
      .build()

    provider = ComposedProvider(sections: [
      space(100),
      LabelCollectionProvider(text: "CollectionKit", font: .boldSystemFont(ofSize: 38), insets: headerInset),
      LabelCollectionProvider(text: "A modern swift framework for building reusable collection view components.", font: .systemFont(ofSize: 20), insets: bodyInset),
      space(30),
      LabelCollectionProvider(text: "Examples", font: .boldSystemFont(ofSize: 30), insets: headerInset),
      examplesSection,
      space(30)
    ])
  }

}
