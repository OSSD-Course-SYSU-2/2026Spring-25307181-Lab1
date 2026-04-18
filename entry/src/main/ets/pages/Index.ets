@Entry
@Component
struct Index {
  @State gachaResult: string = "点击按钮开始抽卡"
  @State resultColor: string = "#333333"
  @State historyList: string[] = []
  @State sinceLastFour: number = 0
  @State sinceLastFive: number = 0

  // 星星动画相关
  @State showStar: boolean = false
  @State starOffsetX: number = 0
  @State starOffsetY: number = -300
  @State starColor: string = "#FFFFFF"
  @State starText: string = "⭐"

  // 立绘弹窗相关
  @State showPortrait: boolean = false
  @State currentPortrait: string = ""
  @State currentCharName: string = ""

  // 十连动画相关
  @State isTenPullAnimating: boolean = false
  @State tenPullResults: string[] = []

  // 动画状态
  @State isAnimating: boolean = false
  @State darkOverlayVisible: boolean = false

  // 屏幕宽度
  private screenWidth: number = 360

  // 第一次十连保底五星标志（不显示给用户）
  private hasGuaranteedFive: boolean = true
  // 保底五星出现的位置（随机5-8）
  private guaranteedFiveIndex: number = -1

  // 卡池数据
  private fiveStarChars: string[] = ["刻晴", "迪卢克", "七七", "莫娜", "琴", "甘雨", "胡桃"]
  private fourStarChars: string[] = ["班尼特", "诺艾尔", "菲谢尔", "砂糖", "行秋", "重云", "香菱"]
  private threeStarItem: string = "⚔️ 飞天御剑 ⚔️"

  // 角色立绘映射
  private getPortraitPath(charName: string): string {
    let nameMap: Record<string, string> = {
      "刻晴": "keqing",
      "迪卢克": "diluc",
      "七七": "qiqi",
      "莫娜": "mona",
      "琴": "qin",
      "甘雨": "ganyu",
      "胡桃": "hutao"
    }
    let fileName = nameMap[charName]
    if (fileName) {
      return `app.media.${fileName}`
    }
    return ""
  }

  // 显示角色立绘弹窗
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

  // 核心抽卡逻辑（只返回结果，不显示立绘）
  private performGacha(isTenPull: boolean = false, isGuaranteedPos: boolean = false): string {
    // 如果是十连且到了保底位置，必出五星
    if (isTenPull && isGuaranteedPos && this.hasGuaranteedFive) {
      return this.getRandomFiveStarNoPortrait()
    }

    if (this.sinceLastFive >= 90) {
      return this.getRandomFiveStarNoPortrait()
    }
    if (this.sinceLastFour >= 10) {
      return this.getRandomFourStarNoPortrait()
    }

    let rand = Math.floor(Math.random() * 10000)
    if (rand < 60) {
      return this.getRandomFiveStarNoPortrait()
    } else if (rand < 660) {
      return this.getRandomFourStarNoPortrait()
    } else {
      return this.getThreeStarNoPortrait()
    }
  }

  private getRandomFiveStarNoPortrait(): string {
    let index = Math.floor(Math.random() * this.fiveStarChars.length)
    let char = this.fiveStarChars[index]
    this.sinceLastFive = 0
    this.sinceLastFour = 0
    return `★★★★★ ${char}`
  }

  private getRandomFourStarNoPortrait(): string {
    let index = Math.floor(Math.random() * this.fourStarChars.length)
    let char = this.fourStarChars[index]
    this.sinceLastFour = 0
    return `★★★★ ${char}`
  }

  private getThreeStarNoPortrait(): string {
    return `★★★ ${this.threeStarItem}`
  }

  // 获取稀有度对应的星星符号和颜色
  private getStarTextAndColor(result: string): string[] {
    if (result.includes("★★★★★")) {
      return ["⭐", "#FFD700"]
    } else if (result.includes("★★★★")) {
      return ["💜", "#9B59B6"]
    } else {
      return ["💙", "#4A90E2"]
    }
  }

