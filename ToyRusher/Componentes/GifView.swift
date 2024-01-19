//
//  GifImage.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 08/01/24.
//

import SwiftUI
import FLAnimatedImage

enum URLType {

    case name(String)

    case url(URL)
}

struct GIFView: UIViewRepresentable {

    private var type: URLType

    var url: URL? {

          switch type {

          case .name(let name):

            return Bundle.main.url(forResource: name, withExtension: "GIF")

          case .url(let remoteURL):

            return remoteURL

        }

      }


    init(type: URLType) {

        self.type = type

    }

    func makeUIView(context: Context) -> UIView {

      let view = UIView(frame: .zero)




      view.addSubview(activityIndicator)

      view.addSubview(imageView)




      imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

      imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true




      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true




      return view

    }



    func updateUIView(_ uiView: UIView, context: Context) {

      activityIndicator.startAnimating()

        guard let url = url else { return }




      DispatchQueue.global().async {

        if let data = try? Data(contentsOf: url) {

          let image = FLAnimatedImage(animatedGIFData: data)




          DispatchQueue.main.async {

            activityIndicator.stopAnimating()

            imageView.animatedImage = image

          }

        }

      }

    }



    private let imageView: FLAnimatedImageView = {

        let imageView = FLAnimatedImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        // UNCOMMENT TO ADD ROUNDING TO YOUR VIEW

//      imageView.layer.cornerRadius = 24

        imageView.layer.masksToBounds = true

        return imageView

    }()




    private let activityIndicator: UIActivityIndicatorView = {

        let activityIndicator = UIActivityIndicatorView()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.color = .systemBlue

        return activityIndicator

    }()

}
