using AppDevInterviewTechnicalTest.Models;
using AppDevInterviewTechnicalTest.Models.Db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppDevInterviewTechnicalTest.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var model = new HomeIndexModel();
            using (var db = new TicketsDbModel())
            {
                db.Configuration.AutoDetectChangesEnabled = false;
                db.Configuration.LazyLoadingEnabled = false;
                db.Configuration.ProxyCreationEnabled = false;
                model.Tickets = (from t in db.Tickets
                                 where t.StatusData.Title == "Open"
                                 select t).ToList();
            }

            return View(model);
        }


        [HttpGet]
        public ActionResult Create()
        {
            var model = new HomeCreateModel();
            return View(model);
        }

        [HttpPost]
        public ActionResult Create(HomeCreateModel inmodel)
        {
            var model = new HomeCreateModel();

            using (var db = new TicketsDbModel())
            {
                if (inmodel.Ticket != null)
                {
                    inmodel.Ticket.Id = 0;
                    inmodel.Ticket.DateTimeCreated = DateTime.Now;
                    inmodel.Ticket.CreatedByUser = db.Users.Where(u => u.Username == User.Identity.Name).FirstOrDefault();
                    inmodel.Ticket.DateTimeModified = inmodel.Ticket.DateTimeCreated;
                    inmodel.Ticket.ModifiedByUser = inmodel.Ticket.CreatedByUser;
                    model.Ticket = inmodel.Ticket;
                }

                if (ModelState.IsValid)
                {
                    db.Entry(inmodel.Ticket).State = System.Data.Entity.EntityState.Added;
                    db.SaveChanges();
                }
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }
            else
            {
                return RedirectToAction("Edit", new { id = model.Ticket.Id });
            }
        }

        [HttpGet]
        public ActionResult Edit(int? id)
        {
            var model = new HomeEditModel();

            using (var db = new TicketsDbModel())
            {
                db.Configuration.AutoDetectChangesEnabled = false;
                db.Configuration.LazyLoadingEnabled = false;
                db.Configuration.ProxyCreationEnabled = false;
                model.Ticket = (from t in db.Tickets
                                where t.Id == id
                                select t).FirstOrDefault();
            }

            if (model.Ticket == null)
            {
                return HttpNotFound();
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult Edit(HomeEditModel inmodel)
        {
            var model = new HomeEditModel();

            using (var db = new TicketsDbModel())
            {
                var id = inmodel?.Ticket.Id ?? 0;
                model.Ticket = (from t in db.Tickets
                                where t.Id == id
                                select t).FirstOrDefault();

                if (model.Ticket == null)
                {
                    return HttpNotFound();
                }

                if (ModelState.IsValid)
                {
                    model.Ticket.DateTimeModified = DateTime.Now;
                    model.Ticket.ModifiedByUser = db.Users.Where(u => u.Username == User.Identity.Name).FirstOrDefault();
                    model.Ticket.Status = inmodel.Ticket.Status;
                    model.Ticket.Tag = inmodel.Ticket.Tag;
                    model.Ticket.Title = inmodel.Ticket.Title;
                    db.SaveChanges();
                }
            }

            if (!ModelState.IsValid)
            {
                model.Ticket = inmodel.Ticket;
                return View(model);
            }
            else
            {
                return RedirectToAction("Edit", new { id = model.Ticket.Id });
            }
        }

    }
}