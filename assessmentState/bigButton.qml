import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

// Объект: Таблица для вывода из БД
// Название: DB
// Переменные:
// itemText - текст для кнопки 1;
// itemTextOnClick - текст для кнопки 2;
// textMain - главный текст кнопки;
// click - нажата ли кнопка;
// onClick - сигнал при клике на кнопку.
Item {
    // объявление перменных
    property string itemText
    property string itemTextOnClick
    property string textMain: itemTextOnClick
    property bool click: false
    signal onClick();
    //кнопка
    // hovered - наведено ли на кнопку
    Rectangle {
        id:bigButton
        property bool hovered: false

        width: Param.buttonBigWidth
        height: Param.buttonBigHeight
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        radius: Param.elemRadius

        Text{
            width: parent.width
            height: parent.height
            text: textMain
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textButtonSize
            color: darkTheme?Param.dtextColor1:Param.ltextColor1
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled : true

            //событие при наведении и после
            onEntered:{
                bigButton.border.width = Param.sizeFrame
                bigButton.border.color = Param.accentСolor3
            }
            onExited:{
                bigButton.border.width = 0
            }

            //событие при клике и после
            onPressed: bigButton.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
            onReleased:{
                themeChange.connect(function(){
                    bigButton.color = darkTheme?Param.delemFirstColor:Param.lelemFirstColor
                })
                bigButton.color = darkTheme?Param.delemFirstColor:Param.lelemFirstColor}

            //событие при клике
            onClicked:{
                onClick()
                click = !click
                textMain = click? itemText:itemTextOnClick
            }
        }
    }

    //тень объекта
    DropShadow {
        anchors.fill: bigButton
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: bigButton
    }
}
