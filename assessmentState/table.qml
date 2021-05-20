import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12

// Объект: Таблица
// Название: table
// Переменные:
// title - заголовок формы объекта;
// tableCell - информация о компоненте БА;
// statePar - состояние;
// close - сигнал закрытия формы объекта.
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
    property var tableCell
    property string statePar: "bad"
    signal close();

    onTableCellChanged: {
        listModel.append(tableCell)
    }
    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2 + bigWidth
        height: Param.tableHeight
        visible: true
        radius: Param.elemRadius
        //заголовок
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

        //кнопка для отоброжения только ошибок
        Rectangle {
            id:onlyError
            width: Param.tableButtonWidth
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: borderColor
            border.width: Param.sizeFrame
            visible:statePar=="ok"?false:true
            Text {
                text: "ошибки"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                id:err_ma
                property bool active: false
                anchors.fill: parent
                hoverEnabled : true

                //событие при наведении и после
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //событие при клике и после
                onPressed:
                {
                    parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                    parent.border.color = Param.accentСolor1}
                onReleased:{
                    themeChange.connect(function(){
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    })
                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    parent.border.color = active?Param.accentСolor1:borderColor

                }
                //событие при клике
                onClicked: {
                    all_ma.active = false
                    active = true
                    let errorComp = [];
                    for(let i = 0; i < tableCell.length; i++){
                        if((tableCell[i].tnp!=tableCell[i].tnr)||(tableCell[i].tkp!=tableCell[i].tkr)){
                            errorComp.push(tableCell[i])
                        }
                    }
                    listModel.clear()
                    listModel.append(errorComp)
                    onlyError.border.color = Param.accentСolor1
                    all.border.color = borderColor
                }
            }
        }

        //кнопка для отоброжения всех данных
        Rectangle {
            id:all
            width: Param.tableButtonWidth
            height: Param.tableButtonHeight
            anchors.right: parent.right
            anchors.rightMargin: headHeight + margin + onlyError.width
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: Param.accentСolor1
            border.width: Param.sizeFrame
            visible:statePar=="ok"?false:true
            Text {
                text: "все"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                id: all_ma
                property bool active: false
                anchors.fill: parent
                hoverEnabled : true

                //событие при наведении и после
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //событие при клике и после
                onPressed:
                {
                    parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                    parent.border.color = Param.accentСolor1}
                onReleased:{
                    themeChange.connect(function(){
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    })
                    parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    parent.border.color = active?Param.accentСolor1:borderColor

                }
                //событие при клике
                onClicked: {
                    err_ma.active = false
                    active = true
                    listModel.clear()
                    listModel.append(tableCell)
                    all.border.color = Param.accentСolor1
                    onlyError.border.color = borderColor
                }
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


        // Отображение таблицы
        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: headHeight
            width: headHeight+smallWidth*2+bigWidth
            height: Param.tableHeight - headHeight
            clip: true
            color: parent.color
            radius: Param.elemRadius
            ListModel {
                id: listModel

            }
            Component {
                id:listDelegate
                Rectangle {
                    height:cellHeight
                    width: headHeight+smallWidth*2+bigWidth
                    color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: headHeight
                        height: cellHeight
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: number
                            font.pointSize: fontPointSize
                            color: fontColor
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: (parent.width - headHeight)/5
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: tnp
                            font.pointSize: fontPointSize
                            color:  number == "№"?fontColor:(tnp == tnr? fontColor:Param.accentСolor2)
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: (parent.width - headHeight)/5
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight + (parent.width - headHeight)/5
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: tkp
                            font.pointSize: fontPointSize
                            color: number == "№"?fontColor:(tkp == tkr? fontColor:Param.accentСolor2)
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: (parent.width - headHeight)/5
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight + (parent.width - headHeight)/5*2
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: tnr
                            font.pointSize: fontPointSize
                            color: number == "№"?fontColor:(tnp == tnr? fontColor:Param.accentСolor2)
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: (parent.width - headHeight)/5
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight + (parent.width - headHeight)/5*3
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: tkr
                            font.pointSize: fontPointSize
                            color: number == "№"?fontColor:(tkp == tkr? fontColor:Param.accentСolor2)
                        }
                    }
                    Rectangle{
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        width: (parent.width - headHeight)/5
                        anchors.left: parent.left
                        anchors.leftMargin: headHeight + (parent.width - headHeight)/5*4
                        height: cellHeight
                        border.width: 1
                        border.color: borderColor
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            text: mode
                            font.pointSize: fontPointSize
                            color: fontColor
                        }
                    }
                }
            }
            ListView {
                anchors.fill: parent
                model: listModel
                delegate: listDelegate
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
