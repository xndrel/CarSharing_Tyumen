using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("SupportChats")]
    public class SupportChat
    {
        [Key]
        public int ChatID { get; set; }

        [Required]
        public int UserID { get; set; }

        [Required]
        public DateTime CreatedAt { get; set; }

        [Required, MaxLength(20)]
        public string Status { get; set; }

        // Навигационные свойства
        [ForeignKey("UserID")]
        public virtual User User { get; set; }

        public virtual ICollection<Message> Messages { get; set; }
    }
}