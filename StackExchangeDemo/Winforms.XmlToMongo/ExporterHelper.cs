using MongoDB.Driver;
using StackExchangeModel;
using System.Collections.Generic;
using System.Linq;

namespace Winforms.XmlToMongo
{
    public class ExporterHelper<T>  where T : class
    {
        private static MongoClient mongoClient;
        private static MongoServer mongoServer;
        private static MongoDatabase mongoDatabase;
        private static MongoCollection<T> mongoCollection;
        private static ExporterHelper<T> exportHelper;

        private static Dictionary<int, List<Comment>> CommentsLK = new Dictionary<int, List<Comment>>();
        private static Dictionary<int, Post> PostsLK = new Dictionary<int, Post>();
        private static Dictionary<int, Post> PostsToInsert = new Dictionary<int, Post>();

        private ExporterHelper() {}

        public static ExporterHelper<T> GetInstance()
        {
            if (exportHelper == null)
            {
                exportHelper = new ExporterHelper<T>();
                InitMongoDB();
            }
            return exportHelper;
        }

        public void ExportAllUsers(IEnumerable<T> users)
        {
            Export(users, "users");
        }

        public void ExportAllPostsAndComments(IEnumerable<Post> posts, IEnumerable<Comment> comments)
        {
            //1. Arrange comments in appropriate structure
            comments.ToList().ForEach(comment => 
            { 
                var key = comment.PostId.Value;
                if (CommentsLK.ContainsKey(key))
                {
                    CommentsLK[key].Add(comment); 
                }
                else
                {
                    CommentsLK.Add(key, new List<Comment> { comment });
                }
            });

            //2. Initialize post structure
            posts.ToList().ForEach(post =>
            {
                PostsLK.Add(post.Id, post);
            });

            //3. Assign comments to appropriate Posts structure
            foreach (var cKey in CommentsLK.Keys)
            {
                if (PostsLK.ContainsKey(cKey))
                {
                    PostsLK[cKey].Comments = CommentsLK[cKey];
                }
            }

            CommentsLK = null;

            //4. Fix Posts structure to use embedded (whoa)
            PostsLK.Values.ToList().ForEach(post =>
            {
                if (post.PostTypeId == 1)
                {
                    post.Answers = new List<Post>();
                    PostsToInsert.Add(post.Id, post);
                }
            });

            PostsLK.Values.ToList().ForEach(post =>
            {
                if (post.PostTypeId > 1 && post.ParentId.HasValue)
                {
                    //search for posts
                    var parentId = post.ParentId.Value;
                    if (PostsToInsert.ContainsKey(parentId))
                    {
                        PostsToInsert[parentId].Answers.Add(post);
                    }
                }
            });
       
            //5. load all the posts now
            var collectionName = "posts";
            var postCollection = mongoDatabase.GetCollection<Post>(collectionName);
            mongoDatabase.DropCollection(collectionName);
            foreach (var post in PostsToInsert.Values)
            {
                postCollection.Insert(post);
            }

        }


        private void Export(IEnumerable<T> collection, string collectionName)
        {
            mongoCollection = mongoDatabase.GetCollection<T>(collectionName);
            mongoDatabase.DropCollection(collectionName);
            collection.ToList().ForEach(x => { mongoCollection.Insert(x); });
        }

        private static void InitMongoDB()
        {
            mongoClient = new MongoClient("mongodb://localhost:27017");
            mongoServer = mongoClient.GetServer();
            mongoDatabase = mongoServer.GetDatabase("stackexchange");
        }
    }
}
