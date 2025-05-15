using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Announcements")]
    public class Announcement
    {
        [Key]
        public int AnnouncementID { get; set; }

        [Required]
        public int CreatedBy { get; set; }

        [Required, MaxLength(100)]
        public string Title { get; set; }

        [Required]
        public string Content { get; set; }

        [Required]
        public DateTime CreatedAt { get; set; }

        [Required]
        public bool IsActive { get; set; }

        // Навигационные свойства
        [ForeignKey("CreatedBy")]
        public virtual User Creator { get; set; }
    }
}