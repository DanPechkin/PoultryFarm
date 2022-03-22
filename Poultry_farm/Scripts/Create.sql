/*
База данных "Птицефабрика"

Ориентирована на администрацию птицефабрики и позволяющую работать с 
информацией о работниках фабрики и об имеющихся на ней курах, содержащая следующую информацию 
   * вес курицы, 
   * возраст, 
   * порода, 
   * количество ежемесячно получаемых от курицы яиц, 
   * информация о местонахождении курицы
Сведения о породе включают: 
   * название породы, 
   * среднее количество яиц в месяц (производительность) 
   * средний вес, 
   * номер рекомендованной диеты. 
Сведения о клекте:
    * номер цеха
    * номер ряда в цеху
    * номер клетки в ряду
Сведения о работниках:
    * номер паспорта
    * зарплата
    * закрепленнне за работником клетки


*/
-- удаление таблиц 
drop table if exists Workshop 
drop table if exists Cages 
drop table if exists Workers
drop table if exists Production
drop table if exists Chickens
drop table if exists Breeds
drop table if exists Diets

--диета 
create table Diets 
(
    Id     int not null primary key identity (1,1), 
    Number int not null 
);

-- порода кур 
create table Breeds (
        Id                int          not null primary key identity (1,1),
        BreedName         nvarchar(60) not null,                            -- название породы 
        AverageEggsNumber int          not null,                            -- среднее количество яиц
        AverageWeight     float        not null,                            -- средний вес курицы
        IdDietNumber      int          not null                             -- внешний ключ, номер диеты

        constraint FK_Breeds_Diet foreign key (IdDietNumber) references dbo.Diets(Id),
        constraint CK_Breed_Average_Weight check ([AverageWeight] >=0)
);

-- курица
create table Chickens (
        Id                 int   not null  primary key identity (1,1),
        IdBreed            int   not null,                            -- внешний ключ, ссылка на порода
        ChickenWeight      float not null,                            -- вес курицы
        ChickenAge         int   not null,                            -- возраст курицы в месяцах
        

 --внешние ключи 
       constraint FK_Chicken_Breed foreign key (IdBreed) references dbo.Breeds(Id),
       
);
-- цех
create table Workshop (
        Id                int          not null primary key identity(1,1),
        ShopName          nvarchar(60) not null,          -- название цеха
        NumberOfRows      int          not null,          -- количество рядов
        NumberOfCages     int          not null           -- количество клеток
);

-- работник птицефабрики
create table Workers (
        Id                  int          not null primary key identity (1,1),
        IdWorkshop          int          not null,                        --внешний ключ для цеха
        Surname             nvarchar(60) not null,                       -- фамилия
        [Name]              nvarchar(60) not null,                       -- имя
        Patronymic          nvarchar(60) not null,                       -- отчество
        Passport            nvarchar(15) not null,                       -- номер паспорта 
        Salary              int          not null,                       -- зарплата
        Fired               bit                                          -- признак уволенности  
        --внешний ключ
    constraint FK_Workers_Workshop foreign key (IdWorkshop) references dbo.Workshop(Id) ON DELETE NO ACTION

        
);


--клектка 
create table Cages (
        Id                 int   not null  primary key identity (1,1),
        IdWorkshop         int   not null,                           -- внешний ключ, связь с цехом
        IdChicken          int   not null,                           -- внешний ключ, связь с курицей
        IdWorker           int   not null,                           -- внешний ключ, с работником 
        RowNumber          int   not null,                           -- номер ряда в цеху
        CageNumber         int   not null,                           -- номер клетки в ряду  

       --внешние ключи 
       constraint FK_Cages_Workshop foreign key (IdWorkshop) references dbo.Workshop(Id),
       constraint FK_Cages_Chicken  foreign key (IdChicken)  references dbo.Chickens(Id), 
       constraint FK_Cages_Worker  foreign key (IdWorker)   references dbo.Workers(Id)
        
);



--производство 
create table Production 
(     
        Id             int    not null primary key, 
        [Data]         date   not null,                      -- дата
        NumberOfEggs   int    not null,                      -- количество яиц

    -- внешний ключ
    constraint FK_Production_Chicken foreign key (Id) references dbo.Chickens(Id)
);
