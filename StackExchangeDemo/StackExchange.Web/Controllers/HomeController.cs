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
using System.Text;

namespace StackExchange.Web.Controllers
{
    public class HomeController : Controller
    {
        private static MongoClient mongoClient;
        private static MongoServer mongoServer;
        private static MongoDatabase mongoDatabase;
        private static MongoCollection<Post> mongoCollection;
        private const string INDEX = "stackexchange";
        private const string INDEXTYPE = "posts";

        public HomeController()
        {
            mongoClient = new MongoClient("mongodb://localhost:27017");
            mongoServer = mongoClient.GetServer();
            mongoDatabase = mongoServer.GetDatabase("stackexchange");
            ViewBag.Message = "";
        }

        public ActionResult Index()
        {
            mongoCollection = mongoDatabase.GetCollection<Post>(INDEXTYPE);
            var vm = mongoCollection.AsQueryable().OrderByDescending(x => x.CreationDate).Take(10);
            return View(vm);
        }

        public ActionResult ReIndex()
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();

            mongoCollection = mongoDatabase.GetCollection<Post>("posts");
            int counter = 0;
            foreach (var post in mongoCollection.FindAll())
            {
                var simplePost = new SimplePost { Title = post.Title, Body = post.Body, Answers = post.Answers, Id = post.Id, Tags = post.Tags, OwnerUserId = post.OwnerUserId };

                ElasticClient.IndexAsync(simplePost, i => i
                       .Index(INDEX)
                       .Type(INDEXTYPE)
                       .Id(simplePost.Id)
                   ////.Refresh()
                   ////.Ttl("1m")
                   );

                counter++;
            }

            sw.Stop();
            var result = string.Format("Time to re-index {0} records elasticsearch took: {1}.{2} seconds", counter, sw.Elapsed.Seconds, sw.Elapsed.Milliseconds);
            ViewBag.Message = result;
            Debug.WriteLine(result);

            return View();
        }

        [HttpPost]
        public ActionResult FullTextSearch(string q, bool addHighlights = false)
        {
            QueryContainer query = new TermQuery
            {
                Field = "title",
                Value = q
            };

            QueryContainer query2 = new TermQuery
            {
                Field = "body",
                Value = q
            };

            QueryContainer query3 = new FuzzyQuery
            {
                PrefixLength = 2,
                Field = "body",
                Value = q
            };


            Highlight highlight = new Highlight
            {
                Fields = new FluentDictionary<Field, IHighlightField>
                {
                    { "body",
                        new HighlightField {
                            PreTags = new List<string> {"<b><em><font color='red'>"},
                            PostTags = new List<string> {"</font></em></b>"}}
                    }
                }
            };


            var searchRequest = new SearchRequest
            {
                From = 0,
                Size = 9,
                Query = query3, //query | query2,
                Highlight = highlight,
                //Filter = ...
            };

            var result = ElasticClient.Search<Post>(searchRequest);


            var posts = new List<Post>();
            if (result.Documents.Count() > 0)
            {
                posts = result.Documents.ToList();
            }

            if (result.Highlights.Count() > 0)
            {
                foreach (var key in result.Highlights.Keys)
                {
                    var doc = result.Highlights[key];

                }
            }


            return View("Index", posts);
        }

        #region static property helper

        private static ElasticClient ElasticClient
        {
            get
            {
                var setting = new ConnectionSettings(new Uri("http://localhost:9200"));
                setting.DefaultIndex(INDEX);
                return new ElasticClient(setting);
            }
        }

        #endregion



        #region Deprecated

        //Highlight highlight = new HighlightRequest
        //{
        //    Fields = new FluentDictionary<PropertyPathMarker, IHighlightField>
        //{
        //    {
        //        Property.Path<Post>(p => p.Name),
        //        new HighlightField {PreTags = new List<string> {"<tag>"}, PostTags = new List<string> {"</tag>"}}
        //    }
        //}
        //};


        ////var highlight = new Highlight
        ////{
        ////    PreTags = new string[] { "<b><em><font color='purple'>" },
        ////    PostTags = new string[] { "</font></em></b>" },
        ////    Fields = new Dictionary<Field, IHighlightField> { { "body", null }  }
        ////};

