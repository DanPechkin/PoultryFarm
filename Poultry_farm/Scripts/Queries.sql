
--Запрос 1.  Количество яиц от каждой курицы данного веса, породы и возраста 
declare @weight float = 2.7, @breed nvarchar(max) = N'Русская белая', @age int =1
select * from  Chickens
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
    ,WorkshopNumber
    ,Count(Chickens.Id) as CountMax
from 
    Chickens
    Join Cages on Chickens.IdCage = Cages.Id
    Join Breeds on Chickens.IdBreed = Breeds.Id
Group by WorkshopNumber,
         BreedName
Having BreedName = @breed 
Order by  CountMax desc

--Запрос 3. В каких клетках находятся куры указанного возраста с заданным номером диеты? 
declare @age int = 15, @diet int  = 2 
select 
     Cages.Id
     ,ChickenAge
     ,DietNumber
from 
    Chickens
    Join Cages on Chickens.IdCage = Cages.Id
    Join Breeds on Chickens.IdBreed = Breeds.Id
Where
    ChickenAge = @age and DietNumber = @diet

-- Запрос 4. Сколько яиц в день приносят куры, указанного работника

-- Запрос 6. В каком цеху курица, от которой получают больше всего яиц
select 
      Top(1)
     Chickens.Id
     , Cages.WorkshopNumber
     , EggsNumber
from 
     Chickens
     Join Cages on Chickens.IdCage = Cages.Id
     Join Breeds on Chickens.IdBreed = Breeds.Id
Order by EggsNumber desc

-- Запрос 7 Сколько кур каждой породы в каждом цехе?
select 
      BreedName
     ,Count(Breeds.BreedName) as BreedNumber
     , Cages.WorkshopNumber
from 
    Chickens
    Join Cages on Chickens.IdCage = Cages.Id
    Join Breeds on Chickens.IdBreed = Breeds.Id
Group by
        BreedName,
        WorkshopNumber

 -- Запрос 8. Какое количество кур обслуживает каждый работник
 select 
       Count (Workshop.IdCage) as ChickenNumber
       , Workers.Id
from 
         
   
     

      
       