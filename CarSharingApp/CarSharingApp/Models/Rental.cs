using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Rentals")]
    public class Rental
    {
        [Key]
        public int RentalID { get; set; }

        [Required]
        public int UserID { get; set; }

        [Required]
        public int CarID { get; set; }

        [Required]
        public DateTime StartTime { get; set; }

        [Required]
        public DateTime EndTime { get; set; }

        public DateTime? ActualEndTime { get; set; }

        public decimal? TotalCost { get; set; }

        [Required, MaxLength(20)]
        public string Status { get; set; }

        [Required, MaxLength(20)]
        public string PaymentStatus { get; set; }

        // Навигационные свойства
        [ForeignKey("UserID")]
        public virtual User User { get; set; }

        [ForeignKey("CarID")]
        public virtual Car Car { get; set; }

        public virtual ICollection<Payment> Payments { get; set; }
    }
}