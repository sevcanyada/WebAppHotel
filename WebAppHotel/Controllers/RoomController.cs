using System;
using System.Collections.Generic;
using System.EnterpriseServices.Internal;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using WebAppHotel.Models;
using WebAppHotel.ViewModel;

namespace WebAppHotel.Controllers
{
    public class RoomController : Controller
    {
        public HotelDBEntities objHotelDBEntities;
        public RoomController()
        {
            objHotelDBEntities = new HotelDBEntities();
        }
        public ActionResult Index()
        {
            RoomViewModel objRoomViewModel = new RoomViewModel();
            objRoomViewModel.ListOfBookingStatus = (from obj in objHotelDBEntities.BookingStatus
                                                    select new SelectListItem()
                                                    {
                                                        Text = obj.BookingStatus,
                                                        Value = obj.BookingStatusId.ToString()

                                                    }).ToList();
            objRoomViewModel.ListOfRoomType = (from obj in objHotelDBEntities.RoomTypes
                                               select new SelectListItem()
                                               {
                                                   Text = obj.RoomTypeName,
                                                   Value = obj.RoomTypeID.ToString()

                                               }).ToList();



            return View(objRoomViewModel);
        }
        [HttpPost]
        public ActionResult Index(RoomViewModel objRoomViewModel)//oda görünümü model
        {
            string message = String.Empty;
            string ImageUniqueName = String.Empty;
            string ActualImageName = String.Empty;
            if (objRoomViewModel.RoomId == 0)
            {
                ImageUniqueName = Guid.NewGuid().ToString();//string resim adını yazdım.
                ActualImageName = ImageUniqueName + Path.GetExtension(objRoomViewModel.Image.FileName);//gerçek resim ismimiz
                                                                                                              //SaveAs ile kaydediyorum ve harita yolu olucak!
                objRoomViewModel.Image.SaveAs(filename: Server.MapPath("~/RoomImages/" + ActualImageName));//klasör olsurudum oda görüntüleri burada olucak.Kaydedilecek.
                Room objRoom = new Room()
                {
                    RoomNumber = objRoomViewModel.RoomNumber,
                    RoomDescription = objRoomViewModel.RoomDescription,
                    RoomPrice = objRoomViewModel.RoomPrice,
                    BookStatusId = objRoomViewModel.BookingStatusId,
                    IsActive = true,
                    RoomImage = ActualImageName,
                    RoomCapacity = objRoomViewModel.RoomCapacity,
                    RoomTypeId = objRoomViewModel.RoomTypeId
                };
                objHotelDBEntities.Rooms.Add(objRoom);
                message = "Added.";
            }
            else
            {
                Room objRoom = objHotelDBEntities.Rooms.Single(model => model.RoomId == objRoomViewModel.RoomId);

                if (objRoomViewModel.Image !=null)
                {
                    ImageUniqueName = Guid.NewGuid().ToString();//string resim adını yazdım.
                    ActualImageName = ImageUniqueName + Path.GetExtension(objRoomViewModel.Image.FileName);//gerçek resim ismimiz
                    objRoomViewModel.Image.SaveAs(filename: Server.MapPath("~/RoomImages/" + ActualImageName));//klasör olsurudum oda görüntüleri burada olucak.Kaydedilecek.
                    objRoom.RoomImage = ActualImageName;    //objRoom.RoomImage = ActualImageName;
                }
                //SaveAs ile kaydediyorum ve harita yolu olucak!
                objRoom.RoomNumber = objRoomViewModel.RoomNumber;
                objRoom.RoomDescription = objRoomViewModel.RoomDescription;
                objRoom.RoomPrice = objRoomViewModel.RoomPrice;
                objRoom.BookStatusId = objRoomViewModel.BookingStatusId;
                objRoom.IsActive = true;
                objRoom.RoomCapacity = objRoomViewModel.RoomCapacity;
                objRoom.RoomTypeId = objRoomViewModel.RoomTypeId;
                message = "Updated.";

            }
            objHotelDBEntities.SaveChanges();

            return Json(data: new { message = "Romm Successfulyy "+ message, success = true }, JsonRequestBehavior.AllowGet);//ilk kaydedeceğim, bu verinin doğru gelip gelmediğini değiştireceğiz.

        }
        public PartialViewResult GetAllRooms()
        {
            IEnumerable<RoomDetailsViewModel> listOfRoomDetailsViewModels =
                 (from objRoom in objHotelDBEntities.Rooms
                  join objBooking in objHotelDBEntities.BookingStatus on objRoom.BookStatusId equals objBooking.BookingStatusId
                  join objRoomType in objHotelDBEntities.RoomTypes on objRoom.RoomTypeId equals objRoomType.RoomTypeID
                  where objRoom.IsActive == true
                  select new RoomDetailsViewModel()
                  {
                      RoomNumber = objRoom.RoomNumber,
                      RoomDescription = objRoom.RoomDescription,
                      RoomCapacity = objRoom.RoomCapacity,
                      RoomPrice = objRoom.RoomPrice,
                      BookingStatus = objBooking.BookingStatus,
                      RoomType = objRoomType.RoomTypeName,
                      RoomImage = objRoom.RoomImage,
                      RoomId = objRoom.RoomId

                  }).ToList();
            return PartialView("_RoomDetailsPartial", listOfRoomDetailsViewModels);
        }
        [HttpGet]
        public JsonResult EditRoomDetails(int roomId)
        {
            var result = objHotelDBEntities.Rooms.Single(model => model.RoomId == roomId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]

        public JsonResult DeleteRoomDetails(int roomId)
        {
            Room objRoom = objHotelDBEntities.Rooms.Single(model => model.RoomId == roomId);
            objRoom.IsActive = false;
            objHotelDBEntities.SaveChanges();
            return Json(data: new { message = "Record Successfully Deleted.", success = true }, JsonRequestBehavior.AllowGet);

        }
    }

}
