using InfoTrack.Demos.Composite.NetCoreMvcApp.Areas.NetCoreMvcApp.Models.Home;
using Microsoft.AspNetCore.Mvc;

namespace InfoTrack.Demos.Composite.NetCoreMvcApp.Areas.NetCoreMvcAppArea.Controllers
{
    [Area("NetCoreMvcApp")]
    public class HomeController : Controller
    {
        [HttpGet]
        public IActionResult Index()
        {
            var viewModel = new HomeViewModel();
            return View(viewModel);
        }

        [HttpPost]
        public IActionResult Index(HomeViewModel viewModel)
        {
            return View(viewModel);
        }
    }
}