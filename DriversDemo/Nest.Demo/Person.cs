using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Elasticsearch.Net;

namespace Nest.Demo
{
    public class Person 
    {
        public int Id { get; set; }

        public string First { get; set; }

        public string Last { get; set; }

        public int Age { get; set; }

        public DateTime? LastUpdatedOn { get; set; }

    }
}
