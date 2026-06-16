@Entry
@Component
struct Index {
  @State gachaResult: string = "点击按钮开始抽卡"
  @State resultColor: string = "#333333"
  @State historyList: string[] = []
  @State sinceLastFour: number = 0
  @State sinceLastFive: number = 0

  // 星星动画相关（单抽用）
  @State showStar: boolean = false
  @State starOffsetX: number = 0
  @State starOffsetY: number = -300
  @State starColor: string = "#FFFFFF"
  @State starText: string = "⭐"

  // 立绘弹窗相关
  @State showPortrait: boolean = false
  @State currentPortrait: string = ""
  @State currentCharName: string = ""

  // 十连相关
  @State isTenPullAnimating: boolean = false
  @State tenPullResults: string[] = []
  @State showResultStars: boolean = false
  @State resultStarsList: string[] = []
  @State resultStarsColors: string[] = []

  // 视频播放相关
  @State showVideo: boolean = false
  @State videoSource: string = ""
  private videoController: VideoController = new VideoController()

  // 视频时长配置（根据你的视频修改）
  @State fourStarVideoDuration: number = 4000   // 四星视频4秒
  @State fiveStarVideoDuration: number = 6000   // 五星视频6秒

  // 动画状态
  @State isAnimating: boolean = false
  @State darkOverlayVisible: boolean = false

  // 屏幕宽度
  private screenWidth: number = 360

  // 第一次十连必出五星标志
  private hasGuaranteedFive: boolean = true

  // 卡池数据
  private fiveStarChars: string[] = ["刻晴", "迪卢克", "七七", "莫娜", "琴", "甘雨", "胡桃"]
  private fourStarChars: string[] = ["班尼特", "诺艾尔", "菲谢尔", "砂糖", "行秋", "重云", "香菱"]
  private threeStarItem: string = "⚔️ 飞天御剑 ⚔️"

  private getPortraitPath(charName: string): string {
    let nameMap: Record<string, string> = {
      "刻晴": "keqing", "迪卢克": "diluc", "七七": "qiqi",
      "莫娜": "mona", "琴": "qin", "甘雨": "ganyu", "胡桃": "hutao"
    }
    let fileName = nameMap[charName]
    if (fileName) {
      return `app.media.${fileName}`
    }
    return ""
  }

  private showCharacterPortrait(charName: string) {
    let portraitPath = this.getPortraitPath(charName)
    if (portraitPath) {
      this.currentCharName = charName
      this.currentPortrait = portraitPath
      this.showPortrait = true
      setTimeout(() => {
        this.showPortrait = false
      }, 2000)
    }
  }

  private performGacha(_isTenPull: boolean = false): string {
    if (this.sinceLastFive >= 90) {
      return this.getRandomFiveStar()
    }
    if (this.sinceLastFour >= 10) {
      return this.getRandomFourStar()
    }
    let rand = Math.floor(Math.random() * 10000)
    if (rand < 60) {
      return this.getRandomFiveStar()
    } else if (rand < 660) {
      return this.getRandomFourStar()
    } else {
      return this.getThreeStar()
    }
  }

  private getRandomFiveStar(): string {
    let index = Math.floor(Math.random() * this.fiveStarChars.length)
    let char = this.fiveStarChars[index]
    this.sinceLastFive = 0
    this.sinceLastFour = 0
    return `★★★★★ ${char}`
  }

  private getRandomFourStar(): string {
    let index = Math.floor(Math.random() * this.fourStarChars.length)
    let char = this.fourStarChars[index]
    this.sinceLastFour = 0
    return `★★★★ ${char}`
  }

  private getThreeStar(): string {
    return `★★★ ${this.threeStarItem}`
  }

  private getStarTextAndColor(result: string): string[] {
    if (result.includes("★★★★★")) {
      return ["⭐", "#FFD700"]
    } else if (result.includes("★★★★")) {
      return ["💜", "#9B59B6"]
    } else {
      return ["💙", "#4A90E2"]
    }
  }

