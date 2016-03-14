using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Elasticsearch.Net;

namespace Nest.Demo
{
    public class Movie2 
    {
        public string Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public DateTime CreatedOn { get; set; }

        public bool AvailableOnNetflix { get; set; }
    }
}
