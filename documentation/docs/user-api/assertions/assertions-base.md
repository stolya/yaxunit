---
tags: [Начало, Утверждения]
---

# Базовые утверждения

Утверждения для проверки значений

Доступ к утверждениям обеспечивает метод `ЮТест.ОжидаетЧто`, который возвращает инициализированный модуль `ЮТУтверждения`, реализующий работу с утверждениями.

:::tip
Не рекомендуется обращаться к модулю `ЮТУтверждения` напрямую, используйте `ЮТест.ОжидаетЧто`
:::

* Реализован минимально необходимый набор проверок
* Большая часть методов - это сравнения фактического и ожидаемого результатов, но есть несколько методов настройки
  * `Что` - устанавливает проверяемый объект. Все дальнейшие проверки будут выполняется с этим объектом
  * `Метод` - устанавливает имя и параметры проверяемого метода. Для проверки методов имеются утверждения `ВыбрасываетИсключение` и `НеВыбрасываетИсключение`
  * `Параметр` - добавляет параметр метода. Создан для удобства установки параметров проверяемого метода
  * `Свойство` - устанавливает проверяемое свойство и проверяет его наличие.
    * Последующие проверки, вызванные после этого метода, будут относиться к свойству объекта.
      Например, `ЮТест.ОжидаетЧто(Контекст).Свойство("ИмяМетода").Равно("МетодБезИсключение")` эквивалентно проверке `Контекст.ИмяМетода = "МетодБезИсключение"`
* Методы работы со свойствами позволяют указывать цепочку свойств (доступ к вложенным свойствам через точку)
  Например:
  * `Свойство("Контекст.ИмяМетода")` - вложенное свойство
  * `ИмеетСвойство("Контекст.ПараметрыМетода[0]")` - элемент вложенной коллекции
  * `НеИмеетСвойства("[0].Свойство")` - свойство элемента коллекции
* Все методы имеют параметр `ОписаниеПроверки` для описания конкретной проверки

## Доступные методы

:::tip
Полный и актуальный набор методов смотрите в описании API
:::

### Сравнение значений

* `Равно` - проверка на равенство конкретному значению. Для сериализуемых объектов идет сравнение по значению
* `НеРавно` - проверка на не равенство конкретному значению. Для сериализуемых объектов идет сравнение по значению
* `Больше` - проверяемое значение должно быть больше указанного
* `БольшеИлиРавно` - проверяемое значение должно быть больше или равно указанному
* `Меньше` - проверяемое значение должно быть меньше указанного
* `МеньшеИлиРавно` - проверяемое значение должно быть меньше или равно указанному
* `ЭтоНеопределено` - проверяемое значение должно быть равно `Неопределено`
* `ЭтоНеНеопределено` - проверяемое значение должно быть не равно `Неопределено`
* `ЭтоNull` - проверяемое значение должно быть равно `Null`
* `ЭтоНеNull` - проверяемое значение должно быть не равно `Null`
* `ЭтоИстина` - проверяемое значение должно быть истиной
* `ЭтоНеИстина` - проверяемое значение не должно быть истиной
* `ЭтоЛожь` - проверяемое значение должно быть ложью
* `ЭтоНеЛожь` - проверяемое значение не должно быть ложью

### Проверка заполненности

* `Заполнено` - проверяет заполненность значения
* `НеЗаполнено` - проверяет незаполненность значения
* `Существует` - проверяет существование (не равно `Null` и `Неопределено`) значения
* `НеСуществует` - проверяет не существование (не равно `Null` и `Неопределено`) значения

### Проверка строк

* `ИмеетДлину` - проверяет, что строка имеет указанную длину
* `ИмеетДлинуБольше` - проверяет, что длин строки больше указанной
* `ИмеетДлинуМеньше` - проверяет, что длина строки меньше указанной
* `НеИмеетДлину` - проверяет, что длина строки отличается от указанной
* `Содержит` - проверяемая строка содержит указанную подстроку
* `НеСодержит` - проверяемая строка не содержит указанную подстроку
* `НачинаетсяС` - проверяемая строка начинается с указанной строки
* `ЗаканчиваетсяНа` - проверяемая строка заканчивается на указанную строку
* `СодержитСтрокуПоШаблону` - проверяемая строка содержит подстроку, соответствующую регулярному выражению
* `НеСодержитСтрокуПоШаблону` - проверяемая строка не содержит подстроку, соответствующую регулярному выражению