  // 单抽
  private wishWithAnimation() {
    if (this.isAnimating) return

    this.isAnimating = true
    this.darkOverlayVisible = true

    this.sinceLastFour++
    this.sinceLastFive++

    let result = this.performGacha(false, false)
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

  // 显示单抽结果（动画结束后）
  private displayResult(result: string) {
    let isFiveStar = result.includes("★★★★★")
    let isFourStar = result.includes("★★★★")

    let starEmoji: string
    let color: string
    let displayResult: string = result

    if (isFiveStar) {
      let charName = result.replace("★★★★★ ", "")
      this.showCharacterPortrait(charName)
      starEmoji = "✨✨✨✨✨ 金光！！！ ✨✨✨✨✨"
      color = "#FFD700"
      displayResult = result.replace("★★★★★ ", "")
      this.gachaResult = `${starEmoji}\n★★★★★ ${displayResult}\n"我会保护你！"`
    } else if (isFourStar) {
      starEmoji = "💜💜💜 紫光 💜💜💜"
      color = "#9B59B6"
      displayResult = result.replace("★★★★ ", "")
      this.gachaResult = `${starEmoji}\n★★★★ ${displayResult}\n"感谢相遇！"`
    } else {
      starEmoji = "💙💙💙 蓝光 💙💙💙"
      color = "#4A90E2"
      displayResult = result.replace("★★★ ", "")
      this.gachaResult = `${starEmoji}\n★★★ ${displayResult}\n"下次一定！"`
    }

    this.resultColor = color
    this.historyList.unshift(result)
    if (this.historyList.length > 10) {
      this.historyList.pop()
    }
  }

  // 十连抽
  private wishTenWithAnimation() {
    if (this.isAnimating || this.isTenPullAnimating) return

    this.isTenPullAnimating = true
    this.isAnimating = true
    this.darkOverlayVisible = true

    let tempLastFour = this.sinceLastFour
    let tempLastFive = this.sinceLastFive
    let tempResults: string[] = []
    let tempStarTexts: string[] = []
    let tempStarColors: string[] = []

    // 如果是第一次十连，随机一个位置（3-8之间）出五星，看起来更自然
    let guaranteedPos = -1
    if (this.hasGuaranteedFive) {
      // 随机位置：3,4,5,6,7,8（避免第一发或最后一发）
      let positions = [3, 4, 5, 6, 7]
      let randomIndex = Math.floor(Math.random() * positions.length)
      guaranteedPos = positions[randomIndex]
      this.hasGuaranteedFive = false
    }

    for (let i = 0; i < 10; i++) {
      let currentFour = tempLastFour
      let currentFive = tempLastFive

      let result: string
      // 在指定位置出五星
      if (i === guaranteedPos) {
        let index = Math.floor(Math.random() * this.fiveStarChars.length)
        let char = this.fiveStarChars[index]
        result = `★★★★★ ${char}`
        tempLastFive = 0
        tempLastFour = 0
      } else if (currentFive >= 89) {
        let index = Math.floor(Math.random() * this.fiveStarChars.length)
        let char = this.fiveStarChars[index]
        result = `★★★★★ ${char}`
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
          let char = this.fiveStarChars[index]
          result = `★★★★★ ${char}`
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
      let starInfoArray = this.getStarTextAndColor(result)
      tempStarTexts.push(starInfoArray[0])
      tempStarColors.push(starInfoArray[1])
    }

    this.tenPullResults = tempResults
    this.showNextStar(0, tempResults, tempStarTexts, tempStarColors)
  }

  // 依次显示星星
  private showNextStar(index: number, results: string[], starTexts: string[], starColors: string[]) {
    if (index >= 10) {
      setTimeout(() => {
        this.finishTenPull(results)
      }, 500)
      return
    }

    this.starText = starTexts[index]
    this.starColor = starColors[index]
    this.showStar = true
    this.starOffsetX = (this.screenWidth / 2) - 32
    this.starOffsetY = -100

    let startTime = Date.now()
    let duration = 800
    let animateInterval = setInterval(() => {
      let elapsed = Date.now() - startTime
      let progress = Math.min(1, elapsed / duration)
      this.starOffsetY = -100 + (800 * progress)

      if (progress >= 1) {
        clearInterval(animateInterval)
        this.showStar = false
        setTimeout(() => {
          this.showNextStar(index + 1, results, starTexts, starColors)
        }, 200)
      }
    }, 16)
  }

  // 完成十连（动画结束后）
  private finishTenPull(results: string[]) {
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
    this.darkOverlayVisible = false

    // 十连结束后，依次显示五星立绘
    this.showPortraitsFromList(fiveStarChars, 0)
  }

  // 依次显示立绘
  private showPortraitsFromList(charNames: string[], index: number) {
    if (index >= charNames.length) return

    this.showCharacterPortrait(charNames[index])
    setTimeout(() => {
      this.showPortraitsFromList(charNames, index + 1)
    }, 2200)
  }

  // 重置游戏
  private resetGame() {
    if (this.isAnimating) return
    this.historyList = []
    this.sinceLastFour = 0
    this.sinceLastFive = 0
    this.hasGuaranteedFive = true
    this.gachaResult = "数据已重置，开始新的旅程吧"
    this.resultColor = "#333333"
    this.showStar = false
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

        Button("重置进度")
          .fontSize(14)
          .height(36)
          .width("40%")
          .backgroundColor("#909399")
          .borderRadius(18)
          .enabled(!this.isAnimating)
          .onClick(() => { this.resetGame() })
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#FFFFFF")
      .opacity(this.darkOverlayVisible ? 0.3 : 1)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.screenWidth = newValue.width as number
      })

      if (this.showStar) {
        Text(this.starText)
          .fontSize(64)
          .fontColor(this.starColor)
          .position({ x: this.starOffsetX, y: this.starOffsetY })
          .shadow({ radius: 30, color: this.starColor, offsetX: 0, offsetY: 0 })
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
        .onClick(() => {
          this.showPortrait = false
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}