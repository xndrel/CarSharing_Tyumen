using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("CarTypes")]
    public class CarType
    {
        [Key]
        public int TypeID { get; set; }

        [Required, MaxLength(50)]
        public string TypeName { get; set; }

        [MaxLength(255)]
        public string Description { get; set; }

        // Навигационные свойства
        public virtual ICollection<CarModel> CarModels { get; set; }
    }
}