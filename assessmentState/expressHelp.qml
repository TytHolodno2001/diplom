import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12


Rectangle{
    id: main_rec
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
    property string statePar: "bad"
    property string title
    property string numberProduct
    property string dateProduct
    property string timeProduct
    property var itemComp/*: [{mode: "Режим", bstp: "000000*", betp: "000000", bstr: "000000", betr: "000000*", info: "пока хз"},
        {mode: "Режим", bstp: "000000", betp: "000000", bstr: "000000", betr: "000000", info: "пока хз"},
        {mode: "Режим", bstp: "000000", betp: "000000", bstr: "000000", betr: "000000", info: "пока хз"}]*/
    signal close();
    onItemCompChanged: {
        listModel.append(itemComp)
    }

    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2 + bigWidth
        height: Param.tableHeight
        visible: true
        radius: Param.elemRadius

        //первая строка - заголовка
        Rectangle {
            id:title
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight
            anchors.left: parent.left

            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Итоговая справка "+main_rec.title
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

                // при наведении
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //при клике
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
                onClicked: {
                    all_ma.active = false
                    active = true
                                        let errorComp = [];
                                        for(let i = 0; i < itemComp.length; i++){
                                            if(itemComp[i].statePar=="bad"){
                                                errorComp.push(itemComp[i])
                                            }

                                        }
                                        listModel.clear()
                                        listModel.append(errorComp)
                                        onlyError.border.color = Param.accentСolor1
                                        all.border.color = borderColor
                }
            }
        }

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

                // при наведении
                onEntered:{
                    parent.border.color = Param.accentСolor3
                }
                onExited:{
                    parent.border.color = active?Param.accentСolor1:borderColor
                }

                //при клике
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
                onClicked: {
                    err_ma.active = false
                    active = true
                                        listModel.clear()
                                        listModel.append(itemComp)
                                        all.border.color = Param.accentСolor1
                                        onlyError.border.color = borderColor
                }
            }
        }

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
                onClicked: {
                    main_rec.close()

                }
            }
        }

        //номер изделия, дата и время
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
                text: "Номер изделия: " + main_rec.numberProduct
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

        //сам список
        Rectangle {
            id: listPar
            anchors.top: parent.top
            anchors.topMargin: headHeight + Param.tableButtonHeight
            anchors.left: parent.left
            anchors.leftMargin: margin
            width: Param.tableWidth - margin*2
            height: table_info.height - (headHeight + Param.tableButtonHeight) - margin
            clip: true
            color: parent.color
            radius: Param.elemRadius

            ListModel {
                id: listModel

            }

            Component {
                id:listDelegate
                Rectangle {
                    height: 20
                    width: Param.tableWidth - margin*2
                    color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                    Text {
                        width: parent.width/2
                        text: name + ":"
                        font.family: Param.textFontFamily
                        font.pointSize: Param.textButtonSize
                        font.bold: true
                        color: statePar=="bad"?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                    }
                    Text {
                        width: parent.width/2
                        leftPadding: parent.width/2
                        text: value
                        font.family: Param.textFontFamily
                        font.pointSize: Param.textButtonSize
                        color: darkTheme?Param.dtextColor1:Param.ltextColor1
                    }
                    MouseArea{
                        property bool create: false
                        anchors.fill: parent
                        hoverEnabled : true

                        onClicked: {

                            if(!create) {
                                if(statePar=="bad"){
                                    if(type == "table"){
                                        let component = Qt.createComponent("table.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(main_rec)
                                            let rows = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                rows.push({number: elem.number, tn: elem.tn, tk: elem.tk, mode: elem.mode})
                                            }
                                            childRec.tableCell = rows

                                            childRec.title = name
                                            //открывается справа или слева
                                            childRec.x =0
                                            childRec.y = headHeight*2

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "table2"){
                                        let component = Qt.createComponent("table2.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(main_rec)

                                            let rows = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                rows.push({par1: elem.par1, par2: elem.par2, par3: elem.par3})
                                            }
                                            console.log(rows)
                                            childRec.tableCell = rows

                                            childRec.title = name
                                            //открывается справа или слева
                                            childRec.x =0
                                            childRec.y = headHeight*2

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "list"){
                                        let component = Qt.createComponent("list.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(main_rec)

                                            let items = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                items.push({number: elem.number, value: elem.value, statePar: elem.statePar})
                                            }
                                            childRec.itemComp = items
                                            childRec.title = name
                                            //открывается справа или слева
                                            childRec.x =0
                                            childRec.y = headHeight*2


                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "items"){
                                        let component = Qt.createComponent("items.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(main_rec)

                                            let items = []
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                if (elem.type == "table") items.push({name: elem.name, type: elem.type, statePar: elem.state, info: elem.info})
                                                else items.push({name: elem.name, type: elem.type, statePar: elem.state, info: elem.inform})
                                            }

                                            childRec.itemComp = items
                                            childRec.title = name
                                            //открывается справа или слева
                                            childRec.x =0
                                            childRec.y = headHeight*2

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    else if(type == "table3"){
                                        let component = Qt.createComponent("table3.qml");
                                        if (component.status === Component.Ready) {
                                            let childRec = component.createObject(main_rec)


                                            let rows = []
                                            console.log()
                                            for (let i = 0; i < infoPar.count; i++){
                                                let elem = infoPar.get(i)
                                                rows.push({param: elem.param, value: elem.value, min: elem.min, max: elem.max})
                                            }
                                            childRec.itemComp = rows

                                            childRec.title = name

                                            //открывается справа или слева
                                            childRec.x =0
                                            childRec.y = headHeight*2

                                            create = true

                                            menuClose.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                            childRec.close.connect(function(){
                                                childRec.destroy()
                                                create = false
                                            })
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            ListView {
                anchors.margins: margin
                anchors.fill: parent
                model: listModel
                delegate: listDelegate
            }

        }


    }
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
