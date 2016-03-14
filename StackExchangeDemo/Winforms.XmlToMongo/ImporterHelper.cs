using StackExchangeModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.Linq;

namespace Winforms.XmlToMongo
{
    public static class ImporterHelper<T>  where T : class
    {
        public static IEnumerable<User> GetAllUsers(string stackDirectory)
        {
            return GetAll(Path.Combine(stackDirectory, "Users.xml"), GetUser);
        }

        public static IEnumerable<Post> GetAllPosts(string stackDirectory)
        {
            return GetAll(Path.Combine(stackDirectory, "Posts.xml"), GetPost);
        }

        public static IEnumerable<Comment> GetAllComments(string stackDirectory)
        {
            return GetAll(Path.Combine(stackDirectory, "Comments.xml"), GetComment);
        }

        private static IEnumerable<T> GetAll<T>(string stackDirectory, Func<XElement, T> converter)
        {
            using (XmlReader reader = XmlReader.Create(stackDirectory))
            {
                reader.MoveToContent();
                while (reader.Read())
                {
                    if (reader.NodeType == XmlNodeType.Element)
                    {
                        var element = XElement.ReadFrom(reader) as XElement;
                        if (element != null)
                        {
                            yield return converter.Invoke(element);
                        }
                    }
                }
                reader.Close();
            }
        }

        private static User GetUser(XElement element)
        {
            return new User
            {
                Id = (int)element.Attribute("Id"),
                Reputation = (int)element.Attribute("Reputation"),
                CreationDate = (DateTime)element.Attribute("CreationDate"),
                DisplayName = (string)element.Attribute("DisplayName"),
                LastAccessDate = (DateTime)element.Attribute("LastAccessDate"),
                WebsiteUrl = (string)element.Attribute("WebsiteUrl"),
                Location = (string)element.Attribute("Location"),
                AboutMe = (string)element.Attribute("AboutMe"),
                Views = (int)element.Attribute("Views"),
                UpVotes = (int)element.Attribute("UpVotes"),
                DownVotes = (int)element.Attribute("DownVotes"),
                AccountId = (int)element.Attribute("AccountId")
            };
        }

        private static Post GetPost(XElement element)
        {
            Post p = new Post
            {
                Id = (int)element.Attribute("Id"),
                ParentId = element.GetAttributeInteger("ParentId"),
                PostTypeId = element.GetAttributeInteger("PostTypeId"),
                AcceptedAnswerId = element.GetAttributeInteger("AcceptedAnswerId"),
                CreationDate = element.GetAttributeDate("CreationDate"),
                Score = element.GetAttributeInteger("Score"),
                ViewCount = element.GetAttributeInteger("ViewCount"),
                Body = element.GetAttributeString("Body"),
                OwnerUserId = element.GetAttributeInteger("OwnerUserId"),
                LastEditorUserId = element.GetAttributeInteger("LastEditorUserId"),
                LastEditDate = element.GetAttributeDate("LastEditDate"),
                OwnerDisplayName = element.GetAttributeString("OwnerDisplayName"),
                LastActivityDate = element.GetAttributeDate("LastActivityDate"),
                Title = element.GetAttributeString("Title"),
                Tags = element.GetAttributeString("Tags"),
                AnswerCount = element.GetAttributeInteger("AnswerCount"),
                FavoriteCount = element.GetAttributeInteger("FavoriteCount"),
                CommentCount = element.GetAttributeInteger("CommentCount"),
                CommunityOwnedDate = element.GetAttributeDate("CommunityOwnedDate")
            };
            return p;
        }

        private static Comment GetComment(XElement element)
        {
            return new Comment
            {
                Id = (int)element.Attribute("Id"),
                PostId =  element.GetAttributeInteger("PostId"),
                CreationDate = element.GetAttributeDate("CreationDate"),
                Score = element.GetAttributeInteger("Score"),
                Text = element.GetAttributeString("Text"),
                UserDisplayName = element.GetAttributeString("UserDisplayName"),
                UserId = element.GetAttributeInteger("UserId")
            };
        }

    }
}
