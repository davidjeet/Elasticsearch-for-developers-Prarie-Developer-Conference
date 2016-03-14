using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MVC5.Web.UI.Startup))]
namespace MVC5.Web.UI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
