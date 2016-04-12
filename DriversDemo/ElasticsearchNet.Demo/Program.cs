using System;
using Elasticsearch.Net;
using Newtonsoft.Json;

namespace ElasticsearchNet.Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            var client = new ElasticLowLevelClient();

            // strongly typed object
            object _person = new Person { Id = 9876, First = "Rob", Last = "Stark", Age = 55, LastUpdatedOn = DateTime.Now };
            client.Index<Person>("clients", "people", new PostData<object>(_person));


            // generic object
            object _person2 = new { Id = 9876, First = "Jamie", Last = "Lannister" };
            client.Index<object>("clients", "people", new PostData<object>(_person2));

        }
    }
}
