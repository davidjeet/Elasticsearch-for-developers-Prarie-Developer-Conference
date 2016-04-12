using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Nest.Demo
{
    class Program
    {

        static void Main(string[] args)
        {
            var node = new Uri("http://localhost:9200");
            var settings = new ConnectionSettings(node);
            var client = new ElasticClient(settings);

            Person _person = new Person { Id = 9876, First = "Jon", Last = "Snow", Age = 32, LastUpdatedOn = DateTime.Now };
            client.Index(_person, i => i
                .Index("clients")
                .Type("people")
                .Id(_person.Id)

            );

            Console.WriteLine("Done");
            Console.ReadKey();

        }
    }
}
