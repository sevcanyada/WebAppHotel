using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;

namespace WebAppHotel.ViewModel
{
    public interface IRoomViewModel
    {
        int BookingStatusId { get; set; }
        HttpPostedFileBase Image { get; set; }
        List<SelectListItem> ListOfBookingStatus { get; set; }
        List<SelectListItem> ListOfRoomType { get; set; }
        int RoomCapacity { get; set; }
        string RoomDescription { get; set; }
        int RoomId { get; set; }
        string RoomImage { get; set; }
        string RoomNumber { get; set; }
        decimal RoompPrice { get; set; }
        int RoomTypeId { get; set; }
    }
}