        ////    .OnFields(f => f
        ////    .OnField(e => e.Body)
        ////    .PreTags("<b><em><font color='red'>")
        ////    .PostTags("</font></em></b>")


        ////string resultTxt = Encoding.UTF8.GetString(docs.RequestInformation.Request);

        ////var result2 = ElasticClient.Search<Post>(s => s
        ////        .From(0)
        ////        .Size(5)
        ////        .Query(term => term.Term( "title" , q)
        ////        )
        ////);
        ////resultTxt = Encoding.UTF8.GetString(docs.RequestInformation.Request);


        ////#region Elasticsearch query

        ////var articles = ElasticClient.Search<Post>(s => s
        ////.From(0)
        ////.Size(1000)
        ////.Query(q => q.(d => d
        ////    .Fuzzy(fz => fz.OnField("field").Value("book").MaxExpansions(2))
        ////    ));



        ////var docs = ElasticClient.Search<Post>(b => b
        ////     .Index(INDEX)
        ////     .Type(INDEXTYPE).
        ////     .Query(q => q.Fuzzy(fz => fz.Field("Body")


        ////.LikeText("myBook")
        ////        .MaxQueryTerms(12)
        ////        .OnFields(new[] { "Body" })
        //        )
        //    )
        //);

        //string result = Encoding.UTF8.GetString(docs.RequestInformation.Request);
        //System.Diagnostics.Debug.WriteLine(result);

        //Fuzziness.EditDistance(5);
        //Fuzziness.Ratio(0.5);
        //var fuzz = new Fuzziness();


        //var result2 = ElasticClient.Search<Post>(x => x.Query(query
        //                                    => query.Fuzzy(fz
        //                                        => fz.Field(f
        //                                            => f.Title).Value(q)
        //                                        .Fuzziness(new Fuzziness())  // choose a value between 0-1                                                    
        //                                        .PrefixLength(2) // first two characters are not considered
        //                                       )).Take(5));


        ////var result2 = ElasticClient.Search<Post>(x => x.Query(query
        ////                                    => query.Fuzzy(fz
        ////                                        => fz.Field(f
        ////                                            => f.Title).Value(q)
        ////                                        .Fuzziness(new Fuzziness())  // choose a value between 0-1                                                    
        ////                                        .PrefixLength(2) // first two characters are not considered
        ////                                       )).Take(5));


        ////.Highlight(h => h
        ////    .OnFields(f => f
        ////    .OnField(e => e.Body)
        ////    .PreTags("<b><em><font color='red'>")
        ////    .PostTags("</font></em></b>")
        ////    ))


        ////    .Take(5)

        ////  );

        ////#endregion

        ////#region Viewmodel manipulation

        ////ViewBag.Message = string.Format("<h4>Your search results returned {0}/{1} results: </h4>", result.Documents.Count(), result.Total);


        ////if (result.Total == 0)
        ////{

        ////    return View("Index", new List<Post>());
        ////}

        ////List<Post> posts = new List<Post>();
        ////if (true)
        ////{
        ////    foreach (var doc in result.Highlights.Values)
        ////    {
        ////        string id ="";
        ////        StringBuilder fragments = new StringBuilder();
        ////        foreach (var key in doc.Keys)
        ////        {
        ////            Highlight item = doc[key];
        ////            id = item.DocumentId;
        ////            foreach(string highlight in item.Highlights)
        ////            {
        ////                fragments.AppendFormat("<h1>{0}</h1>", highlight);
        ////            }


        ////        }
        ////        var newPost = result.Documents.SingleOrDefault(x => x.Id.ToString() == id);
        ////        newPost.Body = fragments.ToString();
        ////        posts.Add(newPost);
        ////    }
        ////}
        ////else
        ////{
        ////    var postIds = result.Documents.Select(doc => doc.Id).ToList();
        ////    mongoCollection = mongoDatabase.GetCollection<Post>("posts");
        ////    posts = mongoCollection.AsQueryable().Where(p => p.Id.In( postIds )).ToList(); 
        ////}
        #endregion
    }
}