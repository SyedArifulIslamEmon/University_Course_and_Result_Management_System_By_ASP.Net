using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(UniversityAndResultSystemPro2.Startup))]
namespace UniversityAndResultSystemPro2
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
