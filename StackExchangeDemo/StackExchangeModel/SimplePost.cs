using System;
using System.Collections.Generic;

namespace StackExchangeModel
{
    public partial class SimplePost
    {
        public int Id { get; set; }

        public string Body { get; set; }

        public int? OwnerUserId { get; set; }

        public string Title { get; set; }

        public string Tags { get; set; }

        public List<Post> Answers { get; set; }

    }
}
