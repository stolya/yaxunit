//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

///////////////////////////////////////////////////////////////////
// Расширяет возможности тестирования, 
// позволяет в упрощенной форме получать данны из информационной базы
// как с сервера так и с клиента.
///////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Возвращает значения реквизитов ссылки
// 
// Параметры:
//  Ссылка - ЛюбаяСсылка
//  ИменаРеквизитов - Строка - Имена получаемых реквизитов, разделенные запятой.
//                             Важно, нельзя указывать реквизиты через точку.
// 
// Возвращаемое значение:
//  Структура Из Произвольный - Значения реквизитов ссылки
Функция ЗначенияРеквизитов(Ссылка, ИменаРеквизитов) Экспорт
	
	//@skip-check constructor-function-return-section
	Возврат ЮТЗапросыВызовСервера.ЗначенияРеквизитов(Ссылка, ИменаРеквизитов, Ложь);
	
КонецФункции

// Возвращает значение реквизита ссылки
// 
// Параметры:
//  Ссылка - ЛюбаяСсылка
//  ИмяРеквизита - Строка - Имя получаемого реквизита, можно указать путь к вложенному реквизиту через точку
// 
// Возвращаемое значение:
//  Структура Из Произвольный - Значения реквизитов ссылки
Функция ЗначениеРеквизита(Ссылка, ИмяРеквизита) Экспорт
	
	//@skip-check constructor-function-return-section
	Возврат ЮТЗапросыВызовСервера.ЗначенияРеквизитов(Ссылка, ИмяРеквизита, Истина);
	
КонецФункции

// Возвращяет первую запись таблицы соответствующую условиям
// 
// Параметры:
//  ИмяТаблицы - Строка - Имя таблицы базы
//  Предикат - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Неопределено - Проверит, что таблица не пустая 
// Возвращаемое значение:
//  Структура, Неопределено - Содержит все данные записи, включая табличный части
Функция Запись(ИмяТаблицы, Предикат) Экспорт
	
	ОписаниеЗапроса = ЮТЗапросыКлиентСервер.ОписаниеЗапроса(ИмяТаблицы, Предикат, "*");
	//@skip-check constructor-function-return-section
	Возврат ЮТЗапросыВызовСервера.Записи(ОписаниеЗапроса, Истина);
	
КонецФункции

// Возвращяет записи таблицы соответствующую условиям
// 
// Параметры:
//  ИмяТаблицы - Строка - Имя таблицы базы
//  Предикат - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Неопределено - Проверит, что таблица не пустая 
// Возвращаемое значение:
//  Массив из Структура - Найденные записи, включая табличный части
Функция Записи(ИмяТаблицы, Предикат) Экспорт
	
	ОписаниеЗапроса = ЮТЗапросыКлиентСервер.ОписаниеЗапроса(ИмяТаблицы, Предикат, "*");
	Возврат ЮТЗапросыВызовСервера.Записи(ОписаниеЗапроса, Ложь);
	
КонецФункции

// Вернет признак содержит ли таблица записи удовлетворяющие переданным условиям
// 
// Параметры:
//  ИмяТаблицы - Строка - Имя таблицы базы
//  Предикат - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Неопределено - Проверит, что таблица не пустая 
// Возвращаемое значение:
//  Булево - Таблица содержит записи
Функция ТаблицаСодержитЗаписи(ИмяТаблицы, Предикат = Неопределено) Экспорт
	
	ОписаниеЗапроса = ЮТЗапросыКлиентСервер.ОписаниеЗапроса(ИмяТаблицы, Предикат);
	Возврат НЕ РезультатПустой(ОписаниеЗапроса);
	
КонецФункции

// Возвращает результат выполнения простого запроса.
// 
// Параметры:
//  ОписаниеЗапроса - см. ОписаниеЗапроса
// 
// Возвращаемое значение:
//  - ТаблицаЗначений - Результат запроса для сервера
//  - Массив из Структура - Результат запроса для клиента
Функция РезультатЗапроса(ОписаниеЗапроса) Экспорт
	
#Если Клиент Тогда
	Возврат ЮТЗапросыВызовСервера.РезультатЗапроса(ОписаниеЗапроса, Истина);
#Иначе
	Возврат ЮТЗапросыВызовСервера.РезультатЗапроса(ОписаниеЗапроса, Ложь);
#КонецЕсли
	
КонецФункции

// Определяет, есть ли в результате записи
// 
// Параметры:
//  ОписаниеЗапроса - см. ОписаниеЗапроса
// 
// Возвращаемое значение:
//  Булево - Результат пустой
Функция РезультатПустой(ОписаниеЗапроса) Экспорт
	
	Возврат ЮТЗапросыВызовСервера.РезультатПустой(ОписаниеЗапроса);
	
КонецФункции

// Описание простого запроса
// 
// Возвращаемое значение:
//  Структура - Описание запроса:
// * ИмяТаблицы - Строка -
// * ВыбираемыеПоля - Массив из Строка
// * КоличествоЗаписей - Число, Неопределено - Ограничение количества выбираемых записей
// * Условия - Массив из Строка - Коллекция выражений условий, которые будут объединены через `И`
// * ЗначенияПараметров - Структура - Набор параметров запроса
Функция ОписаниеЗапроса() Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("ИмяТаблицы", "");
	Описание.Вставить("ВыбираемыеПоля", Новый Массив);
	Описание.Вставить("КоличествоЗаписей", Неопределено);
	Описание.Вставить("Условия", Новый Массив());
	Описание.Вставить("ЗначенияПараметров", Новый Структура());
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

#КонецОбласти
