import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

// Объект: Маленькая кнопка
// Название: smallButton
// Переменные:
// itemText - текст для кнопки 1;
// itemTextOnClick - текст для кнопки 2;
// click - нажата ли кнопка;
// onClick - сигнал при клике на кнопку.
Item {
    // объявление перменных
    property string itemText
    property string itemTextOnClick
    property string click
    signal onClick();
    onClickChanged: {
        if(click == "no"){
            smallButton.border.width = 0
        }
    }
    Rectangle {
        id:smallButton
        width: Param.buttonSmallWidth
        height: Param.buttonSmallHeight
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        radius: Param.elemRadius
        //заголовок
        Text{
            width: parent.width - parent.height
            height: parent.height
            anchors.left: parent.left;
            anchors.leftMargin:  Param.margin32
            text: click == "yes"?itemTextOnClick:itemText
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textButtonSize
            color: darkTheme?Param.dtextColor1:Param.ltextColor1
        }


        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled : true

            //событие при наведении и после
            onEntered:{
                smallButton.border.width = Param.sizeFrame
                smallButton.border.color = Param.accentСolor3
            }
            onExited:{
                smallButton.border.width = click == "yes"? Param.sizeFrame: 0
                smallButton.border.color = Param.accentСolor1
            }

            //событие при клике и после
            onPressed:{

                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
            }
            onReleased:{
                themeChange.connect(function(){

                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                })
                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
            }

            //событие при клике
            onClicked:
            {
                if(click == "no") {
                    smallButton.border.width = Param.sizeFrame
                    smallButton.border.color = Param.accentСolor1
                    click = "yes"
                }
                else {
                    smallButton.border.width = 0
                    click = "no"
                }
                onClick()
            }
        }


        // икнока кнопки
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 2
            height: parent.height - 4
            color: parent.color
            radius: Param.elemRadius

            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: click =="yes" ? Param.iconMinus : (darkTheme?Param.iconPlusDark:Param.iconPlusLight)
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

    }

    //тени
    //тень объекта
    DropShadow {
        anchors.fill: smallButton
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: smallButton
    }
}

