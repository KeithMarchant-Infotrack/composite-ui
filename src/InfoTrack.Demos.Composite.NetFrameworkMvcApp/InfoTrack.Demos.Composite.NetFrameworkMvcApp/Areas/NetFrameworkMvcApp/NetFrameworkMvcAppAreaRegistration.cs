using System.Web.Mvc;

namespace InfoTrack.Demos.Composite.NetFrameworkMvcApp.Areas.NetFrameworkMvcApp
{
    public class NetFrameworkMvcAppAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "NetFrameworkMvcApp";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "NetFrameworkMvcApp_default",
                "NetFrameworkMvcApp/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}