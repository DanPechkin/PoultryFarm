using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Metadata.Edm;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Poultry_farm;

namespace ConsoleAppTest
{
    class Program
    {
        static void Main(string[] args)
        {
            // проверка Запроса 1
            var result  = Controllers.Query1(2.4, 7, "Русская белая");

            foreach (var item in result)
            {
                Console.WriteLine($" {item.BreedName} {item.ChickenWeight} {item.NumberofEggs} ");
            }

            // проверка Запроса 2
            var result2 = Controllers.Query2("Русская белая");

            Console.WriteLine($" {result2.BreedName} {result2.CountMax} {result.Count}");

            //проверка Запроса 3

            var result3 = Controllers.Query3(15, 2);

            foreach (var item in result3)
            {
                Console.WriteLine($" {item.ChickenAge} {item.DietNumber} {item.NumberOfCages}");   
            }


            //проверка Запроса 4

            var result4 = Controllers.Query4("Шастина");

            foreach (var item in result4)
            {
                Console.WriteLine($" {item.Surname} {item.ChickenId} {item.NumberOfEggs}");   
            }

            //проверка Запроса 5 

            var result5 = Controllers.Query5();

            foreach (var item in result5)
            {
                Console.WriteLine($" {item.Surname} {item.AverageEggs:f} {item.IdChicken}");
            }


            Console.ReadKey();

            //проверка Запрос 6 
             var result6 = Controllers
        }
    }
}
