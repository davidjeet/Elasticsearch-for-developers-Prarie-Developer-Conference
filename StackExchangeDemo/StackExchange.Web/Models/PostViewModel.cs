using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using StackExchangeModel;

namespace StackExchange.Web.Models
{
	public class PostViewModel : Post
	{
        public double? ElasticSearchScore { get; set; }

        ////public double? ElasticSearchScore { get; set; }
    }
}