### Проверка  вхождения значения в интервал

* `МеждуВключаяГраницы` - проверяемое значение находиться в указанному интервале (включая границы)
* `МеждуИсключаяГраницы` - проверяемое значение находиться в указанному интервале (исключая границы)
* `МеждуВключаяНачалоГраницы` - проверяемое значение находиться в указанному интервале (включая левую границу и исключая правую)
* `МеждуВключаяОкончаниеГраницы` - проверяемое значение находиться в указанному интервале (исключая левую границу и включая правую)

### Проверка типа значения

* `ИмеетТип` - проверяемое значение должно иметь указанный тип
* `НеИмеетТип` - тип проверяемого значения должен отличаться от указанного

### Проверка выполнения метода

* `ВыбрасываетИсключение` - проверят, что указанный метод объекта выбрасывает исключение
* `НеВыбрасываетИсключение` - проверят, что указанный метод объекта не выбрасывает исключение

### Проверка наличия свойств/реквизитов

* `ИмеетСвойство` - проверяемый объект должен содержать указанное свойство
* `НеИмеетСвойства` - проверяемый объект не содержит указанное свойство
* `ИмеетСвойстваРавные` - проверяемый объект должен содержать указанный набор свойств/реквизитов и значений

### Проверка коллекции

* `ИмеетДлину` - проверяет, что коллекция имеет  указанный размер
* `ИмеетДлинуБольше` - проверяет, что коллекция имеет размер, который больше указанного
* `ИмеетДлинуМеньше` - проверяет, что коллекция имеет размер, который меньше указанного
* `НеИмеетДлину` - проверяет, что размер коллекции отличается от указанного
* `Содержит` - проверяемая коллекция должна содержать указанный элемент
* `НеСодержит` - проверяемая коллекция не должна содержать указанный элемент
* `КаждыйЭлементСодержитСвойство` - проверяет, что каждый элемент коллекции имеет указанное свойство
* `КаждыйЭлементСодержитСвойствоСоЗначением` - проверяет, что каждый элемент коллекции имеет указанное свойство, которое равно ожидаемому значению
* `ЛюбойЭлементСодержитСвойство` - проверяет, что в коллекции есть элемент содержащий указанное свойство
* `ЛюбойЭлементСодержитСвойствоСоЗначением` - проверяет, что в коллекции есть элемент содержащий указанное свойство, которое равно ожидаемому значению
* `КаждыйЭлементСоответствуетПредикату` - проверяет, что элементы коллекции соответствуют переданным условиям
* `ЛюбойЭлементСоответствуетПредикату` - проверяет, что коллекция содержит элемент, который соответствует переданным условиям

### Проверка на соответствие набору условий, предикату

* `СоответствуетПредикату` - проверяет, что объект или его свойство соответствует набору условий

### Проверка методов объекта

Для проверки работы методов объекта есть набор утверждений среди описанных выше (`ВыбрасываетИсключение` и `НеВыбрасываетИсключение`), но для их работы необходимо выполнить предварительные настройки.
Нужно указать какой методы объекта мы хотим проверить и с какими параметрами, для этого имеются следующие методы api

* `Метод` - устанавливает имя и параметры проверяемого метода
* `Параметр` - добавляет параметр метода. Создан для удобства установки параметров проверяемого метода

### Методы позиционирования

В дополнении к указанным методам утверждений есть возможность применить их к вложенным свойствам. Например, проверить, наличие заполненной табличной части документа используя выражение `ОжидаетЧто(Документ).Свойство("Товары").Заполнено()`.
Используя методы `Свойство` и `Элемент` можно позиционировать утверждения на вложенный реквизит/элемент.

* `Свойство` - проверяет наличие свойства и позиционирует дальнейшие проверки на указанном свойстве
* `Элемент` - проверяет наличие элемента коллекции и позиционирует дальнейшие проверки на указанном элементе
* `Объект` - позиционирует дальнейшие проверки на объекте, указанном в методе `Что`
* `НетСвойства` - проверяет отсутствие свойства и позиционирует дальнейшие проверки на объекте, указанном в методе `Что`

## Примеры

