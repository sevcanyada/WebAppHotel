using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.ComponentModel.DataAnnotations;
namespace WebAppHotel.ViewModel
{
    public class BookingViewModel
    {
        [Display(Name = "Customer Name")]
        [Required(ErrorMessage ="Customer name is required.")]
        public string CustomerName { get; set; }

        [Display(Name = "Customer Address")]
        [Required(ErrorMessage = "Customer  address name is required.")]


        public string CustomerAddress { get; set; }

        [Required(ErrorMessage = "Customer phone name is required.")]

        [Display(Name = "Customer Phone ")]

        public string CustomerPhone { get; set; }

        [Display(Name = "Booking From ")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString ="{0:dd:MMM-yyyy}",ApplyFormatInEditMode =true)]

        public DateTime BookingFrom{ get; set; }

        [Display(Name = "Booking To ")]
        [DataType(DataType.Date)]
        [Required(ErrorMessage = "Booking to  is required.")]
        [DisplayFormat(DataFormatString = "{0:dd:MMM-yyyy}", ApplyFormatInEditMode = true)]


        public DateTime  BookingTo{ get; set; }
        [Display(Name = "Assign Room ")]
        [Required(ErrorMessage = "Room  is required.")]

        public int AssignRoomId { get; set; }
        [Display(Name = "Number  of Members ")]
        [Required(ErrorMessage = "Number of member  is required.")]


        public int NumberOfMembers { get; set; }

        public IEnumerable<SelectListItem> ListOfRooms { get; set; }

    }
}