//
//  ContentNews.swift
//  StudioApp
//
//  Created by user on 2018/12/20.
//  Copyright © 2018 ifundit. All rights reserved.
//

import Foundation
import UIKit
struct ContentNews {
    var newsTitle:String?
    var newsTime:String?
    var TopImage:UIImage?
    var Text:String?
    var newsIntro:String?
    
    init(newsTitle: String, newsTime: String, TopImage: UIImage,Text: String,newsIntro:String) {
        self.newsTime = newsTime
        self.TopImage = TopImage
        self.Text = Text
        self.newsTitle = newsTitle
        self.newsIntro = newsIntro
    }
}
extension ContentNews {
    static var data:[ContentNews]{
        return [ContentNews(newsTitle: "圣诞节", newsTime: "2018-12-07", TopImage: UIImage(named: "shengdanjie")!,  Text: "期盼已久的交换礼物活动马上到来啦，请准备好你的礼物包装好并放到studio的圣诞树下。\n活动的规则如下：1. 由Mohamed 开始抽取第一位，被抽到的同学上来挑选喜欢的礼物并当众拆开让其他人看看是什么。再由这位同学抽取下一位，以此类推，并把抽完的小纸条放到另外的一个箱子里。\n 2. 如果哪个还没有抽取礼物的同学，喜欢已抽过同学的礼物，你可以和他协商换取他的礼物，但是同时你将失去抽取礼物的机会了。\n3. 今年我们会抽取几个幸运儿，因为老板额外准备了一些礼物，我们会在当场的小伙伴中抽取这份幸运，但是前提是你需要一直参与到最后，抽完礼物你不在现场，我们会抽取下一位。\n同时在现场我们也准备了一些零食供大家享用，让我们一起happy起来吧！", newsIntro: "期盼已久的交换礼物活动马上到来啦，请准备好你的礼物包装好并放到studio的圣诞树下。"),
                ContentNews(newsTitle: "万圣节大趴等你来！", newsTime: "2018-10-26", TopImage:UIImage(named: "wanshengjie")!, Text: "万圣节🎃悄然而至，作为时髦的studio,岂能不一起狂欢呢\n!来吧，让我们行动起来，共同欢庆！\n时间： 10月26号 下午4点至6点\n地点：Studio\n 人物：就是你\n ** 真诚的邀请你的宝宝一起来玩耍，我们准备了吃的，玩的，还有帮你带孩子的** \n活动：详见26号\n备注：宝宝们自由装扮，大人们随意，因为你的美丽，由我帮忙 ：）",newsIntro:"万圣节🎃悄然而至，作为时髦的studio,岂能不一起狂欢呢!"),
                ContentNews(newsTitle: "IBM Studios Dalian Team Building", newsTime: "2018-06-08", TopImage: UIImage(named: "haibian")!, Text: "It is honor to work and live with you all in the past year. Thanks for your great support.\nFamily party is coming soon. please join us to spend a good time together.\nVenue: 星海湾浴场东湾沙滩 BBQ（浴场二号门进入，君悦酒店旁）\nDate: June 8\nTime: 3:00pm--8pm\nPlease attention:\n注意事项：\nPlease get your clients and Project Manager support to attend the team building. 请得到你的客户和项目经理对参加此次团建的支持。\nPlease work overtime to fulfill 8hrs on June 8 or take vacation in the afternoon. 请保证8小时的工作时间在6月8号当天，请采取晚上加班或者下午休假的原则。\nPlease drive or take a car from your friend to go to the beach. 请自行前往，开车或者坐同事车。\nPlease let me know if no car take you there. 请告知如果你没有找到车辆前往。\nPlease make sure your safety when you attend the activity. 请确保参加此次活动的安全性。\nThanks again!!\nCheers!",newsIntro:"IBM Studios Dalian Team Building on June 8"),
                ContentNews(newsTitle: "Watson", newsTime: "2018-06-08", TopImage: UIImage(named: "3")!, Text: "我们这里要展示的就是基于IBM认知技术和云平台的Watson Display。它是一个我们团队最近开发的虚拟的语音助手原型，这个原型和其他语音助手不同的是它使用了IBM Watson 技术，其中包括语音识别、自然语言处理和学习能力。最近几个月，我们每天和它一起，教它学习IBM 为不同行业打造的解决方案。",newsIntro:"waston"),
                ContentNews(newsTitle: "IOT", newsTime: "2018-06-08", TopImage: UIImage(named: "IBM-4")!, Text: "我们这个区域叫做物联网实验室，在这个实验室中，我们帮助客户进行各种基于Watson物联网技术的概念验证 。\n我们将展示2个机器人，这些机器人是采用的是更灵活的芯片级设备进行组装，相对于套机的机器人，我们可以有更灵活的控制，但同时也加大了整个开发的难度。机器人上的传感器主要涵盖了红外，超声，视频，边界等方面。我们的方案是通过Watson整合各种设备、元件，实现自动化认知物联解决方案。",newsIntro:"iot")]
    }
}
