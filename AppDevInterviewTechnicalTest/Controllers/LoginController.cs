using AppDevInterviewTechnicalTest.Models;
using AppDevInterviewTechnicalTest.Models.Db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace AppDevInterviewTechnicalTest.Controllers
{
    [AllowAnonymous]
    public class LoginController : Controller
    {

        [HttpGet]
        public ActionResult Index()
        {
            return View(new LoginModel());
        }

        [HttpPost]
        public ActionResult Index(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                using (var db = new TicketsDbModel())
                {
                    // NOTE: We are not implementing a password for login, as this is just a test framework and not meant for actual production use
                    var user = (from u in db.Users
                                where u.Username == model.Username
                                select u).FirstOrDefault();
                    if (user == null)
                    {
                        ModelState.AddModelError(nameof(model.Username), "Could not log in with specified username.");
                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(model.Username, false, VirtualPathUtility.ToAbsolute("~/"));
                    }
                }
            }

            if (!ModelState.IsValid)
            {
                return View(new LoginModel());
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

    }
}