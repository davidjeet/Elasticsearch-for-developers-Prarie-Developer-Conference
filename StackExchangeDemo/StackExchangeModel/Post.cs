using System;
using System.Collections.Generic;

namespace StackExchangeModel
{
    public partial class Post
    {
        public int Id { get; set; }

        public int? PostTypeId { get; set; }

        public int? ParentId { get; set; }

        public int? AcceptedAnswerId { get; set; }

        public DateTime? CreationDate { get; set; }

        public int? Score { get; set; }

        public int? ViewCount { get; set; }

        public string Body { get; set; }

        public int? OwnerUserId { get; set; }

        public int? LastEditorUserId { get; set; }

        public DateTime? LastEditDate { get; set; }

        public string OwnerDisplayName { get; set; }
        
        public DateTime? LastActivityDate { get; set; }

        public string Title { get; set; }

        public string Tags { get; set; }

        public int? AnswerCount { get; set; }

        public int? FavoriteCount { get; set; }

        public int? CommentCount { get; set; }

        public DateTime? CommunityOwnedDate { get; set; }

        public List<Comment> Comments { get; set; }

        public List<Post> Answers { get; set; }

    }
}
