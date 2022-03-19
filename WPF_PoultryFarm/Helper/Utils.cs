using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DependencyUser.Helpers
{
    // Класс Утилиты
    internal class Utils
    {
        // объект для генерации случайных значений
        public static Random rand = new Random();

        // генерация вещественного числа (min, max]
        public static double GetRand(double min, double max)
        {
            // если диапазон не корректен
            if (min.CompareTo(max) > 0 || max.CompareTo(min) < 0)
                throw new Exception("Utils.GetRand(double min, double max): минимум не может быть больше максимума");

            // число
            double num;

            // генерация числа
            do
            {
                num = rand.Next((int)min, (int)max - 1) + rand.NextDouble();
            } while (num.CompareTo(min) < 0 || num.CompareTo(max) > 0);

            return num;
        }

        // генерация целого числа (min, max]
        public static int GetRand(int min, int max)
        {
            // если диапазон не корректен
            if (min.CompareTo(max) > 0 || max.CompareTo(min) < 0)
                throw new Exception("Utils.GetRand(int min, int max): минимум не может быть больше максимума");

            return rand.Next(min, max);
        }

        // массив названий мастерских
        public static (string Name, string Address)[] repiarShopInfo = new[]{ ("Восток Сервис", "Улица Кольцова, 15"), 
            ("ЧП Телеспец", "Улица Авдеева, 12"), ("Гарант-Сервис", "Бульвар Шевченко, 67"), 
            ("Эксперт-Сервис", "Проспект Ленинский, 4а"), ("Импорт-Сервис", "Проспект Мира, 13") };

        // получить информацию о мастерской
        public static (string Name, string Address) GetInfoRepairShop() => repiarShopInfo[GetRand(0, repiarShopInfo.Length)];


        // диагонали экрана
        public static List<string> Diagonals => new List<string> { "22", "26", "32", "37", "40", "42", "46", "50", "60", "65" };

        // бренды и модели телевизоров
        public static string[] Brands = new[] {
            "Samsung", "AIWA", "Panasonic", "Phillips", "BQ",
            "Sony", "Prestigio", "Xiaomi", "BBK", "DIGMA"
        };
    }
}