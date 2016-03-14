using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Elasticsearch.Net;

namespace ElasticsearchNet.Demo
{
    class Program
    {
        private static Movie _movie = new Movie { Id = 400, Title = "Gladiator 2", AvailableOnNetflix = false, CreatedOn = new DateTime(2000, 10, 13) };

        static void Main(string[] args)
        {
            var client = new ElasticLowLevelClient();
            client.Index<Movie>("500", "Movie", new PostData<Movie>(_movie));
            //index a document under /myindex/mytype/1
            ////var myJson = @"{ ""hello"" : ""world"" }";
            ////client.Index("myindex", "mytype", "1", myJson);

            //var myJson = new { hello = "world" };
            //client.Index("myindex", "mytype", "1", new PostData<string>(myJson));


            //var indexResponse = client.Index("myindex", "mytype", "1", new { Hello = "World" });
        }
    }
}
