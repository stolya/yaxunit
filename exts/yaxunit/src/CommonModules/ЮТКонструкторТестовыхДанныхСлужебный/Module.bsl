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

Процедура Установить(Контекст, ИмяРеквизита, Значение) Экспорт
	
	Если ЗначениеЗаполнено(Контекст.ТекущаяТабличнаяЧасть) Тогда
		ТекущаяЗапись = ДанныеСтроки(Контекст);
	Иначе
		ТекущаяЗапись = Контекст.Данные;
	КонецЕсли;
	
	ТекущаяЗапись.Вставить(ИмяРеквизита, Значение);
	
КонецПроцедуры

Процедура Фикция(Контекст, ИмяРеквизита, РеквизитыЗаполнения, Знач ОграничениеТипа) Экспорт
	
	ЮТПроверкиСлужебный.ПроверитьТипПараметра(ОграничениеТипа, "Тип, ОписаниеТипов, Строка", "Фикция", "ЮТКонструкторТестовыхДанных", Истина);
	
	Если ЗначениеЗаполнено(Контекст.ТекущаяТабличнаяЧасть) Тогда
		ОписаниеРеквизита = Контекст.Метаданные.ТабличныеЧасти[Контекст.ТекущаяТабличнаяЧасть][ИмяРеквизита];
		ТекущаяЗапись = ДанныеСтроки(Контекст);
	Иначе
		ОписаниеРеквизита = Контекст.Метаданные.Реквизиты[ИмяРеквизита];
		ТекущаяЗапись = Контекст.Данные;
	КонецЕсли;
	
	Если ОграничениеТипа <> Неопределено Тогда
		ПолноеИмяРеквизита = ЮТОбщий.ДобавитьСтроку(Контекст.ТекущаяТабличнаяЧасть, ИмяРеквизита, ".");
		ТипЗначения = ПересечениеТипов(ОписаниеРеквизита.Тип, ОграничениеТипа, ПолноеИмяРеквизита);
	Иначе
		ТипЗначения = ОписаниеРеквизита.Тип;
	КонецЕсли;
	
	Значение = ЮТТестовыеДанныеСлужебный.Фикция(ТипЗначения, РеквизитыЗаполнения);
	ТекущаяЗапись.Вставить(ИмяРеквизита, Значение);
	
КонецПроцедуры

Процедура ФикцияОбязательныхПолей(Контекст) Экспорт
	
	Если ЗначениеЗаполнено(Контекст.ТекущаяТабличнаяЧасть) Тогда
		Реквизиты = Контекст.Метаданные.ТабличныеЧасти[Контекст.ТекущаяТабличнаяЧасть];
		ТекущаяЗапись = ДанныеСтроки(Контекст);
	Иначе
		Реквизиты = Контекст.Метаданные.Реквизиты;
		ТекущаяЗапись = Контекст.Данные;
	КонецЕсли;
	
	Для Каждого Элемент Из Реквизиты Цикл
		Реквизит = Элемент.Значение;
		Если Реквизит.Обязательный И НЕ ТекущаяЗапись.Свойство(Реквизит.Имя) Тогда
			Значение = ЮТТестовыеДанныеСлужебный.Фикция(Реквизит.Тип);
			ТекущаяЗапись.Вставить(Реквизит.Имя, Значение);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ТабличнаяЧасть(Контекст, ИмяТабличнойЧасти) Экспорт
	
	Контекст.ТекущаяТабличнаяЧасть = ИмяТабличнойЧасти;
	
	Если ИмяТабличнойЧасти <> Неопределено Тогда
		Контекст.Данные.Вставить(ИмяТабличнойЧасти, Новый Массив());
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьСтроку(Контекст) Экспорт
	
	Запись = Новый Структура();
	ДанныеТабличнойЧасти(Контекст).Добавить(Запись);
	
КонецПроцедуры

Процедура УстановитьДополнительноеСвойство(Контекст, ИмяСвойства, Значение = Неопределено) Экспорт
	
	Контекст.ДополнительныеСвойства.Вставить(ИмяСвойства, Значение);
	
КонецПроцедуры

Функция Записать(Контекст, ВернутьОбъект = Ложь, ОбменДаннымиЗагрузка = Ложь) Экспорт
	
	ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	ПараметрыЗаписи.ДополнительныеСвойства = Контекст.ДополнительныеСвойства;
	ПараметрыЗаписи.ОбменДаннымиЗагрузка = ОбменДаннымиЗагрузка;
	
	Ссылка = ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Контекст.Менеджер, Контекст.Данные, ПараметрыЗаписи, ВернутьОбъект);
	
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

Функция НовыйОбъект(Контекст) Экспорт
	
	Возврат ЮТТестовыеДанныеВызовСервера.НовыйОбъект(Контекст.Менеджер, Контекст.Данные, Контекст.ДополнительныеСвойства);
	
