using System;
using System.Xml.Linq;

namespace Winforms.XmlToMongo
{
    public static class Extensions
    {
        public static string GetAttributeString(this XElement element, string elementName)
        {
            return element.Attribute(elementName) != null ? (string)element.Attribute(elementName) : null;
        }

        public static int? GetAttributeInteger(this XElement element, string elementName)
        {
            return element.Attribute(elementName) != null ? (int?)element.Attribute(elementName) : null;
        }

        public static DateTime? GetAttributeDate(this XElement element, string elementName)
        {
            return element.Attribute(elementName) != null ? (DateTime?)element.Attribute(elementName) : null;
        }
    }
}
