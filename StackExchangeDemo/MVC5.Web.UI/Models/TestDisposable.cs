using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Diagnostics;

namespace MVC5.Web.UI.Models
{
    public class TestDisposable : IDisposable
    {

        private bool _hasDisposed = false;

        private StreamReader sr;


        public string ShowSomething()
        {
            sr = new StreamReader(@"C:\temp\TrafficStopsSample.csv");
            var txt = sr.ReadLine();
            return txt;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (this._hasDisposed == false)
            {
                if (disposing)
                {
                    sr.Dispose();
                }
            }
            this._hasDisposed = true;
        }
    }
}