using System.Web;
using System.Web.Mvc;

namespace InfoTrack.Demos.Composite.NetFrameworkMvcApp
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
