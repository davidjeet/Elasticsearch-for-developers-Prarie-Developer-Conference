using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Import.Console
{
    public class Movie
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public int Year { get; set; }

        public float Rating { get; set; }

        public string[] Genres { get; set; }
    }
}
