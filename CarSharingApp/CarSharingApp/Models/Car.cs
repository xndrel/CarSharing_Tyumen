using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Cars")]
    public class Car
    {
        [Key]
        public int CarID { get; set; }

        [Required]
        public int ModelID { get; set; }

        [Required, MaxLength(20)]
        public string RegistrationNumber { get; set; }

        [Required, MaxLength(30)]
        public string Color { get; set; }

        [Required]
        public decimal PricePerMinute { get; set; }

        [Required]
        public int FuelLevel { get; set; }

        public decimal? Latitude { get; set; }

        public decimal? Longitude { get; set; }

        [Required]
        public bool IsAvailable { get; set; }

        [MaxLength(255)]
        public string ImageURL { get; set; }

        public DateTime? LastMaintenance { get; set; }

        // Навигационные свойства
        [ForeignKey("ModelID")]
        public virtual CarModel Model { get; set; }

        public virtual ICollection<Rental> Rentals { get; set; }
    }
}