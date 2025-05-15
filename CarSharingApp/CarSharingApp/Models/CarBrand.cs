using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("CarBrands")]
    public class CarBrand
    {
        [Key]
        public int BrandID { get; set; }

        [Required, MaxLength(50)]
        public string BrandName { get; set; }

        [Required, MaxLength(50)]
        public string CountryOfOrigin { get; set; }

        // Навигационные свойства
        public virtual ICollection<CarModel> CarModels { get; set; }
    }
}