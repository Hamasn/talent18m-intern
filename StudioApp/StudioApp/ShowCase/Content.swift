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
            Content(Title: "Watson", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-2"), IntroTitle: "Watson Introduction", Text: "它是基于IBM认知技术和云平台的Watson Display。它是一个我们团队最近开发的虚拟的语音助手原型，这个原型和其他语音助手不同的是它使用了IBM Watson 技术，其中包括语音识别、自然语言处理和学习能力。最近几个月，我们每天和它一起，教它学习IBM 为不同行业打造的解决方案。"),
            Content(Title: "IOT", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-4"), IntroTitle: "IoT Introduction", Text: "我们这个区域叫做物联网实验室，在这个实验室中，我们帮助客户进行各种基于Watson物联网技术的概念验证 。我们将展示2个机器人，这些机器人是采用的是更灵活的芯片级设备进行组装，相对于套机的机器人，我们可以有更灵活的控制，但同时也加大了整个开发的难度。机器人上的传感器主要涵盖了红外，超声，视频，边界等方面。我们的方案是通过Watson整合各种设备、元件，实现自动化认知物联解决方案。"),
            Content(Title: "Block Chain", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-3"), IntroTitle: "Block Chain Introduction", Text: "近年来，IBM在区块链技术上做了很大的投资和技术储备。IBM是hyperledger（超级帐本）项目的主要成员，为其贡献了大量的代码。而Hyperledger项目是Linux基金会的一个开源的区块链项目。全球有超过200家企业都是他的会员。其中有一些知名的科技企业，还有摩根大通，空客，戴姆勒，万达等行业巨头。因此也可以看出IBM在区块链技术上是很有影响力的。"),
            Content(Title: "Design", SubTitle: "showcase", TopImage: #imageLiteral(resourceName: "IBM-5"), IntroTitle: "Design Introduction", Text: "This is the media team in the studio. A group of crazy people with passion on design, and that’s why they call themselves  the color manics. There are more than 10 members working in different fields, and each of them has cross skills. That means they can backup each other and deliver in high efficiency.")]
    }
}