  // ==================== 单抽 ====================
  private wishWithAnimation() {
    if (this.isAnimating) return
    this.isAnimating = true
    this.darkOverlayVisible = true
    this.sinceLastFour++
    this.sinceLastFive++
    let result = this.performGacha(false)
    let starInfoArray = this.getStarTextAndColor(result)
    this.starText = starInfoArray[0]
    this.starColor = starInfoArray[1]
    this.showStar = true
    this.starOffsetX = (this.screenWidth / 2) - 32
    this.starOffsetY = -100
    let startTime = Date.now()
    let duration = 1500
    let animateInterval = setInterval(() => {
      let elapsed = Date.now() - startTime
      let progress = Math.min(1, elapsed / duration)
      this.starOffsetY = -100 + (800 * progress)
      if (progress >= 1) {
        clearInterval(animateInterval)
        this.showStar = false
        this.darkOverlayVisible = false
        this.displayResult(result)
        this.isAnimating = false
      }
    }, 16)
  }

  private displayResult(result: string) {
    let isFiveStar = result.includes("★★★★★")
    let isFourStar = result.includes("★★★★")
    if (isFiveStar) {
      let charName = result.replace("★★★★★ ", "")
      this.showCharacterPortrait(charName)
      this.gachaResult = `✨✨✨✨✨ 金光！！！ ✨✨✨✨✨\n★★★★★ ${charName}\n"我会保护你！"`
      this.resultColor = "#FFD700"
    } else if (isFourStar) {
      this.gachaResult = `💜💜💜 紫光 💜💜💜\n${result}\n"感谢相遇！"`
      this.resultColor = "#9B59B6"
    } else {
      this.gachaResult = `💙💙💙 蓝光 💙💙💙\n${result}\n"下次一定！"`
      this.resultColor = "#4A90E2"
    }
    this.historyList.unshift(result)
    if (this.historyList.length > 10) {
      this.historyList.pop()
    }
  }
  // ==================== 十连 ====================
  private wishTenWithAnimation() {
    if (this.isAnimating || this.isTenPullAnimating) return
    this.isTenPullAnimating = true
    this.isAnimating = true
    this.darkOverlayVisible = true
    let tempLastFour = this.sinceLastFour
    let tempLastFive = this.sinceLastFive
    let tempResults: string[] = []
    let guaranteedPos = -1
    if (this.hasGuaranteedFive) {
      let positions = [3, 4, 5, 6, 7]
      let randomIndex = Math.floor(Math.random() * positions.length)
      guaranteedPos = positions[randomIndex]
      this.hasGuaranteedFive = false
    }
    for (let i = 0; i < 10; i++) {
      let currentFour = tempLastFour
      let currentFive = tempLastFive
      let result: string
      if (i === guaranteedPos) {
        let index = Math.floor(Math.random() * this.fiveStarChars.length)
        result = `★★★★★ ${this.fiveStarChars[index]}`
        tempLastFive = 0
        tempLastFour = 0
      } else if (currentFive >= 89) {
        let index = Math.floor(Math.random() * this.fiveStarChars.length)
        result = `★★★★★ ${this.fiveStarChars[index]}`
        tempLastFive = 0
        tempLastFour = 0
      } else if (currentFour >= 9) {
        let index = Math.floor(Math.random() * this.fourStarChars.length)
        result = `★★★★ ${this.fourStarChars[index]}`
        tempLastFour = 0
        tempLastFive++
      } else {
        let rand = Math.floor(Math.random() * 10000)
        if (rand < 60) {
          let index = Math.floor(Math.random() * this.fiveStarChars.length)
          result = `★★★★★ ${this.fiveStarChars[index]}`
          tempLastFive = 0
          tempLastFour = 0
        } else if (rand < 660) {
          let index = Math.floor(Math.random() * this.fourStarChars.length)
          result = `★★★★ ${this.fourStarChars[index]}`
          tempLastFour = 0
          tempLastFive++
        } else {
          result = `★★★ ${this.threeStarItem}`
          tempLastFour++
          tempLastFive++
        }
      }
      tempResults.push(result)
    }
    let hasFiveStar = tempResults.some(r => r.includes("★★★★★"))
    let starTexts: string[] = []
    let starColors: string[] = []
    for (let result of tempResults) {
      let info = this.getStarTextAndColor(result)
      starTexts.push(info[0])
      starColors.push(info[1])
    }
    this.resultStarsList = starTexts
    this.resultStarsColors = starColors
    this.tenPullResults = tempResults

    // 根据是否有五星选择视频和时长
    this.videoSource = hasFiveStar ? "five_star.mp4" : "four_star.mp4"
    let videoDuration = hasFiveStar ? this.fiveStarVideoDuration : this.fourStarVideoDuration

    this.showVideo = true
    setTimeout(() => {
      this.showVideo = false
      this.showResultStars = true
      this.darkOverlayVisible = false
    }, videoDuration)
  }

