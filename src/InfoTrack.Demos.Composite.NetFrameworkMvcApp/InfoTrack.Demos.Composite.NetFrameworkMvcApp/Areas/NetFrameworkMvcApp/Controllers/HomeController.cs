using InfoTrack.Demos.Composite.NetFrameworkMvcApp.Areas.NetFrameworkMvcApp.Models;
using System.Web.Mvc;

namespace InfoTrack.Demos.Composite.NetFrameworkMvcApp.Areas.NetFrameworkMvcApp.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            var viewModel = new IndexViewModel();
            return View(viewModel);
        }

        [HttpPost]
        public ActionResult Index(IndexViewModel model)
        {
            return View(model);
        }
    }
}