### Базовые проверки

```bsl
ЮТест.ОжидаетЧто(2 + 3, "2 + 3") // Используя модуль утверждений установим проверяемое значение и пояснение
  .ИмеетТип("Число") // Проверим тип
  .Заполнено() // Заполненность проверяемого значения
  .Больше(0) // Сравним с нулем
  .Равно(5); // Проверим ожидаемый результат
```

### Проверка сложного объекта

```bsl
Объект = ЮТОбщий.ЗначениеВМассиве("1", "2", "3");
ЮТУтверждения.Что(Объект, "Проверка элементов массива")
  .Содержит("1")
  .НеСодержит(1)
  .Элемент(0).Равно("1")
  .Элемент(1).Равно("2")
  .Элемент(-1).Равно("3")
  .Свойство("[00]").Равно("1")
  .Свойство("[1]").Равно("2")
  .Свойство("[-1]").Равно("3")
  .НетСвойства(3)
  .НеИмеетСвойства("[3]");

Объект.Добавить(Новый Структура("Первый, Второй", 1, ЮТОбщий.ЗначениеВМассиве(2)));
ЮТУтверждения.Что(Объект, "Проверка свойства элемента массива")
  .Свойство("[3].Первый").Равно(1)
  .Свойство("[3].Второй[-1]").Равно(2)
  .Свойство("[3].Второй[0]").Равно(2)
```

### Проверка вызова метода

```bsl
ЮТУтверждения.Что(ОМ_ЮТУтверждения)
  .Метод("МетодБезИсключение", ЮТОбщий.ЗначениеВМассиве("Исключение"))
  .НеВыбрасываетИсключение()
  .НеВыбрасываетИсключение("Ожидаемое исключение");
ЮТУтверждения.Что(ОМ_ЮТУтверждения)
  .Метод("МетодИсключение", ЮТОбщий.ЗначениеВМассиве("Исключение", 2))
  .ВыбрасываетИсключение("Слишком много фактических параметров");
ЮТУтверждения.Что(ОМ_ЮТУтверждения)
  .Метод("МетодИсключение", ЮТОбщий.ЗначениеВМассиве("Исключение"))
  .ВыбрасываетИсключение("Исключение");
ЮТУтверждения.Что(ОМ_ЮТУтверждения)
  .Метод("МетодБезИсключение")
  .ВыбрасываетИсключение("Недостаточно фактических параметров");
```

### Проверка соответствия предикату

```bsl
Дата = ЮТест.Данные().СлучайнаяДата();

Объект = Новый Структура;
Объект.Вставить("Число", 1);
Объект.Вставить("Строка", "1");
Объект.Вставить("Дата", Дата);
Объект.Вставить("Массив", ЮТОбщий.ЗначениеВМассиве(1, "1"));

ПроверкаЧисла = ЮТест.Предикат().Реквизит("Число")
  .ИмеетТип(Тип("Число"))
  .БольшеИлиРавно(1)
  .МеньшеИлиРавно(10)
  .Получить();
ПроверкаДаты = ЮТест.Предикат().Реквизит("Дата")
  .ИмеетТип(Новый ОписаниеТипов("Дата"))
  .Равно(Дата)
  .Получить();

ЮТест.ОжидаетЧто(Объект)
  .СоответствуетПредикату(ЮТест.Предикат()
    .Заполнено()
    .ИмеетТип("Структура"))
  .СоответствуетПредикату(ПроверкаЧисла)
  .СоответствуетПредикату(ПроверкаДаты)
;
```

### Проверка элементов коллекции на соответствие предикату

```bsl
ТаблицаРезультатов = ЮТест.Данные().ЗагрузитьИзМакета("ОбщийМакет.ЮТ_МакетТестовыхДанных.R2C1:R5C11", ОписанияТипов);
Ютест.ОжидаетЧто(ТаблицаРезультатов)
  .ИмеетТип("Массив")
  .ИмеетДлину(3)
  .КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
    .Реквизит("Товар").Заполнено().ИмеетТип("СправочникСсылка.Товары")
    .Реквизит("Период").Заполнено().ИмеетТип("Дата")
    .Реквизит("Количество").Заполнено().ИмеетТип("Число")
    .Реквизит("Цена").Заполнено().ИмеетТип("Число")
  )
```