  private finishTenPull() {
    let results = this.tenPullResults
    let fiveStarCount = 0
    let fourStarCount = 0
    let fiveStarChars: string[] = []
    for (let result of results) {
      if (result.includes("★★★★★")) {
        fiveStarCount++
        let charName = result.replace("★★★★★ ", "")
        fiveStarChars.push(charName)
      } else if (result.includes("★★★★")) {
        fourStarCount++
      }
      this.historyList.unshift(result)
    }
    while (this.historyList.length > 10) {
      this.historyList.pop()
    }
    for (let i = 0; i < 10; i++) {
      let result = results[i]
      if (result.includes("★★★★★")) {
        this.sinceLastFive = 0
        this.sinceLastFour = 0
      } else if (result.includes("★★★★")) {
        this.sinceLastFour = 0
        this.sinceLastFive++
      } else {
        this.sinceLastFour++
        this.sinceLastFive++
      }
    }
    let summary = `🎉 【十连抽汇总】 🎉\n`
    summary += `⭐ 五星: ${fiveStarCount} 个\n`
    summary += `💜 四星: ${fourStarCount} 个\n`
    summary += `💙 三星: ${10 - fiveStarCount - fourStarCount} 个\n`
    summary += `━━━━━━━━━━━━━━\n`
    for (let item of results) {
      summary += item + "\n"
    }
    this.gachaResult = summary
    this.resultColor = "#333333"
    this.isTenPullAnimating = false
    this.isAnimating = false
    this.showResultStars = false
    this.showPortraitsFromList(fiveStarChars, 0)
  }

  private showPortraitsFromList(charNames: string[], index: number) {
    if (index >= charNames.length) return
    this.showCharacterPortrait(charNames[index])
    setTimeout(() => {
      this.showPortraitsFromList(charNames, index + 1)
    }, 2200)
  }

  private onStarsClicked() {
    this.finishTenPull()
  }

  private resetGame() {
    if (this.isAnimating) return
    this.historyList = []
    this.sinceLastFour = 0
    this.sinceLastFive = 0
    this.hasGuaranteedFive = true
    this.gachaResult = "数据已重置，开始新的旅程吧"
    this.resultColor = "#333333"
    this.showStar = false
    this.showVideo = false
    this.showResultStars = false
    this.isTenPullAnimating = false
    this.isAnimating = false
    this.darkOverlayVisible = false
    this.showPortrait = false
  }

