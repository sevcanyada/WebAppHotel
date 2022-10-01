using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using WebAppHotel.Models;
using WebAppHotel.ViewModel;

namespace WebAppHotel.Controllers
{
    public class BookingController : Controller
    {
        private HotelDBEntities objHotelDbEntitites;
        public BookingController()
        {
            objHotelDbEntitites = new HotelDBEntities();
        }

        public decimal TotalAmount { get; private set; }

        public ActionResult Index()
        {
            BookingViewModel objBookingViewModel = new BookingViewModel();
            objBookingViewModel.ListOfRooms = objHotelDbEntitites.Rooms.ToList().Select(x=> new SelectListItem()
            {
                Text = x.RoomNumber,
                Value = x.RoomId.ToString()
            });
            objBookingViewModel.BookingFrom = DateTime.Now;
            objBookingViewModel.BookingTo = DateTime.Now.AddDays(1);
            return View(objBookingViewModel);
        }
        [HttpPost]
        public ActionResult Index(BookingViewModel objBookingViewModel)
        {
            int numberOfDays = Convert.ToInt32((objBookingViewModel.BookingTo - objBookingViewModel.BookingFrom).TotalDays);
            Room objRoom = objHotelDbEntitites.Rooms.Single(model => model.RoomId == objBookingViewModel.AssignRoomId);
            decimal RoomPrice = objRoom.RoomPrice;
            decimal TotalPrice = RoomPrice * numberOfDays;
            RoomBooking roomBooking = new RoomBooking()
            {
                BookingFrom = objBookingViewModel.BookingFrom,
                BookingTo = objBookingViewModel.BookingTo,
                AssingRoomId = objBookingViewModel.AssignRoomId,
                CustomerAddress = objBookingViewModel.CustomerAddress,
                CustomerName = objBookingViewModel.CustomerName,
                NoOfMembers = objBookingViewModel.NumberOfMembers,
                TotalAmount = TotalAmount

            };
            objHotelDbEntitites.RoomBookings.Add(roomBooking);
            objHotelDbEntitites.SaveChanges();



            objRoom.BookingStatusId = 3;
            objHotelDbEntitites.SaveChanges();

            return Json(data: new { message = "Hotel Booking is Successfully Created.", success = true }, JsonRequestBehavior.AllowGet);
        }
        public PartialViewResult GetAllBookingHistory()
        {
            List<RoomBookingViewModel> listOfBookingViewModels = new List<RoomBookingViewModel>();
            listOfBookingViewModels = (from objHotelBooking in objHotelDbEntitites.RoomBookings
                                       join objRoom in objHotelDbEntitites.Rooms on objHotelBooking.AssingRoomId equals objRoom.RoomId
                                       select new RoomBookingViewModel()
                                       {
                                           BookingFrom = objHotelBooking.BookingFrom,
                                           BookingTo = objHotelBooking.BookingTo,
                                           CustomerPhone = objHotelBooking.CustomerPhone,
                                           CustomerName = objHotelBooking.CustomerName,
                                           TotalAmount = objHotelBooking.TotalAmount,
                                           CustomerAddress = objHotelBooking.CustomerAddress,
                                           NumberOfMembers = objHotelBooking.NumberOfMembers,
                                           BookingId = objHotelBooking.BookingId,
                                           RoomNumber = objRoom.RoomNumber,
                                           RoomPrice = objRoom.RoomPrice,
                                           NuberOfMembers = System.Data.Entity.DbFunctions.DiffDays(objHotelBooking.BookingFrom,objHotelBooking.BookingTo).Value

                                       }).ToList();
            return PartialView(" _BookingHistoryPartial", listOfBookingViewModels);

        }
        

        public ActionResult Add()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Add(BookingViewModel objBookingViewModel)
        {
            return View();
        }


    }
}
                                       
       