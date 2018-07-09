using Microsoft.AspNetCore.Mvc;

namespace InfoTrack.Demos.Composite.Composer.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index(string type, string fragment)
        {
            ViewBag.Composite = $"<!--# include {type}=\"{fragment}\" -->";
            return View();
        }
    }
}
