using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("CarModels")]
    public class CarModel
    {
        [Key]
        public int ModelID { get; set; }

        [Required]
        public int BrandID { get; set; }

        [Required]
        public int TypeID { get; set; }

        [Required, MaxLength(50)]
        public string ModelName { get; set; }

        [Required]
        public int Year { get; set; }

        // Навигационные свойства
        [ForeignKey("BrandID")]
        public virtual CarBrand Brand { get; set; }

        [ForeignKey("TypeID")]
        public virtual CarType Type { get; set; }

        public virtual ICollection<Car> Cars { get; set; }
    }
}
