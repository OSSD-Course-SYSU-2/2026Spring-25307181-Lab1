if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Index_Params {
    gachaResult?: string;
    resultColor?: string;
    historyList?: string[];
    sinceLastFour?: number;
    sinceLastFive?: number;
    showStar?: boolean;
    starOffsetX?: number;
    starOffsetY?: number;
    starColor?: string;
    starText?: string;
    showPortrait?: boolean;
    currentPortrait?: string;
    currentCharName?: string;
    isTenPullAnimating?: boolean;
    tenPullResults?: string[];
    isAnimating?: boolean;
    darkOverlayVisible?: boolean;
    screenWidth?: number;
    hasGuaranteedFive?: boolean;
    guaranteedFiveIndex?: number;
    fiveStarChars?: string[];
    fourStarChars?: string[];
    threeStarItem?: string;
}
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__gachaResult = new ObservedPropertySimplePU("点击按钮开始抽卡", this, "gachaResult");
        this.__resultColor = new ObservedPropertySimplePU("#333333", this, "resultColor");
        this.__historyList = new ObservedPropertyObjectPU([], this, "historyList");
        this.__sinceLastFour = new ObservedPropertySimplePU(0, this, "sinceLastFour");
        this.__sinceLastFive = new ObservedPropertySimplePU(0
        // 星星动画相关
        , this, "sinceLastFive");
        this.__showStar = new ObservedPropertySimplePU(false, this, "showStar");
        this.__starOffsetX = new ObservedPropertySimplePU(0, this, "starOffsetX");
        this.__starOffsetY = new ObservedPropertySimplePU(-300, this, "starOffsetY");
        this.__starColor = new ObservedPropertySimplePU("#FFFFFF", this, "starColor");
        this.__starText = new ObservedPropertySimplePU("⭐"
        // 立绘弹窗相关
        , this, "starText");
        this.__showPortrait = new ObservedPropertySimplePU(false, this, "showPortrait");
        this.__currentPortrait = new ObservedPropertySimplePU("", this, "currentPortrait");
        this.__currentCharName = new ObservedPropertySimplePU(""
        // 十连动画相关
        , this, "currentCharName");
        this.__isTenPullAnimating = new ObservedPropertySimplePU(false, this, "isTenPullAnimating");
        this.__tenPullResults = new ObservedPropertyObjectPU([]
        // 动画状态
        , this, "tenPullResults");
        this.__isAnimating = new ObservedPropertySimplePU(false, this, "isAnimating");
        this.__darkOverlayVisible = new ObservedPropertySimplePU(false
        // 屏幕宽度
        , this, "darkOverlayVisible");
        this.screenWidth = 360;
        this.hasGuaranteedFive = true;
        this.guaranteedFiveIndex = -1;
        this.fiveStarChars = ["刻晴", "迪卢克", "七七", "莫娜", "琴", "甘雨", "胡桃"];
        this.fourStarChars = ["班尼特", "诺艾尔", "菲谢尔", "砂糖", "行秋", "重云", "香菱"];
        this.threeStarItem = "⚔️ 飞天御剑 ⚔️";
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Index_Params) {
        if (params.gachaResult !== undefined) {
            this.gachaResult = params.gachaResult;
        }
        if (params.resultColor !== undefined) {
            this.resultColor = params.resultColor;
        }
        if (params.historyList !== undefined) {
            this.historyList = params.historyList;
        }
        if (params.sinceLastFour !== undefined) {
            this.sinceLastFour = params.sinceLastFour;
        }
        if (params.sinceLastFive !== undefined) {
            this.sinceLastFive = params.sinceLastFive;
        }
        if (params.showStar !== undefined) {
            this.showStar = params.showStar;
        }
        if (params.starOffsetX !== undefined) {
            this.starOffsetX = params.starOffsetX;
        }
        if (params.starOffsetY !== undefined) {
            this.starOffsetY = params.starOffsetY;
        }
        if (params.starColor !== undefined) {
            this.starColor = params.starColor;
        }
        if (params.starText !== undefined) {
            this.starText = params.starText;
        }
        if (params.showPortrait !== undefined) {
            this.showPortrait = params.showPortrait;
        }
        if (params.currentPortrait !== undefined) {
            this.currentPortrait = params.currentPortrait;
        }
        if (params.currentCharName !== undefined) {
            this.currentCharName = params.currentCharName;
        }
        if (params.isTenPullAnimating !== undefined) {
            this.isTenPullAnimating = params.isTenPullAnimating;
        }
        if (params.tenPullResults !== undefined) {
            this.tenPullResults = params.tenPullResults;
        }
        if (params.isAnimating !== undefined) {
            this.isAnimating = params.isAnimating;
        }
        if (params.darkOverlayVisible !== undefined) {
            this.darkOverlayVisible = params.darkOverlayVisible;
        }
        if (params.screenWidth !== undefined) {
            this.screenWidth = params.screenWidth;
        }
        if (params.hasGuaranteedFive !== undefined) {
            this.hasGuaranteedFive = params.hasGuaranteedFive;
        }
        if (params.guaranteedFiveIndex !== undefined) {
            this.guaranteedFiveIndex = params.guaranteedFiveIndex;
        }
        if (params.fiveStarChars !== undefined) {
            this.fiveStarChars = params.fiveStarChars;
        }
        if (params.fourStarChars !== undefined) {
            this.fourStarChars = params.fourStarChars;
        }
        if (params.threeStarItem !== undefined) {
            this.threeStarItem = params.threeStarItem;
        }
    }
    updateStateVars(params: Index_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__gachaResult.purgeDependencyOnElmtId(rmElmtId);
        this.__resultColor.purgeDependencyOnElmtId(rmElmtId);
        this.__historyList.purgeDependencyOnElmtId(rmElmtId);
        this.__sinceLastFour.purgeDependencyOnElmtId(rmElmtId);
        this.__sinceLastFive.purgeDependencyOnElmtId(rmElmtId);
        this.__showStar.purgeDependencyOnElmtId(rmElmtId);
        this.__starOffsetX.purgeDependencyOnElmtId(rmElmtId);
        this.__starOffsetY.purgeDependencyOnElmtId(rmElmtId);
        this.__starColor.purgeDependencyOnElmtId(rmElmtId);
        this.__starText.purgeDependencyOnElmtId(rmElmtId);
        this.__showPortrait.purgeDependencyOnElmtId(rmElmtId);
        this.__currentPortrait.purgeDependencyOnElmtId(rmElmtId);
        this.__currentCharName.purgeDependencyOnElmtId(rmElmtId);
        this.__isTenPullAnimating.purgeDependencyOnElmtId(rmElmtId);
        this.__tenPullResults.purgeDependencyOnElmtId(rmElmtId);
        this.__isAnimating.purgeDependencyOnElmtId(rmElmtId);
        this.__darkOverlayVisible.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__gachaResult.aboutToBeDeleted();
        this.__resultColor.aboutToBeDeleted();
        this.__historyList.aboutToBeDeleted();
        this.__sinceLastFour.aboutToBeDeleted();
        this.__sinceLastFive.aboutToBeDeleted();
        this.__showStar.aboutToBeDeleted();
        this.__starOffsetX.aboutToBeDeleted();
        this.__starOffsetY.aboutToBeDeleted();
        this.__starColor.aboutToBeDeleted();
        this.__starText.aboutToBeDeleted();
        this.__showPortrait.aboutToBeDeleted();
        this.__currentPortrait.aboutToBeDeleted();
        this.__currentCharName.aboutToBeDeleted();
        this.__isTenPullAnimating.aboutToBeDeleted();
        this.__tenPullResults.aboutToBeDeleted();
        this.__isAnimating.aboutToBeDeleted();
        this.__darkOverlayVisible.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __gachaResult: ObservedPropertySimplePU<string>;
    get gachaResult() {
        return this.__gachaResult.get();
    }
    set gachaResult(newValue: string) {
        this.__gachaResult.set(newValue);
    }
    private __resultColor: ObservedPropertySimplePU<string>;
    get resultColor() {
        return this.__resultColor.get();
    }
    set resultColor(newValue: string) {
        this.__resultColor.set(newValue);
    }
    private __historyList: ObservedPropertyObjectPU<string[]>;
    get historyList() {
        return this.__historyList.get();
    }
    set historyList(newValue: string[]) {
        this.__historyList.set(newValue);
    }
    private __sinceLastFour: ObservedPropertySimplePU<number>;
    get sinceLastFour() {
        return this.__sinceLastFour.get();
    }
    set sinceLastFour(newValue: number) {
        this.__sinceLastFour.set(newValue);
    }
    private __sinceLastFive: ObservedPropertySimplePU<number>;
    get sinceLastFive() {
        return this.__sinceLastFive.get();
    }
    set sinceLastFive(newValue: number) {
        this.__sinceLastFive.set(newValue);
    }
    // 星星动画相关
    private __showStar: ObservedPropertySimplePU<boolean>;
    get showStar() {
        return this.__showStar.get();
    }
    set showStar(newValue: boolean) {
        this.__showStar.set(newValue);
    }
    private __starOffsetX: ObservedPropertySimplePU<number>;
    get starOffsetX() {
        return this.__starOffsetX.get();
    }
    set starOffsetX(newValue: number) {
        this.__starOffsetX.set(newValue);
    }
    private __starOffsetY: ObservedPropertySimplePU<number>;
    get starOffsetY() {
        return this.__starOffsetY.get();
    }
    set starOffsetY(newValue: number) {
        this.__starOffsetY.set(newValue);
    }
    private __starColor: ObservedPropertySimplePU<string>;
    get starColor() {
        return this.__starColor.get();
    }
    set starColor(newValue: string) {
        this.__starColor.set(newValue);
    }
    private __starText: ObservedPropertySimplePU<string>;
    get starText() {
        return this.__starText.get();
    }
    set starText(newValue: string) {
        this.__starText.set(newValue);
    }
    // 立绘弹窗相关
    private __showPortrait: ObservedPropertySimplePU<boolean>;
    get showPortrait() {
        return this.__showPortrait.get();
    }
    set showPortrait(newValue: boolean) {
        this.__showPortrait.set(newValue);
    }
    private __currentPortrait: ObservedPropertySimplePU<string>;
    get currentPortrait() {
        return this.__currentPortrait.get();
    }
    set currentPortrait(newValue: string) {
        this.__currentPortrait.set(newValue);
    }
    private __currentCharName: ObservedPropertySimplePU<string>;
    get currentCharName() {
        return this.__currentCharName.get();
    }
    set currentCharName(newValue: string) {
        this.__currentCharName.set(newValue);
    }
    // 十连动画相关
    private __isTenPullAnimating: ObservedPropertySimplePU<boolean>;
    get isTenPullAnimating() {
        return this.__isTenPullAnimating.get();
    }
    set isTenPullAnimating(newValue: boolean) {
        this.__isTenPullAnimating.set(newValue);
    }
    private __tenPullResults: ObservedPropertyObjectPU<string[]>;
    get tenPullResults() {
        return this.__tenPullResults.get();
    }
    set tenPullResults(newValue: string[]) {
        this.__tenPullResults.set(newValue);
    }
    // 动画状态
    private __isAnimating: ObservedPropertySimplePU<boolean>;
    get isAnimating() {
        return this.__isAnimating.get();
    }
    set isAnimating(newValue: boolean) {
        this.__isAnimating.set(newValue);
    }
    private __darkOverlayVisible: ObservedPropertySimplePU<boolean>;
    get darkOverlayVisible() {
        return this.__darkOverlayVisible.get();
    }
    set darkOverlayVisible(newValue: boolean) {
        this.__darkOverlayVisible.set(newValue);
    }
    // 屏幕宽度
    private screenWidth: number;
    // 第一次十连保底五星标志（不显示给用户）
    private hasGuaranteedFive: boolean;
    // 保底五星出现的位置（随机5-8）
    private guaranteedFiveIndex: number;
    // 卡池数据
    private fiveStarChars: string[];
    private fourStarChars: string[];
    private threeStarItem: string;
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
        };
        let fileName = nameMap[charName];
        if (fileName) {
            return `app.media.${fileName}`;
        }
        return "";
    }
    // 显示角色立绘弹窗
    private showCharacterPortrait(charName: string) {
        let portraitPath = this.getPortraitPath(charName);
        if (portraitPath) {
            this.currentCharName = charName;
            this.currentPortrait = portraitPath;
            this.showPortrait = true;
            setTimeout(() => {
                this.showPortrait = false;
            }, 2000);
        }
    }
    // 核心抽卡逻辑（只返回结果，不显示立绘）
    private performGacha(isTenPull: boolean = false, isGuaranteedPos: boolean = false): string {
        // 如果是十连且到了保底位置，必出五星
        if (isTenPull && isGuaranteedPos && this.hasGuaranteedFive) {
            return this.getRandomFiveStarNoPortrait();
        }
        if (this.sinceLastFive >= 90) {
            return this.getRandomFiveStarNoPortrait();
        }
        if (this.sinceLastFour >= 10) {
            return this.getRandomFourStarNoPortrait();
        }
        let rand = Math.floor(Math.random() * 10000);
        if (rand < 60) {
            return this.getRandomFiveStarNoPortrait();
        }
        else if (rand < 660) {
            return this.getRandomFourStarNoPortrait();
        }
        else {
            return this.getThreeStarNoPortrait();
        }
    }
    private getRandomFiveStarNoPortrait(): string {
        let index = Math.floor(Math.random() * this.fiveStarChars.length);
        let char = this.fiveStarChars[index];
        this.sinceLastFive = 0;
        this.sinceLastFour = 0;
        return `★★★★★ ${char}`;
    }
    private getRandomFourStarNoPortrait(): string {
        let index = Math.floor(Math.random() * this.fourStarChars.length);
        let char = this.fourStarChars[index];
        this.sinceLastFour = 0;
        return `★★★★ ${char}`;
    }
    private getThreeStarNoPortrait(): string {
        return `★★★ ${this.threeStarItem}`;
    }
    // 获取稀有度对应的星星符号和颜色
    private getStarTextAndColor(result: string): string[] {
        if (result.includes("★★★★★")) {
            return ["⭐", "#FFD700"];
        }
        else if (result.includes("★★★★")) {
            return ["💜", "#9B59B6"];
        }
        else {
            return ["💙", "#4A90E2"];
        }
    }
    // 单抽
    private wishWithAnimation() {
        if (this.isAnimating)
            return;
        this.isAnimating = true;
        this.darkOverlayVisible = true;
        this.sinceLastFour++;
        this.sinceLastFive++;
        let result = this.performGacha(false, false);
        let starInfoArray = this.getStarTextAndColor(result);
        this.starText = starInfoArray[0];
        this.starColor = starInfoArray[1];
        this.showStar = true;
        this.starOffsetX = (this.screenWidth / 2) - 32;
        this.starOffsetY = -100;
        let startTime = Date.now();
        let duration = 1500;
        let animateInterval = setInterval(() => {
            let elapsed = Date.now() - startTime;
            let progress = Math.min(1, elapsed / duration);
            this.starOffsetY = -100 + (800 * progress);
            if (progress >= 1) {
                clearInterval(animateInterval);
                this.showStar = false;
                this.darkOverlayVisible = false;
                this.displayResult(result);
                this.isAnimating = false;
            }
        }, 16);
    }
    // 显示单抽结果（动画结束后）
    private displayResult(result: string) {
        let isFiveStar = result.includes("★★★★★");
        let isFourStar = result.includes("★★★★");
        let starEmoji: string;
        let color: string;
        let displayResult: string = result;
        if (isFiveStar) {
            let charName = result.replace("★★★★★ ", "");
            this.showCharacterPortrait(charName);
            starEmoji = "✨✨✨✨✨ 金光！！！ ✨✨✨✨✨";
            color = "#FFD700";
            displayResult = result.replace("★★★★★ ", "");
            this.gachaResult = `${starEmoji}\n★★★★★ ${displayResult}\n"我会保护你！"`;
        }
        else if (isFourStar) {
            starEmoji = "💜💜💜 紫光 💜💜💜";
            color = "#9B59B6";
            displayResult = result.replace("★★★★ ", "");
            this.gachaResult = `${starEmoji}\n★★★★ ${displayResult}\n"感谢相遇！"`;
        }
        else {
            starEmoji = "💙💙💙 蓝光 💙💙💙";
            color = "#4A90E2";
            displayResult = result.replace("★★★ ", "");
            this.gachaResult = `${starEmoji}\n★★★ ${displayResult}\n"下次一定！"`;
        }
        this.resultColor = color;
        this.historyList.unshift(result);
        if (this.historyList.length > 10) {
            this.historyList.pop();
        }
    }
    // 十连抽
    private wishTenWithAnimation() {
        if (this.isAnimating || this.isTenPullAnimating)
            return;
        this.isTenPullAnimating = true;
        this.isAnimating = true;
        this.darkOverlayVisible = true;
        let tempLastFour = this.sinceLastFour;
        let tempLastFive = this.sinceLastFive;
        let tempResults: string[] = [];
        let tempStarTexts: string[] = [];
        let tempStarColors: string[] = [];
        // 如果是第一次十连，随机一个位置（3-8之间）出五星，看起来更自然
        let guaranteedPos = -1;
        if (this.hasGuaranteedFive) {
            // 随机位置：3,4,5,6,7,8（避免第一发或最后一发）
            let positions = [3, 4, 5, 6, 7];
            let randomIndex = Math.floor(Math.random() * positions.length);
            guaranteedPos = positions[randomIndex];
            this.hasGuaranteedFive = false;
        }
        for (let i = 0; i < 10; i++) {
            let currentFour = tempLastFour;
            let currentFive = tempLastFive;
            let result: string;
            // 在指定位置出五星
            if (i === guaranteedPos) {
                let index = Math.floor(Math.random() * this.fiveStarChars.length);
                let char = this.fiveStarChars[index];
                result = `★★★★★ ${char}`;
                tempLastFive = 0;
                tempLastFour = 0;
            }
            else if (currentFive >= 89) {
                let index = Math.floor(Math.random() * this.fiveStarChars.length);
                let char = this.fiveStarChars[index];
                result = `★★★★★ ${char}`;
                tempLastFive = 0;
                tempLastFour = 0;
            }
            else if (currentFour >= 9) {
                let index = Math.floor(Math.random() * this.fourStarChars.length);
                result = `★★★★ ${this.fourStarChars[index]}`;
                tempLastFour = 0;
                tempLastFive++;
            }
            else {
                let rand = Math.floor(Math.random() * 10000);
                if (rand < 60) {
                    let index = Math.floor(Math.random() * this.fiveStarChars.length);
                    let char = this.fiveStarChars[index];
                    result = `★★★★★ ${char}`;
                    tempLastFive = 0;
                    tempLastFour = 0;
                }
                else if (rand < 660) {
                    let index = Math.floor(Math.random() * this.fourStarChars.length);
                    result = `★★★★ ${this.fourStarChars[index]}`;
                    tempLastFour = 0;
                    tempLastFive++;
                }
                else {
                    result = `★★★ ${this.threeStarItem}`;
                    tempLastFour++;
                    tempLastFive++;
                }
            }
            tempResults.push(result);
            let starInfoArray = this.getStarTextAndColor(result);
            tempStarTexts.push(starInfoArray[0]);
            tempStarColors.push(starInfoArray[1]);
        }
        this.tenPullResults = tempResults;
        this.showNextStar(0, tempResults, tempStarTexts, tempStarColors);
    }
    // 依次显示星星
    private showNextStar(index: number, results: string[], starTexts: string[], starColors: string[]) {
        if (index >= 10) {
            setTimeout(() => {
                this.finishTenPull(results);
            }, 500);
            return;
        }
        this.starText = starTexts[index];
        this.starColor = starColors[index];
        this.showStar = true;
        this.starOffsetX = (this.screenWidth / 2) - 32;
        this.starOffsetY = -100;
        let startTime = Date.now();
        let duration = 800;
        let animateInterval = setInterval(() => {
            let elapsed = Date.now() - startTime;
            let progress = Math.min(1, elapsed / duration);
            this.starOffsetY = -100 + (800 * progress);
            if (progress >= 1) {
                clearInterval(animateInterval);
                this.showStar = false;
                setTimeout(() => {
                    this.showNextStar(index + 1, results, starTexts, starColors);
                }, 200);
            }
        }, 16);
    }
    // 完成十连（动画结束后）
    private finishTenPull(results: string[]) {
        let fiveStarCount = 0;
        let fourStarCount = 0;
        let fiveStarChars: string[] = [];
        for (let result of results) {
            if (result.includes("★★★★★")) {
                fiveStarCount++;
                let charName = result.replace("★★★★★ ", "");
                fiveStarChars.push(charName);
            }
            else if (result.includes("★★★★")) {
                fourStarCount++;
            }
            this.historyList.unshift(result);
        }
        while (this.historyList.length > 10) {
            this.historyList.pop();
        }
        for (let i = 0; i < 10; i++) {
            let result = results[i];
            if (result.includes("★★★★★")) {
                this.sinceLastFive = 0;
                this.sinceLastFour = 0;
            }
            else if (result.includes("★★★★")) {
                this.sinceLastFour = 0;
                this.sinceLastFive++;
            }
            else {
                this.sinceLastFour++;
                this.sinceLastFive++;
            }
        }
        let summary = `🎉 【十连抽汇总】 🎉\n`;
        summary += `⭐ 五星: ${fiveStarCount} 个\n`;
        summary += `💜 四星: ${fourStarCount} 个\n`;
        summary += `💙 三星: ${10 - fiveStarCount - fourStarCount} 个\n`;
        summary += `━━━━━━━━━━━━━━\n`;
        for (let item of results) {
            summary += item + "\n";
        }
        this.gachaResult = summary;
        this.resultColor = "#333333";
        this.isTenPullAnimating = false;
        this.isAnimating = false;
        this.darkOverlayVisible = false;
        // 十连结束后，依次显示五星立绘
        this.showPortraitsFromList(fiveStarChars, 0);
    }
    // 依次显示立绘
    private showPortraitsFromList(charNames: string[], index: number) {
        if (index >= charNames.length)
            return;
        this.showCharacterPortrait(charNames[index]);
        setTimeout(() => {
            this.showPortraitsFromList(charNames, index + 1);
        }, 2200);
    }
    // 重置游戏
    private resetGame() {
        if (this.isAnimating)
            return;
        this.historyList = [];
        this.sinceLastFour = 0;
        this.sinceLastFive = 0;
        this.hasGuaranteedFive = true;
        this.gachaResult = "数据已重置，开始新的旅程吧";
        this.resultColor = "#333333";
        this.showStar = false;
        this.isTenPullAnimating = false;
        this.isAnimating = false;
        this.darkOverlayVisible = false;
        this.showPortrait = false;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.width("100%");
            Stack.height("100%");
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width("100%");
            Column.height("100%");
            Column.backgroundColor("#FFFFFF");
            Column.opacity(this.darkOverlayVisible ? 0.3 : 1);
            Column.onAreaChange((oldValue: Area, newValue: Area) => {
                this.screenWidth = newValue.width as number;
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create("原神抽卡模拟器");
            Text.fontSize(28);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor("#E6A23C");
            Text.margin({ top: 30, bottom: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`距上次四星: ${this.sinceLastFour} / 10 | 距上次五星: ${this.sinceLastFive} / 90`);
            Text.fontSize(12);
            Text.fontColor("#909399");
            Text.margin({ bottom: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width("90%");
            Column.backgroundColor("#F5F5F5");
            Column.borderRadius(16);
            Column.margin({ bottom: 15 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.gachaResult);
            Text.fontSize(16);
            Text.fontColor(this.resultColor);
            Text.textAlign(TextAlign.Center);
            Text.padding(20);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width("80%");
            Row.margin({ bottom: 20 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel("✨ 单抽");
            Button.fontSize(18);
            Button.height(44);
            Button.layoutWeight(1);
            Button.backgroundColor("#E6A23C");
            Button.borderRadius(22);
            Button.enabled(!this.isAnimating);
            Button.onClick(() => { this.wishWithAnimation(); });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel("🎲 十连");
            Button.fontSize(18);
            Button.height(44);
            Button.layoutWeight(1);
            Button.backgroundColor("#66B1FF");
            Button.borderRadius(22);
            Button.margin({ left: 20 });
            Button.enabled(!this.isAnimating);
            Button.onClick(() => { this.wishTenWithAnimation(); });
        }, Button);
        Button.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create("抽卡历史（最近10次）");
            Text.fontSize(14);
            Text.fontWeight(FontWeight.Medium);
            Text.margin({ bottom: 8 });
            Text.alignSelf(ItemAlign.Start);
            Text.margin({ left: 20 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
            List.height(180);
            List.width("90%");
            List.backgroundColor("#FAFAFA");
            List.borderRadius(12);
            List.margin({ bottom: 15 });
        }, List);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                {
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ListItem.create(deepRenderFunction, true);
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(deepRenderFunction, true);
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item);
                            Text.fontSize(13);
                            Text.padding(6);
                            Text.width("100%");
                            Text.textAlign(TextAlign.Center);
                            Text.fontColor(item.includes("★★★★★") ? "#FFD700" : (item.includes("★★★★") ? "#9B59B6" : "#4A90E2"));
                        }, Text);
                        Text.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.historyList, forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel("重置进度");
            Button.fontSize(14);
            Button.height(36);
            Button.width("40%");
            Button.backgroundColor("#909399");
            Button.borderRadius(18);
            Button.enabled(!this.isAnimating);
            Button.onClick(() => { this.resetGame(); });
        }, Button);
        Button.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.showStar) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.starText);
                        Text.fontSize(64);
                        Text.fontColor(this.starColor);
                        Text.position({ x: this.starOffsetX, y: this.starOffsetY });
                        Text.shadow({ radius: 30, color: this.starColor, offsetX: 0, offsetY: 0 });
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.showPortrait && this.currentPortrait) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.width("100%");
                        Column.height("100%");
                        Column.justifyContent(FlexAlign.Center);
                        Column.alignItems(HorizontalAlign.Center);
                        Column.backgroundColor("rgba(0,0,0,0.7)");
                        Column.onClick(() => {
                            this.showPortrait = false;
                        });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.padding(20);
                        Column.backgroundColor("rgba(0,0,0,0.85)");
                        Column.borderRadius(30);
                        Column.border({ width: 2, color: "#FFD700" });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ get id() {
                                return typeof __getResourceId__ === "function" ? __getResourceId__(this) : -1;
                            }, "type": -1, params: [this.currentPortrait], "bundleName": "com.example.genshin_impact_wish_simulator", "moduleName": "entry" });
                        Image.width(200);
                        Image.height(200);
                        Image.objectFit(ImageFit.Contain);
                        Image.borderRadius(20);
                    }, Image);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.currentCharName);
                        Text.fontSize(20);
                        Text.fontWeight(FontWeight.Bold);
                        Text.fontColor("#FFD700");
                        Text.margin({ top: 10 });
                    }, Text);
                    Text.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create("★★★★★");
                        Text.fontSize(16);
                        Text.fontColor("#FFD700");
                        Text.margin({ top: 5 });
                    }, Text);
                    Text.pop();
                    Column.pop();
                    Column.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "Index";
    }
}
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "com.example.genshin_impact_wish_simulator", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "entry/src/main/ets/pages/Index", integratedHsp: "false", moduleType: "followWithHap" });