  build() {
    Stack() {
      Column() {
        Text("原神抽卡模拟器")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#E6A23C")
          .margin({ top: 30, bottom: 10 })

        Text(`距上次四星: ${this.sinceLastFour} / 10 | 距上次五星: ${this.sinceLastFive} / 90`)
          .fontSize(12)
          .fontColor("#909399")
          .margin({ bottom: 10 })

        Column() {
          Text(this.gachaResult)
            .fontSize(16)
            .fontColor(this.resultColor)
            .textAlign(TextAlign.Center)
            .padding(20)
        }
        .width("90%")
        .backgroundColor("#F5F5F5")
        .borderRadius(16)
        .margin({ bottom: 15 })

        Row() {
          Button("✨ 单抽")
            .fontSize(18)
            .height(44)
            .layoutWeight(1)
            .backgroundColor("#E6A23C")
            .borderRadius(22)
            .enabled(!this.isAnimating)
            .onClick(() => { this.wishWithAnimation() })

          Button("🎲 十连")
            .fontSize(18)
            .height(44)
            .layoutWeight(1)
            .backgroundColor("#66B1FF")
            .borderRadius(22)
            .margin({ left: 20 })
            .enabled(!this.isAnimating)
            .onClick(() => { this.wishTenWithAnimation() })
        }
        .width("80%")
        .margin({ bottom: 20 })

        Text("抽卡历史（最近10次）")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: 20 })

        List() {
          ForEach(this.historyList, (item: string) => {
            ListItem() {
              Text(item)
                .fontSize(13)
                .padding(6)
                .width("100%")
                .textAlign(TextAlign.Center)
                .fontColor(item.includes("★★★★★") ? "#FFD700" : (item.includes("★★★★") ? "#9B59B6" : "#4A90E2"))
            }
          })
        }
        .height(180)
        .width("90%")
        .backgroundColor("#FAFAFA")
        .borderRadius(12)
        .margin({ bottom: 15 })

        Row() {
          Button("重置进度")
            .fontSize(14)
            .height(36)
            .layoutWeight(1)
            .backgroundColor("#909399")
            .borderRadius(18)
            .enabled(!this.isAnimating)
            .onClick(() => { this.resetGame() })
        }
        .width("80%")
        .margin({ bottom: 20 })
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#FFFFFF")
      .opacity(this.darkOverlayVisible ? 0.3 : 1)
      .onAreaChange((_oldValue: Area, newValue: Area) => {
        this.screenWidth = newValue.width as number
      })

      if (this.showStar) {
        Text(this.starText)
          .fontSize(64)
          .fontColor(this.starColor)
          .position({ x: this.starOffsetX, y: this.starOffsetY })
          .shadow({ radius: 30, color: this.starColor, offsetX: 0, offsetY: 0 })
      }

      if (this.showResultStars) {
        Column() {
          Text("✨ 十连结果 ✨")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          Column() {
            Row() {
              ForEach([0, 1, 2, 3, 4], (i: number) => {
                if (i < this.resultStarsList.length) {
                  Text(this.resultStarsList[i])
                    .fontSize(40)
                    .fontColor(this.resultStarsColors[i])
                    .margin({ left: 10, right: 10 })
                }
              })
            }
            .justifyContent(FlexAlign.Center)
            .margin({ bottom: 15 })
            Row() {
              ForEach([5, 6, 7, 8, 9], (i: number) => {
                if (i < this.resultStarsList.length) {
                  Text(this.resultStarsList[i])
                    .fontSize(40)
                    .fontColor(this.resultStarsColors[i])
                    .margin({ left: 10, right: 10 })
                }
              })
            }
            .justifyContent(FlexAlign.Center)
          }
          Button("查看详情")
            .fontSize(16)
            .height(44)
            .width("60%")
            .backgroundColor("#66B1FF")
            .borderRadius(22)
            .margin({ top: 30 })
            .onClick(() => { this.onStarsClicked() })
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor("rgba(0,0,0,0.85)")
        .onClick(() => { this.onStarsClicked() })
      }

      if (this.showVideo) {
        Stack() {
          Video({
            src: $rawfile(this.videoSource),
            controller: this.videoController
          })
            .width("100%")
            .height("100%")
            .autoPlay(true)
            .controls(false)
            .objectFit(ImageFit.Contain)
        }
        .width("100%")
        .height("100%")
        .backgroundColor("#000000")
      }

      if (this.showPortrait && this.currentPortrait) {
        Column() {
          Column() {
            Image($r(this.currentPortrait))
              .width(200)
              .height(200)
              .objectFit(ImageFit.Contain)
              .borderRadius(20)
            Text(this.currentCharName)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#FFD700")
              .margin({ top: 10 })
            Text("★★★★★")
              .fontSize(16)
              .fontColor("#FFD700")
              .margin({ top: 5 })
          }
          .padding(20)
          .backgroundColor("rgba(0,0,0,0.85)")
          .borderRadius(30)
          .border({ width: 2, color: "#FFD700" })
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor("rgba(0,0,0,0.7)")
        .onClick(() => { this.showPortrait = false })
      }
    }
    .width("100%")
    .height("100%")
  }
}
