using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Payments")]
    public class Payment
    {
        [Key]
        public int PaymentID { get; set; }

        [Required]
        public int RentalID { get; set; }

        [Required]
        public decimal Amount { get; set; }

        [Required]
        public DateTime PaymentTime { get; set; }

        [Required, MaxLength(20)]
        public string PaymentMethod { get; set; }

        [Required, MaxLength(20)]
        public string Status { get; set; }

        // Навигационные свойства
        [ForeignKey("RentalID")]
        public virtual Rental Rental { get; set; }
    }
}