using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Elasticsearch.Net;

namespace ElasticsearchNet.Demo
{
    public class Movie 
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public DateTime CreatedOn { get; set; }

        public bool AvailableOnNetflix { get; set; }
    }
}
