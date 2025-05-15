using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Messages")]
    public class Message
    {
        [Key]
        public int MessageID { get; set; }

        [Required]
        public int ChatID { get; set; }

        [Required]
        public int SenderID { get; set; }

        [Required]
        public string Text { get; set; }

        [Required]
        public DateTime SentTime { get; set; }

        [Required]
        public bool IsRead { get; set; }

        // Навигационные свойства
        [ForeignKey("ChatID")]
        public virtual SupportChat Chat { get; set; }

        [ForeignKey("SenderID")]
        public virtual User Sender { get; set; }
    }
}