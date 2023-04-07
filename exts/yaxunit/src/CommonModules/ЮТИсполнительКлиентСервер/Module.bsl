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
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

// Выполняет тесты группы наборов, соответствующих одному режиму выполнения (клиент/сервер) 
// Параметры:
//  Наборы - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов 
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
// 
// Возвращаемое значение:
//  Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов - Результат прогона наборов тестов с заполненной информацией о выполнении
Функция ВыполнитьГруппуНаборовТестов(Наборы, ТестовыйМодуль) Экспорт
	
	Если Наборы.Количество() = 0 Тогда
		Возврат Наборы;
	КонецЕсли;
	
	Уровни = ЮТФабрика.УровниИсполнения();
	ЮТКонтекст.КонтекстИсполнения().Уровень = Уровни.Модуль;
	
	ЮТСобытия.ПередВсемиТестамиМодуля(ТестовыйМодуль);
	
	Если ЕстьОшибки(ТестовыйМодуль) Тогда
		СкопироватьОшибкиВ(Наборы, ТестовыйМодуль.Ошибки);
		Возврат Наборы;
	КонецЕсли;
	
	Для Каждого Набор Из Наборы Цикл
		
		Результат = ВыполнитьНаборТестов(Набор, ТестовыйМодуль);
		
		Если Результат <> Неопределено Тогда
			Набор.Тесты = Результат;
		КонецЕсли;
		
	КонецЦикла;
	
	ЮТКонтекст.КонтекстИсполнения().Уровень = Уровни.Модуль;
	
	ЮТСобытия.ПослеВсехТестовМодуля(ТестовыйМодуль);
	
	Если ЕстьОшибки(ТестовыйМодуль) Тогда
		СкопироватьОшибкиВ(Наборы, ТестовыйМодуль.Ошибки);
	КонецЕсли;
	
	ТестовыйМодуль.Ошибки.Очистить(); // Эти ошибки используются как буфер и уже скопированы в наборы, но ломают последующие наборы
	
	Возврат Наборы;
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныеПроцедурыИФункции

Функция ВыполнитьНаборТестов(Набор, ТестовыйМодуль)
	
	Уровни = ЮТФабрика.УровниИсполнения();
	ЮТКонтекст.КонтекстИсполнения().Уровень = Уровни.НаборТестов;
	
	Набор.ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
	ЮТСобытия.ПередТестовымНабором(ТестовыйМодуль, Набор);
	
	Если ЕстьОшибки(Набор) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Результаты = Новый Массив();
	ЮТКонтекст.КонтекстИсполнения().Уровень = Уровни.Тест;
	
	Для Каждого Тест Из Набор.Тесты Цикл
		
		Тест.ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
		
		ЮТСобытия.ПередКаждымТестом(ТестовыйМодуль, Набор, Тест);
		ВыполнитьТестовыйМетод(Тест);
		ЮТСобытия.ПослеКаждогоТеста(ТестовыйМодуль, Набор, Тест);
		
		ОбработатьЗавершениеТеста(Тест);
		
		Результаты.Добавить(Тест);
		
	КонецЦикла;
	
	ЮТКонтекст.КонтекстИсполнения().Уровень = Уровни.НаборТестов;
	ЮТСобытия.ПослеТестовогоНабора(ТестовыйМодуль, Набор);
	
	Набор.Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - Набор.ДатаСтарта;
		
	Возврат Результаты;
	
КонецФункции

Процедура ОбработатьЗавершениеТеста(Тест)
	
	Тест.Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - Тест.ДатаСтарта;
	Тест.Статус = ЮТРегистрацияОшибок.СтатусВыполненияТеста(Тест);
	
КонецПроцедуры

Функция ЕстьОшибки(Объект)
	
	Возврат ЗначениеЗаполнено(Объект.Ошибки);
	
КонецФункции

Процедура ВыполнитьТестовыйМетод(Тест)
	
	Если ЕстьОшибки(Тест) Тогда
		Возврат;
	КонецЕсли;
	
	СтатусыИсполненияТеста = ЮТФабрика.СтатусыИсполненияТеста();
	Тест.Статус = СтатусыИсполненияТеста.Исполнение;
	
	Ошибка = ЮТОбщий.ВыполнитьМетод(Тест.ПолноеИмяМетода, Тест.Параметры);
	
	Если Ошибка <> Неопределено Тогда
		ЮТРегистрацияОшибок.ЗарегистрироватьОшибкуВыполненияТеста(Тест, Ошибка);
	КонецЕсли;
	
КонецПроцедуры

Процедура СкопироватьОшибкиВ(Объекты, Ошибки)
	
	Для Каждого Объект Из Объекты Цикл
		
		ЮТОбщий.ДополнитьМассив(Объект.Ошибки, Ошибки);
		
		Если Объект.Свойство("Статус") Тогда
			Объект.Статус = ЮТФабрика.СтатусыИсполненияТеста().Сломан;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
