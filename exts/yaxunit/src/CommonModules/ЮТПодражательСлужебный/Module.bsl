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

#Область СлужебныйПрограммныйИнтерфейс

// Получает список из словаря с учетом установленной локализации
//
// Параметры:
//  ИмяРеализации - Строка - Имя реализации
//  ИмяСловаря - Строка - Имя словаря
//  КодЛокализации - Строка - Код локализации, по умолчанию берется из контекста
//
// Возвращаемое значение:
//	ФиксированныйМассив из Строка
Функция Словарь(ИмяРеализации, ИмяСловаря, КодЛокализации = Неопределено) Экспорт
	_КодЛокализации = ?(КодЛокализации = Неопределено, ЮТПодражатель.Локализация(), КодЛокализации);
	Возврат ЮТПодражательПовтИсп.Словарь(ИмяРеализации, ИмяСловаря, _КодЛокализации);
КонецФункции

// Случайное значение из словаря.
//
// Параметры:
//  Словарь - Массив из Строка - Словарь
//
// Возвращаемое значение:
// 	- Строка
Функция СлучайноеЗначениеИзСловаря(Словарь) Экспорт
	Возврат Словарь.Получить(ЮТТестовыеДанные.СлучайноеЧисло(0, Словарь.ВГраница()));
КонецФункции

// Контекст.
//
// Возвращаемое значение:
//  см. НовыйКонтекст
Функция Контекст() Экспорт
	//@skip-check constructor-function-return-section
	Возврат ЮТКонтекст.ЗначениеКонтекста(КлючКонтекста());
КонецФункции

// Инициализирует подражатель
//
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Инициализировать() Экспорт
	Если Контекст() = Неопределено Тогда
		ЮТКонтекст.УстановитьЗначениеКонтекста(КлючКонтекста(), НовыйКонтекст());
	КонецЕсли;
	Возврат ЮТПодражатель;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КлючКонтекста()
	Возврат "Подражатель";
КонецФункции

// Новый контекст.
//
// Возвращаемое значение:
//  Структура - Новый контекст:
// * Локализация - Строка - Установленная локализация
Функция НовыйКонтекст()

	Описание = Новый Структура;
	Описание.Вставить("Локализация", ЮТЛокальСлужебный.ЛокальИнтерфейса());
	Возврат Описание;

КонецФункции

#КонецОбласти
