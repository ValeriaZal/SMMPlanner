# 0. Python Coding Conventions

Данный раздел содержит соглашения о стиле написания кода на Python, которые мы соблюдаем в текущем проекте.

В качестве основы используется соглашение PEP8 ([ru](https://pythonworld.ru/osnovy/pep-8-rukovodstvo-po-napisaniyu-koda-na-python.html), [en](https://www.python.org/dev/peps/pep-0008/)).

# 1. QML Coding Conventions

Данный раздел содержит соглашения о стиле написания кода на QML, которые мы соблюдаем в текущем проекте.

## 1.1 QML Object Declarations

1.1.1 Аттрибуты QML объектов всегда структурированы в следующем порядке:
1. id
2. property declarations
3. signal declarations
4. JavaScript functions
5. object properties
6. child objects
7. states
8. transitions

1.1.2 Для лучшей читабельности, данные части отделяются друг от друга пустыми строками.

Пример:
```qml
Rectangle {
    id: photo                                               // id on the first line makes it easy to find an object

    property bool thumbnail: false                          // property declarations
    property alias image: photoImage.source

    signal clicked                                          // signal declarations

    function doSomething(x)                                 // javascript functions
    {
        return x + photoImage.width
    }

    color: "gray"                                           // object properties
    x: 20                                                   // try to group related properties together
    y: 20
    height: 150
    width: {                                                // large bindings
        if (photoImage.width > 200) {
            photoImage.width;
        } else {
            200;
        }
    }

    Rectangle {                                             // child objects
        id: border
        anchors.centerIn: parent; color: "white"

        Image {
            id: photoImage
            anchors.centerIn: parent
        }
    }

    states: State {                                         // states
        name: "selected"
        PropertyChanges { target: border; color: "red" }
    }

    transitions: Transition {                               // transitions
        from: ""
        to: "selected"
        ColorAnimation { target: border; duration: 200 }
    }
}
```

## 1.2 Braces

1.2.1 Перед открывающей круглой/квадратной/фигурной скобкой всегда ставится один пробел.
1.2.2 Закрывающие круглые/квадратные/фигурные скобки в многострочных конструкциях находятся под первым символом строки, начинающей многострочную конструкцию.
```cpp
if (a) {
     …
 } else {
     if (b)
         …
 }
```

## 1.3 Indentation

1.3.1 В качестве отступа используется 4 пробела.
1.3.2 Продолжительные строки должны выравнивать обернутые элементы либо вертикально, используя неявную линию в скобках (круглых, квадратных или фигурных), либо с использованием висячего отступа. При использовании висячего отступа следует применять следующие соображения: на первой линии не должно быть аргументов, а остальные строки должны четко восприниматься как продолжение линии:
```cpp
// Выровнено по открывающему разделителю
foo = long_function_name(var_one, var_two,
                         var_three, var_four)
```

1.3.3 На одной строке располагается 100 символов. Запятые помещаются в конец разорванной линии; операторы помещаются в начало новой строки.
```qml
if (longExpression
     + otherLongExpression
     + otherOtherLongExpression) {
 }
```
1.3.4 Бинарные операции отделяются пробелами с двух сторон.
1.3.5 Для тела оператора if всегда используется новая строка.

## 1.4 Declaring variables and functions

1.4.1 Каждая переменная объявляется на одной строке.
1.4.2 В названии переменных не используются аббревиатуры. Исключение составляют лишь общеизвестные обозначения, например, HTML.
1.4.3 Односимвольные имена переменных подходят только для итераторов циклов, небольшого локального контекста и временных переменных. В остальных случаях имя переменной должно отражать ее назначение.
1.4.4 Объявление переменной происходит непосредственно перед ее использованием в коде.
1.4.5 Функции и переменные должны именоваться со строчной буквы (lower-case). Каждое последующие слово в имени переменной должно начинаться с прописной буквы.
1.4.6 Имена классов всегда начинаются с заглавной буквы. Public-классы начинаются с буквы 'Q' (QRgb). Public-функции должны начинаться с прописной буквы 'q' (qRgb).
1.4.7 При использовании аббревиатур в названии - camelCase (QXmlStreamReader).

## 1.5 Commenting Code

1.5.1 однострочный комментарий:
```cpp
// comment
```
1.5.2 многострочный комментарий:
```cpp
/*
   This is a multiple line comment
*/
```

## 1.6 Type Safety

1.6.1 При объявлении свойства (property) указывается тип переменной, если это возможно:
```qml
property string name
property int size
property MyMenu optionsMenu
```
1.6.2 В противном случае используется ключевое слово <var>:
```qml
property string name
property int size
property MyMenu optionsMenu
```
Однако данный подход применяется в крайних случаях в связи со снижением читабельности кода и усложняет процесс отладки.


## 1.7 Grouped Properties

1.7.1 При использовании нескольких свойств из некоторой группы свойств будет использоваться "групповая нотация" вместо "точечной", если это улучшает удобочитаемость.

"Групповая нотация"
```qml
Rectangle {
    anchors.left: parent.left; anchors.top: parent.top; anchors.right: parent.right; anchors.leftMargin: 20
}

Text {
    text: "hello"
    font.bold: true; font.italic: true; font.pixelSize: 20; font.capitalization: Font.AllUppercase
}
```

"Точечная нотация"
```qml
Rectangle {
    anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: 20 }
}

Text {
    text: "hello"
    font { bold: true; italic: true; pixelSize: 20; capitalization: Font.AllUppercase }
}
```

## 1.8 JavaScript Code

1.8.1 Если скрипт представляет одно выражение, то он записывается в одну строку (inline):
```qml
Rectangle { color: "blue"; width: parent.width / 3 }
```
или записывается блоком кода:
```qml
Rectangle {
    color: "blue"
    width: {
        var w = parent.width / 3
        console.debug(w)
        return w
    }
}
```

1.8.2 При достаточно большом теле скрипта он будет выноситься в отдельную функцию:
```qml
function calculateWidth(object)
{
    var w = object.width / 3
    // ...
    // more javascript code
    // ...
    console.debug(w)
    return w
}

Rectangle { color: "blue"; width: calculateWidth(parent) }
```

1.8.3 Возможен вариант вынесения скрипта в отдельный JS файл.
```qml
import "myscript.js" as Script

Rectangle { color: "blue"; width: Script.calculateWidth(parent) }
```

## 1.9 Importing Files into QML

1.9.1 Импорты всегда помещаются в начале файла, сразу после комментариев к модулю и перед объявлением констант.
1.9.2 Они должны быть сгруппированы в следующем порядке:
-- импорты из стандартной библиотеки (QML Qt)
-- импорты сторонних библиотек
-- импорты модулей текущего проекта
1.9.3 Между каждой группой импортов пустая строка.
