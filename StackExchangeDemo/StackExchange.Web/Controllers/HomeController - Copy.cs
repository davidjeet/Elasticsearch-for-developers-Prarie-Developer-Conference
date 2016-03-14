using MongoDB.Driver;
using MongoDB.Driver.Linq;
using StackExchangeModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Diagnostics;
using Nest;
using System.ComponentModel.DataAnnotations;

namespace StackExchange.Web.Controllers
{
    public class HomeController : Controller
    {
        private static MongoClient mongoClient;
        private static MongoServer mongoServer;
        private static MongoDatabase mongoDatabase;
        private static MongoCollection<Post> mongoCollection;
        private const string INDEX = "stackexchange";
        private const string INDEXTYPE = "cooking";

        public HomeController()
        {
            mongoClient = new MongoClient("mongodb://localhost:27017");
            mongoServer = mongoClient.GetServer();
            mongoDatabase = mongoServer.GetDatabase("stackexchange");
            ViewBag.Message = "";
        }
        
        public ActionResult Index()
        {
            mongoCollection = mongoDatabase.GetCollection<Post>("posts");
            var vm = mongoCollection.AsQueryable().OrderByDescending(x=>x.CreationDate).Take(10);
            return View(vm);
        }

        public ActionResult ReIndex()
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();

            mongoCollection = mongoDatabase.GetCollection<Post>("posts");
            foreach (var post in mongoCollection.FindAll())
            {
                var simplePost = new SimplePost
                {
                    Id = post.Id,
                    Title = post.Title,
                    //Body = post.Body
                };
                //ElasticClient.DeleteIndex(INDEX);
                //ElasticClient.Index(simplePost, INDEX, INDEXTYPE, post.Id);
                //ElasticClient.Index(simplePost, INDEX, INDEXTYPE, post.Id);
                ElasticClient.Index( simplePost , "myindex", "simpleposts", post.Id);
            }

            sw.Stop();
            var result = string.Format("Time to re-index elasticsearch took: {0}.{1} seconds", sw.Elapsed.Seconds, sw.Elapsed.Milliseconds);
            ViewBag.Message = result;
            Debug.WriteLine(result);

            return View();
        }

        /// <summary>
        /// Fuzzy Search
        /// </summary>
        /// <param name="q">Query String param</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Search(string q)
        {

            //var result = ElasticClient.Search<Post>(x => x.Query(query
            //                                    => query.Fuzzy(fz
            //                                        => fz.OnField(f
            //                                            => f.Title).Value(q)
            //                                            //.MinSimilarity(0)
            //                                            //.PrefixLength(0)
            //                                       )
            //                                    )
            //                                    //.Take(10)
            //                              );


            //var result = ElasticClient.Search<Post>(s => s
            //            .From(0)
            //            .Size(10)
            //   .QueryRaw("\"match_all\" : { }")
            //);

            //var result2 = ElasticClient2.Search<Album>(s => s
            //            .From(0)
            //            .Size(10)
            //   .QueryRaw("\"match_all\" : { }")
            //);

            //var result = ElasticClient.Search<Post>(body =>
            //                 body.Query(query =>
            //                    query.QueryString(qs => qs.Query(q))));

            var setting = new ConnectionSettings(new Uri("http://localhost:9200"));
            setting.SetDefaultIndex("myindex");
            var client = new ElasticClient(setting);
            var result = client.Search<SimplePost>(body =>
                             body.From(0).Size(10).MatchAll());

            //var result3 = ElasticClient2.Search<Album>(body =>
            //                 body.From(0).Size(10).MatchAll());

            ViewBag.Message = "<h4>Your search results returned the following: </h4>";


            if (result.Total == 0)
            {

                return View("Index", new List<Post>());
            }

            return View("Index", result.Documents);
        }

        #region static property helper

        private static ElasticClient ElasticClient
        {
            get
            {

                var setting = new ConnectionSettings(new Uri("http://localhost:9200"));
                setting.SetDefaultIndex(INDEX);
                return new ElasticClient(setting);
            }
        }

        private static ElasticClient ElasticClient2
        {
            get
            {

                var setting = new ConnectionSettings(new Uri("http://localhost:9200"));
                setting.SetDefaultIndex("musicstore");
                return new ElasticClient(setting);
            }
        }

        #endregion
    }

    [Bind(Exclude = "AlbumId")]
    public class Album
    {
        [ScaffoldColumn(false)]
        public int AlbumId { get; set; }

        public int GenreId { get; set; }

        public int ArtistId { get; set; }

        [Required(ErrorMessage = "An Album Title is required")]
        [StringLength(160)]
        public string Title { get; set; }

        [Required(ErrorMessage = "Price is required")]
        [Range(0.01, 100.00,
            ErrorMessage = "Price must be between 0.01 and 100.00")]
        public decimal Price { get; set; }

        [StringLength(1024)]
        public string AlbumArtUrl { get; set; }

        public virtual Genre Genre { get; set; }
        public virtual Artist Artist { get; set; }
    }

    public class Artist
    {
        public int ArtistId { get; set; }
        public string Name { get; set; }
        public List<Album> Albums { get; set; }
    }

    public partial class Genre
    {
        public int GenreId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        [Newtonsoft.Json.JsonIgnore]
        public List<Album> Albums { get; set; }
    }

}