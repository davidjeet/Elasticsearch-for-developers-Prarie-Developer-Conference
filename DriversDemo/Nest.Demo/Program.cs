using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Nest.Demo
{
    class Program
    {
        private static Movie2 _movie = new Movie2 { Id = "888", Title = "Lastyy of the Mohicans", AvailableOnNetflix = true, CreatedOn = new DateTime(1993, 2, 26) };
        //private static Person _person = new Person { Id = 12345, First = "Kwame", Last = "Harris" };
        //private static Person _person = new Person { Id = 2468, First = "Shantanu", Last = "Dutt" };
        //private static Person _person = new Person { Id = 1001, First = "Cersei", Last = "Jeetah", Age = 40 };
        private static Person _person = new Person { Id = 9876, First = "Jimmy", Last = "O'Fallon", Age=32, LastUpdatedOn = DateTime.Now };


        static void Main(string[] args)
        {
            var node = new Uri("http://localhost:9200");
            var settings = new ConnectionSettings(node);
            var client = new ElasticClient(settings);

            //index a document under /myindex/mytype/1
            ////client.Index(_movie);

            var index = client.Index(_person, i => i
                .Index("clients")
                .Type("people")
                .Id(_person.Id)
                ////.Refresh()
                ////.Ttl("1m")
            );

        //    Console.WriteLine("Person ID: " + index.Id);

        //    var person2 = new { Id = 5052, First = "Tim2", Last = "Larson2" };
        //    index = client.Index(person2, i => i
        //    .Index("clients")
        //    .Type("people")
        //    .Id(person2.Id)
        //    .Refresh()
        //    .Ttl("1m")
        //);

        //    Console.WriteLine("Person ID: " + index.Id);


            ////client.Index(_movie, i => i
            ////            .Index("AlphaIndex")
            ////            .Type("BetaType")
            ////            .Id("AAAAAAAAAAAAAAAAAAA")
            ////            //.Refresh()
            ////            //.Ttl("1m")
            ////);



            Console.WriteLine("Done");
            Console.ReadKey();
            ////var indexResponse = client.Index("myindex", "mytype", "1", new { Hello = "World" });
        }
    }
}
