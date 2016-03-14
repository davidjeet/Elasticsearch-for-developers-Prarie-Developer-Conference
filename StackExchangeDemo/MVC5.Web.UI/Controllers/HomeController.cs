using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//using ChinookModel;
using System.Diagnostics;
using MVC5.Web.UI.Models;
using System.Xml.Linq;

namespace MVC5.Web.UI.Controllers
{
    public class HomeController : Controller
    {
         private  ChinookEntities storeDB = new ChinookEntities();
        public ActionResult Index()
        {
           
        }

        public ActionResult Index()
        {
            // Get most popular albums
            var albums = GetTopSellingAlbums(5);

            return View(albums);
        }
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }




        #region testing

        public ActionResult JustATest()
        {
            using (var td = new TestDisposable())
            {
                var txt = td.ShowSomething();
                Debug.WriteLine(txt);
            }

            ////using (var ctx = new ChinookDB())
            ////{
            ////    //var albums = ctx.Album.Take(5);
            ////    var albums = ctx.Albums.Where(x => x.Title.StartsWith("C"));
            ////    var customer = ctx.Customers.FirstOrDefault(x => x.CustomerId == 3);
            ////    if (customer != null)
            ////    {
            ////        var elem = XDocument.Parse(customer.Misc, LoadOptions.None);
            ////        IEnumerable<string> names =
            ////            from item in elem.Descendants("name")
            ////            select (string)item.Attribute("gender");

            ////        foreach (var gender in names)
            ////        {
            ////            Debug.WriteLine("stuff: " + gender);
            ////        }

            ////    }

            ////    Debug.WriteLine("Albums: " + albums.Count());
            ////    Debug.WriteLine("First One: " + albums.FirstOrDefault().Title);


            ////    customer = ctx.Customers.FirstOrDefault(x => x.CustomerId == 4);
            ////    XElement contacts =
            ////            new XElement("Contacts",
            ////                new XElement("Contact",
            ////                    new XElement("Name", "Patrick Hinezzzzzz"),
            ////                    new XElement("Phone", "206-555-0144",
            ////                        new XAttribute("Type", "Home")),
            ////                    new XElement("phone", "425-555-0145",
            ////                        new XAttribute("Type", "Work")),
            ////                    new XElement("Address",
            ////                        new XElement("Street1", "123 Main St"),
            ////                        new XElement("City", "Mercer Island"),
            ////                        new XElement("State", "WA"),
            ////                        new XElement("Postal", "68042")
            ////                    )
            ////                  )
            ////             );

            ////    customer.Misc = contacts.ToString();
            ////    ctx.Entry(customer).State = System.Data.Entity.EntityState.Modified;
            ////    ctx.SaveChanges();

            ////    //another way to do updates (non xml column, just practicing update technique)
            ////    customer = ctx.Customers.FirstOrDefault(x => x.CustomerId == 5);
            ////    customer.LastName += "_X"; //pretend the user made the change on the web form
            ////    // on post back

            ////    ctx.Customers.Attach(customer);
            ////    ctx.Entry(customer).State = System.Data.Entity.EntityState.Modified;
            ////    ctx.SaveChanges();

            ////}
            return View();
        }

        #endregion
    }
}