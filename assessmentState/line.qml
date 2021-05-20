import QtQuick 2.15
import Param 1.0

// Объект: Связь
// Название: line
// Переменные:
// x1 - абсцисса 1;
// y1 - ордината 1;
// x2 - абсцисса 2;
// y2 - ордината 2;
// statConnect - состояние связи.
// Функции:
// getWidth - длина связи;
// getSlope - поворот связи.
Rectangle {
    // объявление перменных
    property real x1
    property real y1
    property real x2
    property real y2
    property bool statConnect
    id: l
    color: statConnect? Param.accentСolor1:Param.accentСolor2
    height: Param.connectWidth

    visible: true
    z: 1

    antialiasing: true
    x: x1
    y: y1 - height / 2

    transformOrigin: Item.Left;

    width: getWidth(x1, y1, x2, y2);
    rotation: getSlope(x1, y1, x2, y2);

    // Функция поиска длины связи
    function getWidth(sx1, sy1, sx2, sy2)
    {
        var w = Math.sqrt(Math.pow((sx2 - sx1), 2) + Math.pow((sy2 - sy1), 2));
        return w;
    }

    //Функция поворота связи
    function getSlope(sx1,sy1,sx2,sy2)
    {
        var a, m, d;
        var b = sx2 - sx1;
        if (b === 0) {
            if(y2>y1)
            {
                return 90
            }
            else
                return 270;
        }
        a = sy2 - sy1;
        m = a / b;
        d = Math.atan(m) * 180 / Math.PI;

        if (a < 0 && b < 0)
            return d + 180;
        else if (a >= 0 && b >= 0)
            return d;
        else if (a < 0 && b >= 0)
            return d;
        else if (a >= 0 && b < 0)
            return d + 180;
        else
            return 0;
    }
}

