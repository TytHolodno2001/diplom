import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12

// Объект: итоговая справка ППО
// Название: expressHelpPPO
// Переменные:
// title - заголовок объекта;
// numberProduct - номер БА;
// dateProduct - дата эксплуатации БА;
// timeProduct - время эксплуатации БА;
// itemComp - информация о компонентах БА;
// close - сигнал закрытия формы объекта;
// tn - Тн;
// tk - Тк;
// basi - состояние БАСИ;
// bapd - состояние БАПД;
// si - состояние информации;
// mn - маркер недостоверности.
Rectangle{
    id: main_rec

    // объявление перменных
    property int smallWidth: Param.tableSmallWidth
    property int bigWidth: Param.tableBigWidth
    property int headHeight: Param.tableHeadHeight
    property int cellHeight: Param.tableCellHeight
    property int margin: Param.margin24
    property string fontFamily: Param.textFontFamily
    property int fontPointSize: Param.textItemComp
    property color accentColor: Param.accentСolor1
    property color fontColor: darkTheme?Param.dtextColor1:Param.ltextColor1
    property color borderColor: darkTheme?Param.delemThirdColor:Param.lelemThirdColor

    property string title
    property string numberProduct
    property string dateProduct
    property string timeProduct
    property string mode
    property string tn
    property string tk
    property string basi
    property string bapd
    property string si
    property string mn

    signal close();


    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2 + bigWidth
        height: Param.tableHeight + headHeight
        visible: true
        radius: Param.elemRadius

        // Загаловок
        Rectangle {
            id:title
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight
            anchors.left: parent.left

            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: main_rec.title
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: fontPointSize
                color:  Param.accentСolor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }
        }

        // кнопка закрытия формы объекта
        Rectangle {
            id:cross
            width: headHeight
            height: headHeight
            anchors.right: parent.right
            anchors.top: parent.top
            color: parent.color
            radius: Param.elemRadius
            Image {
                id: cross_img
                source: darkTheme?Param.iconCrossDark:Param.iconCrossLight
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            //закрыть окно
            MouseArea {
                anchors.fill: parent
                //событие при клике
                onClicked: {
                    main_rec.close()
                }
            }
        }

        //Информация о номере изделия, дате и времени
        Rectangle {
            id:numberProduct
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Номера изделий: " + main_rec.numberProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }
            Text {
                text: "Дата: " + main_rec.dateProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3
            }
            Text {
                text: "Время: " + main_rec.timeProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3*2
            }
        }

        //Информация о режиме
        Rectangle {
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10 + (headHeight - 20)
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text:  main_rec.mode
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }
            Text {
                text: "ТН: " + main_rec.tn
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3
            }
            Text {
                text:  "ТK: " + main_rec.tk
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3*2
            }
        }
        //Информация о БАСИ
        Rectangle {
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10 + (headHeight - 20)*2
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "БАСИ: "+ main_rec.basi
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }

        }
        //Информация о БАПД
        Rectangle {
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10 + (headHeight - 20)*3
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "БАПД: "+ main_rec.bapd
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }

        }
        //Информация о структуре информации
        Rectangle {
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10 + (headHeight - 20)*4
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Структура информации: "+ main_rec.si
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }

        }
        //Инфомация о маркере недостоверности
        Rectangle {
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10 + (headHeight - 20)*5
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Маркер недостоверности: "+ main_rec.mn
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }

        }

    }
    //тень объекта
    DropShadow {
        anchors.fill: table_info
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: table_info
    }
}

