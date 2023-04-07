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

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции, предназначенные для использования другими 
// объектами конфигурации или другими программами
///////////////////////////////////////////////////////////////////////////////// 
#Область ПрограммныйИнтерфейс

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныйПрограммныйИнтерфейс

Процедура Инициализация(ПараметрыЗапуска) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(ПараметрыЗапуска);
	ВызватьОбработчикРасширения("Инициализация", Параметры);
	
КонецПроцедуры

#Область СобытияИсполненияТестов

// Обработчик события "ПередВсемиТестамиМодуля"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
Процедура ПередВсемиТестамиМодуля(ТестовыйМодуль) Экспорт
	
	ЮТКонтекст.УстановитьКонтекстМодуля(Новый Структура());
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль);
	ВызватьОбработкуСобытия("ПередВсемиТестами", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПередТестовымНабором"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
Процедура ПередТестовымНабором(ТестовыйМодуль, Набор) Экспорт
	
	ЮТКонтекст.УстановитьКонтекстНабораТестов(Новый Структура());
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор);
	ВызватьОбработкуСобытия("ПередТестовымНабором", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПередКаждымТестом"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
Процедура ПередКаждымТестом(ТестовыйМодуль, Набор, Тест) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор, Тест);
	ЮТКонтекст.УстановитьКонтекстТеста(Новый Структура());
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	ПолучитьСообщенияПользователю(Истина);
#КонецЕсли
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	Если ВТранзакции(ОписаниеСобытия) Тогда
		НачатьТранзакцию();
	КонецЕсли;
#КонецЕсли
	
	ВызватьОбработкуСобытия("ПередКаждымТестом", ОписаниеСобытия);
	ВызватьОбработкуСобытия("ПередТестом", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПослеКаждогоТеста"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
Процедура ПослеКаждогоТеста(ТестовыйМодуль, Набор, Тест) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор, Тест);
	
	ВызватьОбработкуСобытия("ПослеТеста", ОписаниеСобытия);
	ВызватьОбработкуСобытия("ПослеКаждогоТеста", ОписаниеСобытия);
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	Если ВТранзакции(ОписаниеСобытия) Тогда
		ОтменитьТранзакцию();
		Пока ТранзакцияАктивна() Цикл
			ОтменитьТранзакцию();
			ЮТОбщий.СообщитьПользователю("Обнаружена незакрытая транзакция");
		КонецЦикла;
	КонецЕсли;
#КонецЕсли
	
КонецПроцедуры

// Обработчик события "ПослеТестовогоНабора"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
Процедура ПослеТестовогоНабора(ТестовыйМодуль, Набор) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор);
	ВызватьОбработкуСобытия("ПослеТестовогоНабора", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПослеВсехТестовМодуля"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
Процедура ПослеВсехТестовМодуля(ТестовыйМодуль) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль);
	ВызватьОбработкуСобытия("ПослеВсехТестов", ОписаниеСобытия);
	
КонецПроцедуры

#КонецОбласти

#Область СобытияЗагрузкиТестов

// Обработка события "ПередЧтениеСценариев"
Процедура ПередЧтениеСценариев() Экспорт
	
	Параметры = Новый Массив();
	ВызватьОбработчикРасширения("ПередЧтениеСценариев", Параметры);
	
КонецПроцедуры

// Обработчик события "ПередЧтениемСценариевМодуля"
//  Позволяет настроить базовые параметры перед чтением настроек тестов модуля
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
Процедура ПередЧтениемСценариевМодуля(МетаданныеМодуля) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(МетаданныеМодуля);
	ВызватьОбработчикРасширения("ПередЧтениемСценариевМодуля", Параметры);
	
КонецПроцедуры

// После чтения сценариев модуля.
//  Позволяет настроить/обработать параметры загруженных настроек тестов модуля
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
//  ИсполняемыеСценарии - см. ЮТТесты.СценарииМодуля
Процедура ПослеЧтенияСценариевМодуля(МетаданныеМодуля, ИсполняемыеСценарии) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(МетаданныеМодуля, ИсполняемыеСценарии);
	ВызватьОбработчикРасширения("ПослеЧтенияСценариевМодуля", Параметры);
	
