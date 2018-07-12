//
//  Content.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/5.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import Foundation
import UIKit
struct Content {
    var Title:String?
    var SubTitle:String?
    var TopImage:UIImage?
    var IntroTitle:String?
    var Text:String?
    
    init(Title: String, SubTitle: String, TopImage: UIImage, IntroTitle: String,Text: String) {
        self.SubTitle = SubTitle
        self.TopImage = TopImage
        self.IntroTitle = IntroTitle
        self.Text = Text
        self.Title = Title
    }
}
extension Content {
    static var data:[Content]{
        return [Content(Title: "AR", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-1"), IntroTitle: "Introducing Augmented Reality Showcase", Text: "Augmented Reality (AR) is an interactive experience of a real-world environment whose elements are \"augmented\" by computer-generated perceptual information, sometimes across multiple sensory modalities, including visual, auditory, haptic, somatosensory, and olfactory. The overlaid sensory information can be constructive (i.e. additive to the natural environment) or destructive (i.e. masking of the natural environment) and is seamlessly interwoven with the physical world such that it is perceived as an immersive aspect of the real environment.In this way, augmented reality alters one’s ongoing perception of a real world environment, whereas virtual reality completely replaces the user's real world environment with a simulated one. Augmented reality is related to two largely synonymous terms: mixed reality and computer-mediated reality."),
                Content(Title: "Watson", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-2"), IntroTitle: "bulabula", Text: "bulabula"),
                Content(Title: "Block Chain", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-3"), IntroTitle: "bulabula", Text: "bulabula"),
                Content(Title: "Coming Soon", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-4"), IntroTitle: "bulabula", Text: "bulabula"),  Content(Title: "Coming Soon", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-5"), IntroTitle: "bulabula", Text: "bulabula")]
    }
}

