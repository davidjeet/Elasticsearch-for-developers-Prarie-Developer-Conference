using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using Nest;

namespace Import.Console
{
    class Program
    {
        const string moviesFile = "ratings-top250-list.txt";
        const string genresFile = "genres.list.txt";
        const string index = "imdb";
        const string type = "movies";


        static readonly char[] spaceDelim = " ".ToCharArray();
        static readonly char[] tabDelim = "\t".ToCharArray();

        private static Dictionary<string, Movie> movieDict;

        static void Main(string[] args)
        {
            var rows = File.ReadLines(moviesFile);
            movieDict = new Dictionary<string, Movie>();
            int id = 0;

            // PART A: Get everything but genre
            foreach (var row in rows)
            {
                id++;
                Movie movie = new Movie { Id = id };
                var line = new Stack<string>(row.Split(spaceDelim, StringSplitOptions.RemoveEmptyEntries));

                // 1. get year
                int year;
                if (Int32.TryParse(Regex.Replace(line.Pop(), "[()]", ""), out year))
                {
                    movie.Year = year;
                }

                // 2. get rating
                var list_2 = new List<string>(line);
                list_2.Reverse();
                float rating;
                if (Single.TryParse(list_2[2], out rating))
                {
                    movie.Rating = rating;
                }

                // 3. get title
                list_2.RemoveRange(0, 3);
                movie.Title = string.Join(" ", list_2);

                string key = string.Format("{0} ({1})", movie.Title, movie.Year);
                movieDict.Add(key, movie);
            }


            // PART B: Get genre
            rows = File.ReadLines(genresFile);
            foreach (var row in rows)
            {
                if (string.IsNullOrEmpty(row)) continue;
                var line = row.Split(tabDelim, StringSplitOptions.RemoveEmptyEntries);
                var key = line[0];
                if (movieDict.ContainsKey(key))
                {
                    Movie movie = movieDict[key];
                    List<string> generes = (movie.Genres == null || movie.Genres.Length == 0)
                                         ? new List<string>()
                                         : new List<string>(movie.Genres);
                    generes.Add(line[1]);
                    movie.Genres = generes.ToArray();
                    movieDict[key] = movie;
                }
            }


            // PART C: Put in Elasticsearch
            InsertToElasticSearch();


            System.Console.WriteLine("Complete: {0} rows inserted", movieDict.Count);
            System.Console.ReadKey();
        }


        private static void InsertToElasticSearch()
        {
            var node = new Uri("http://localhost:9200");
            var settings = new ConnectionSettings(node);
            //var client = new ElasticLowLevelClient(settings);
            var client = new ElasticClient(settings);

            foreach (Movie movie in movieDict.Values)
            {
                ////System.Console.WriteLine(movie.Title);
                ////System.Console.WriteLine(movie.Rating);
                ////System.Console.WriteLine(movie.Year);

                ////if (movie.Generes != null)
                ////{
                ////    movie.Generes.ToList().ForEach(genre => System.Console.WriteLine("==>{0}", genre));
                ////}
                ////client.Index<Movie>(index, type, new PostData<Movie>(movie));


                var indexAdded = client.Index(movie, i => i
                    .Index(index)
                    .Type(type)
                    .Id(movie.Id)
                    ////.Refresh()
                    ////.Ttl("1m")
                );

                System.Console.WriteLine("Added Id: {0}", indexAdded.Id);
            }

        }
    }
}