КонецФункции

Функция Провести(Контекст, ВернутьОбъект = Ложь) Экспорт
	
	ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	ПараметрыЗаписи.ДополнительныеСвойства = Контекст.ДополнительныеСвойства;
	ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение;
	
	Ссылка = ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Контекст.Менеджер, Контекст.Данные, ПараметрыЗаписи, ВернутьОбъект);
	
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

Функция ДанныеСтроки(Контекст) Экспорт
	
	Если ПустаяСтрока(Контекст.ТекущаяТабличнаяЧасть) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ДанныеТабличнойЧасти = ДанныеТабличнойЧасти(Контекст);
	
	Если ДанныеТабличнойЧасти.Количество() Тогда
		Возврат ДанныеТабличнойЧасти[ДанныеТабличнойЧасти.ВГраница()];
	Иначе
		ВызватьИсключение "Сначала необходимо добавить строку табличной части";
	КонецЕсли;
	
КонецФункции

Функция ДанныеОбъекта(Контекст) Экспорт
	
	Возврат Контекст.Данные;
	
КонецФункции

// Инициализирует конструктор тестовых данных
// 
// Параметры:
//  Менеджер - Строка - Имя менеджера. Примеры: Справочники.Товары, Документы.ПриходТоваров
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТКонструкторТестовыхДанных
Функция Инициализировать(Менеджер) Экспорт
	
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Тогда
	Конструктор = Обработки.ЮТКонструкторТестовыхДанных.Создать();
#Иначе
	Конструктор = ПолучитьФорму("Обработка.ЮТКонструкторТестовыхДанных.Форма.КлиентскийКонструктор"); // BSLLS:GetFormMethod-off
#КонецЕсли
	
	Конструктор.Инициализировать(Менеджер);
	
	Возврат Конструктор;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Новый контекст конструктора.
// 
// Параметры:
//  Менеджер - Произвольный
// 
// Возвращаемое значение:
//  Структура - Новый контекст конструктора:
//  * Менеджер - Произвольный
//  * Данные - Структура
//  * Метаданные - см. ЮТМетаданные.ОписаниеОбъектаМетаданных
//  * ТекущаяТабличнаяЧасть - Строка
//  * ДополнительныеСвойства - Структура
Функция НовыйКонтекстКонструктора(Менеджер) Экспорт
	
	Контекст = Новый Структура("Менеджер, Данные, Метаданные", Менеджер, Новый Структура());
	Контекст.Вставить("Менеджер", Менеджер);
	Контекст.Вставить("Данные", Новый Структура());
	Контекст.Вставить("Метаданные", ЮТМетаданные.ОписаниеОбъектаМетаданных(Менеджер));
	Контекст.Вставить("ТекущаяТабличнаяЧасть", "");
	Контекст.Вставить("ДополнительныеСвойства", Новый Структура());
	
	Возврат Контекст;
	
КонецФункции

Функция ДанныеТабличнойЧасти(Контекст)
	
	Возврат Контекст.Данные[Контекст.ТекущаяТабличнаяЧасть];
	
КонецФункции

Функция ПересечениеТипов(Знач ОписаниеТипов, Знач ОграничениеТипов, ИмяРеквизита)
	
	ТипОграничения = ТипЗнч(ОграничениеТипов);
	
	Если ТипОграничения = Тип("Строка") Тогда
		ОграничениеТипов = Новый ОписаниеТипов(ОграничениеТипов);
		ТипОграничения = Тип("ОписаниеТипов");
	КонецЕсли;
	
	Если ТипОграничения = Тип("Тип") И ОписаниеТипов.СодержитТип(ОграничениеТипов) И ОграничениеТипов <> Тип("Неопределено") Тогда
		Результат = ЮТОбщий.ЗначениеВМассиве(ОграничениеТипов);
	ИначеЕсли ТипОграничения = Тип("ОписаниеТипов") Тогда
		Результат = ЮТОбщий.ПересечениеМассивов(ОписаниеТипов.Типы(), ОграничениеТипов.Типы());
	Иначе
		Результат = Неопределено;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Результат) Тогда
		
		Сообщение = СтрШаблон("Исправьте ограничение типов для реквизита `%1` (`%2`), оно не входит в множество типов реквизита (`%3`)",
							  ИмяРеквизита,
							  ОграничениеТипов,
							  ОписаниеТипов);
		ВызватьИсключение Сообщение;
		
	КонецЕсли;
	
	Возврат Новый ОписаниеТипов(Результат,
								ОписаниеТипов.КвалификаторыЧисла,
								ОписаниеТипов.КвалификаторыСтроки,
								ОписаниеТипов.КвалификаторыДаты,
								ОписаниеТипов.КвалификаторыДвоичныхДанных);
	
КонецФункции

#КонецОбласти
