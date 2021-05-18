pragma Singleton // Указываем, что этот QML Тип является синглетоном
import QtQuick 2.0

Item {
    //значения цветов
    property color accentСolor1: "#48D3FF"
    property color accentСolor2: "#DE242F"
    property color accentСolor3: "#0081C2"
    //для темной темы
    property color dbgColor: "#2F3140"
    property color delemFirstColor: "#393B4E"
    property color delemSecondColor: "#43455A"
    property color delemThirdColor: "#4D4F67"
    property color dtextColor1: "#ECECEC"
    property color dtextColor2: "#48D3FF"
    //для светлой темы
    property color lbgColor: "#d3d5e8"
    property color lelemFirstColor: "#edeffa"
    property color lelemSecondColor: "#FFFFFF"
    property color lelemThirdColor: "#dadceb"
    property color ltextColor1: "#2F3140"
    property color ltextColor2: "#696B7D"
    //значения текста
    property string textFontFamily: "Exo 2"
    property int textButtonSize: 12 / 1.5
    property int textFBSize: 38/ 1.5
    property int textTitleSize: 40/ 1.5
    property int textItemComp: 16 / 1.5
    property string textRegularBold: "Regular"
    property string textLightBold: "Light"
    //отступы
    property int margin80: 80/ 1.5
    property int margin48: 48/ 1.5
    property int margin32: 32/ 1.5
    property int margin24: 24/ 1.5
    property int margin16: 16/ 1.5
    property int margin8: 8/ 1.5
    //скругление
    property int elemRadius: 16/ 1.5
    //рамки
    property int sizeFrame: 2
    //тени
    property int horizOffset: 0
    property int verticOffset: 0
    property color dDropShadowColor: "#2C2D35"
    property color lDropShadowColor: "#636782"
    property int mainRadius: 30/ 1.5
    property int mainSamples: 60/ 1.5
    property int darkRadius: 20/ 1.5
    property int darkSamples: 25/ 1.5
    property int lightRadius: 20/ 1.5
    property int lightSamples: 10/ 1.5
    //размеры
    //Кнопка-большая-desktop
    property int buttonBigWidth: 400/ 1.5
    property int buttonBigHeight: 80/ 1.5
    //Кнопка-маленькая-desktop
    property int buttonSmallWidth: 336/ 1.5
    property int buttonSmallHeight: 72/ 1.5
    //Функциональный блок
    property int fBWidth: 400/ 1.5
    property int fBHeight:96/ 1.5
    //ФБ - элемент выбора
    property int fBSelectSmallWidth:100/ 1.5
    property int fBSelectBigWidth: 200/ 1.5
    property int fBSelectHeight: 72/ 1.5
    //кнопка выбора темы
    property int buttonThemeSize: 80/ 1.5
    //информация в ФБ
    property int itemCompWidth: 400/ 1.5
    property int itemCompHeight: 200
    property int itemCompElemHeight: 24
    //связь
    property int connectWidth: 3/ 1.5
    //таблица
    property int tableWidth: 880/1.5
    property int tableSWidth: 480/1.5
    property int tableHeight: 200
    property int tableSmallWidth: 200 / 1.5
    property int tableBigWidth: 400 / 1.5
    property int tableHeadHeight: 80 / 1.5
    property int tableCellHeight: 40 / 1.5
    property int tableMediumWidth: 800 / 1.5
    property int tableMediumHeight: 150
    property int tableButtonWidth: 100
    property int tableButtonHeight: 30
    //список параметрво
    property int listWidth: 400/1.5
    property int listHeight: 200
    property int listTitleHeight: 80 / 1.5
    //список кнопок
    property int itemsWidth: 320/1.5
    property int itemsHeight: 200
    property int itemsTitleHeight: 80 / 1.5
    //иконки
    property string iconArrowBigBlack: "images/ArrowBigBlack.png"
    property string iconArrowBigBlue: "images/ArrowBigBlue.png"
    property string iconArrowBigWhite: "images/ArrowBigWhite.png"
    property string iconArrowSmallBlack: "images/ArrowSmallBlack.png"
    property string iconArrowSmallWhite: "images/ArrowSmallWhite.png"
    property string iconBASIDark: "images/BASIDark.png"
    property string iconBASILight: "images/BASILight.png"
    property string iconBAPDDark: "images/BASIDark.png"
    property string iconBAPDLight: "images/BASILight.png"
    property string iconPPODark: "images/PPODark.png"
    property string iconPPOLight: "images/PPOLight.png"
    property string iconPPUDark: "images/PPUDark.png"
    property string iconPPULight: "images/PPULight.png"
    property string iconStateActive: "images/StateActive.png"
    property string iconStateDark: "images/StateDark.png"
    property string iconStateLight: "images/StateLight.png"
    property string iconThemeDark: "images/ThemeDark.png"
    property string iconThemeLight: "images/ThemeLight.png"
    property string iconPlusLight: "images/PlusLight.png"
    property string iconPlusDark: "images/PlusDark.png"
    property string iconMinus: "images/Minus.png"
    property string iconStateWrong:"images/StateWrong.png"
    property string iconCrossDark:"images/CrossDark.png"
    property string iconCrossLight:"images/CrossLight.png"
}
