using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using Poultry_farm.Models;

namespace Poultry_farm
{
    public static class Controllers
    {
        //Запрос 1. 
        public static ICollection<Query1> Query1(double weight, int age, string breed)
        {
            using (PoultryFarmEntities context = new PoultryFarmEntities())
            {
                var result = context.Production
                    .Where(p => Math.Abs(p.Chickens.ChickenWeight - weight) < 0.1 &&
                                p.Chickens.ChickenAge == age &&
                                p.Chickens.Breeds.BreedName == breed)
                    .Select(a => new Query1()
                    {
                        BreedName = a.Chickens.Breeds.BreedName,
                        ChickenWeight = a.Chickens.ChickenWeight,
                        NumberofEggs = a.NumberOfEggs
                    });

                return result.ToList();
            }
        }

        //Запрос 2. 

        public static Query2 Query2(string breedname)
        {
            /*
            
            Исходные данные для GroupBy
        
            Cage1 
                Wowkrshop - 1
                Chicken - "Быстрая"
            Cage2 
                Wowkrshop - 1
                Chicken - "Быстрая"
            Cage3 
                Wowkrshop - 1
                Chicken - "Медленная"
            Cage4
                Wowkrshop - 2
                Chicken - "Быстрая"

            Результат работы GroupBy в запросе ниже 

            Dictionary [
                {Workshop - 1, Chicken - "Быстрая"} = [Cage1, Cage2],
                {Workshop - 1, Chicken - "Медленная"} = [Cage3],
                {Workshop - 2, Chicken - "Быстрая"} = [Cage4]
            ]

             */
            using (PoultryFarmEntities context = new PoultryFarmEntities())
            {
                var result = context.Cages
                    .Where(cage => cage.Chickens.Breeds.BreedName == breedname)
                    .GroupBy(cage => new {cage.Workshop.ShopName, cage.Chickens.Breeds.BreedName})
                    .Select(g => new Query2
                    {
                        BreedName = g.Key.BreedName,
                        ShopName = g.Key.ShopName,
                        CountMax = g.Count()
                    })
                    .OrderByDescending(q => q.CountMax)
                    .First();
                return result;
            }

        }

        //Запрос 3
        public static ICollection<Query3> Query3(int age, int diet)
        {
            using (PoultryFarmEntities context = new PoultryFarmEntities())
            {
                var result = context.Cages
                    .Where(c => c.Chickens.ChickenAge == age && c.Chickens.Breeds.Diets.Number == diet)
                    .Select(g => new Query3
                    {
                        NumberOfCages = g.Id,
                        ChickenAge = g.Chickens.ChickenAge,
                        DietNumber = g.Chickens.Breeds.Diets.Number
                    });

                return result.ToList();
            }

            
        }

        // Запрос 4
        public static ICollection<Query4> Query4(string surname)
        {
            using (PoultryFarmEntities context = new PoultryFarmEntities())
            {
                var result = context.Cages
                    .Where(p => p.Workers.Surname == surname)
                    .Select(c => new Query4
                    {
                        Surname = c.Workers.Surname,
                        NumberOfEggs = c.Chickens.Production.NumberOfEggs,
                        ChickenId = c.IdChicken
                    });
                return result.ToList();
            }
        }

        //Запрос 5 Среднее количество яиц, которое получает в день каждый работник от обслуживаемых им кур
        public static ICollection<Query5> Query5()
        {
            using (PoultryFarmEntities context = new PoultryFarmEntities())
            {
                var result = context.Cages
                    .GroupBy(c => c.Workers.Surname)
                    .Select(c => new Query5
                    {
                        AverageEggs = c.Average(a => a.Chickens.Production.NumberOfEggs),
                        Surname = c.Key
                        
                    });

                return result.ToList();
            }
        }


    }
}