КонецПроцедуры

// Обработка события "ПослеЧтенияСценариев"
// Параметры:
//  Сценарии - Массив из см. ЮТФабрика.ОписаниеТестовогоМодуля - Набор описаний тестовых модулей, которые содержат информацию о запускаемых тестах
Процедура ПослеЧтенияСценариев(Сценарии) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(Сценарии);
	ВызватьОбработчикРасширения("ПослеЧтенияСценариев", Параметры);
	
КонецПроцедуры

// Обработка события "ПослеФормированияИсполняемыхНаборовТестов"
// Параметры:
//  КоллекцияКатегорийНаборов - Массив из см. ЮТФабрика.ОписаниеКатегорияНабораТестов - Набор исполняемых наборов
Процедура ПослеФормированияИсполняемыхНаборовТестов(КоллекцияКатегорийНаборов) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(КоллекцияКатегорийНаборов);
	ВызватьОбработчикРасширения("ПослеФормированияИсполняемыхНаборовТестов", Параметры);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

Процедура ВызватьОбработкуСобытия(ИмяСобытия, ОписаниеСобытия)
	
	ЭтоСобытиеПеред = СтрНачинаетсяС(ИмяСобытия, "Перед");
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(ОписаниеСобытия);
	
	Если ЭтоСобытиеПеред Тогда
		Ошибки = ВызватьОбработчикРасширения(ИмяСобытия, Параметры);
		ВызватьОбработчикТестовогоМодуля(ИмяСобытия, ОписаниеСобытия);
	Иначе
		ВызватьОбработчикТестовогоМодуля(ИмяСобытия, ОписаниеСобытия);
		Ошибки = ВызватьОбработчикРасширения(ИмяСобытия, Параметры);
	КонецЕсли;
	
	Для Каждого Ошибка Из Ошибки Цикл
		ЮТРегистрацияОшибок.ЗарегистрироватьОшибкуСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибка);
	КонецЦикла;
	
КонецПроцедуры

Функция ВызватьОбработчикРасширения(ИмяСобытия, ПараметрыСобытия)
	
	Ошибки = Новый Массив();
	
	Для Каждого ИмяМодуля Из ЮТРасширения.ОбработчикиСобытий() Цикл
		
		Если ЮТОбщий.МетодМодуляСуществует(ИмяМодуля, ИмяСобытия) Тогда
			ПолноеИмяМетода = СтрШаблон("%1.%2", ИмяМодуля, ИмяСобытия);
			Ошибка = ЮТОбщий.ВыполнитьМетод(ПолноеИмяМетода, ПараметрыСобытия);
		КонецЕсли;
		
		Если Ошибка <> Неопределено Тогда
			Ошибки.Добавить(Ошибка);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ошибки;
	
КонецФункции

// Вызвать обработчик модуля.
// 
// Параметры:
//  ИмяСобытия - Строка - Имя вызываемого метода обработки события
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
// 
Процедура ВызватьОбработчикТестовогоМодуля(ИмяСобытия, ОписаниеСобытия)
	
	ИмяМодуля = ОписаниеСобытия.Модуль.МетаданныеМодуля.Имя;
	Ошибка = Неопределено;
	Если ЮТОбщий.МетодМодуляСуществует(ИмяМодуля, ИмяСобытия) Тогда
		
		Команда = СтрШаблон("%1.%2()", ИмяМодуля, ИмяСобытия);
		Ошибка = ЮТОбщий.ВыполнитьМетод(Команда);
		
	КонецЕсли;
	
	Если Ошибка <> Неопределено Тогда
		ЮТРегистрацияОшибок.ЗарегистрироватьОшибкуСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибка);
	КонецЕсли;
	
КонецПроцедуры

Функция ВТранзакции(ОписаниеСобытия)
	
	ИмяПараметра = ЮТФабрика.ПараметрыИсполненияТеста().ВТранзакции;
	
	Возврат ЮТНастройкиВыполнения.ЗначениеНастройкиТеста(ИмяПараметра, ОписаниеСобытия.Тест, ОписаниеСобытия.Набор, Ложь);
	
КонецФункции

#КонецОбласти
