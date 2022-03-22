
--Запрос 1.  Количество яиц от каждой курицы данного веса, породы и возраста 
declare @weight float = 2.4, @breed nvarchar(max) = N'Русская белая', @age int =7
select  
      Breeds.BreedName,
      Chickens.ChickenWeight,
      Production.NumberOfEggs
from  Production
      Join Chickens on Production.IdChicken = Chickens.Id
      Join Breeds on Chickens.IdBreed = Breeds.Id
where 
      Chickens.ChickenWeight = @weight and 
      Chickens.ChickenAge = @age and
      Breeds.BreedName = @breed
go

--Запрос 2. В каком цеху наибольшее количество кур определенной породы? 
declare @breed nvarchar(max) = N'Русская белая'

select 
    Top(1)
    BreedName
    ,Workshop.ShopName
    ,Count(Chickens.Id) as CountMax
from 
    Chickens
    Join Breeds on Chickens.IdBreed = Breeds.Id
    Join Cages on Cages.IdChicken = Chickens.Id
    Join Workshop on Cages.IdWorkshop = Workshop.Id
Group by 
         Workshop.ShopName,
         BreedName
Having BreedName = @breed 
Order by  CountMax desc
go

--Запрос 3. В каких клетках находятся куры указанного возраста с заданным номером диеты? 
declare @age int = 15, @diet int  = 2 
select 
      Cages.Id as NumberOfCage
     ,ChickenAge
     ,Diets.Number as DietNumber
from 
    Chickens
    Join Cages  on Cages.IdChicken = Chickens.Id
    Join Breeds on Chickens.IdBreed = Breeds.Id
    Join Diets  on Breeds.IdDietNumber = Diets.Id 
Where
    ChickenAge = @age and Number = @diet

-- Запрос 4. Сколько яиц в день приносят куры, указанного работника
 declare @workerSurname nvarchar(60) = N'Шастина'
 select 
       Workers.Surname
       ,Production.NumberOfEggs
       , Chickens.Id as ChickeId
 from 
      Production
      Join Chickens on Production.Id = Chickens.Id
      Join Cages on Cages.IdChicken = Chickens.Id
      Join Workers on Cages.IdWorker = Workers.Id
Where
      Surname = @workerSurname
go
      
--Запрос 5 Среднее количество яиц, которое получает в день каждый работник от обслуживаемых им кур?
select
      Workers.Surname
      ,AVG(Production.NumberOfEggs) as AverageEggsPerDay
      
from 
      Cages
      Join Chickens on Cages.IdChicken = Chickens.Id
      Join Workers on Cages.IdWorker = Workers.Id
      Join Production on Chickens.Id = Production.Id
Group by 
        Workers.Surname
        
go

-- Запрос 6. В каком цеху курица, от которой получают больше всего яиц
select 
      Top(1)
     Chickens.Id as ChickensId
     , Workshop.ShopName
     , Production.NumberOfEggs
from 
     Production
     Join Chickens on Production.IdChicken = Chickens.Id
     Join Cages    on Cages.IdChicken = Chickens.Id
     Join Workshop on Cages.IdWorkshop = Workshop.Id 
Order by NumberOfEggs desc
go

-- Запрос 7 Сколько кур каждой породы в каждом цехе?
select 
      BreedName
     ,Count(Breeds.BreedName) as NumberOfBreed
     , Workshop.ShopName
from 
    Chickens
    Join Breeds on Chickens.IdBreed = Breeds.Id
    Join Cages on Cages.IdChicken = Chickens.Id
    Join Workshop on Cages.IdWorkshop = Workshop.Id
Group by
        BreedName,
        Workshop.ShopName
go

 -- Запрос 8. Какое количество кур обслуживает каждый работник
select
       Workers.Surname
       ,COUNT(Chickens.Id) as NumberOfChickens
from 
     Workers
     Join Cages    on Cages.IdWorker = Workers.Id
     Join Chickens on Cages.IdChicken = Chickens.Id
Group by
     Workers.Surname
go

-- Запрос 9.Какова для каждой породы разница между показателями породы и средними показателями по птицефабрике?